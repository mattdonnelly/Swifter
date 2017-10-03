//
//  Swifter.swift
//  Swifter
//
//  Copyright (c) 2014 Matt Donnelly.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation
import Dispatch

#if os(macOS) || os(iOS)
import Accounts
#endif

extension Notification.Name {
    static let SwifterCallbackNotification: Notification.Name = Notification.Name(rawValue: "SwifterCallbackNotificationName")
}

// MARK: - Twitter URL
public enum TwitterURL {
    case api
    case upload
    case stream
    case userStream
    case siteStream
    case oauth
    
    var url: URL {
        switch self {
        case .api:          return URL(string: "https://api.twitter.com/1.1/")!
        case .upload:       return URL(string: "https://upload.twitter.com/1.1/")!
        case .stream:       return URL(string: "https://stream.twitter.com/1.1/")!
        case .userStream:   return URL(string: "https://userstream.twitter.com/1.1/")!
        case .siteStream:   return URL(string: "https://sitestream.twitter.com/1.1/")!
        case .oauth:        return URL(string: "https://api.twitter.com/")!
        }
    }
    
}

public class Swifter {
    
    // MARK: - Types

    public typealias SuccessHandler = (JSON) -> Void
    public typealias CursorSuccessHandler = (JSON, _ previousCursor: String?, _ nextCursor: String?) -> Void
    public typealias JSONSuccessHandler = (JSON, _ response: HTTPURLResponse) -> Void
    public typealias FailureHandler = (_ error: Error) -> Void

    public struct RawSuccessHandler {
        private let handler: (Data, FailureHandler?) -> Void

        // getting raw data
        public init(handler: @escaping (Data) -> Void) {
            self.handler = { data, _ in handler(data) }
        }

        // decoding raw data to a given type
        public init<Entity: Decodable>(decoding type: Entity.Type, handler: @escaping (Entity) -> Void) {
            self.handler = { data, failure in
                DispatchQueue.global(qos: .utility).async {
                    do {
                        let decodedResponse = try Swifter.decoder.decode(Entity.self, from: data)
                        DispatchQueue.main.async { handler(decodedResponse) }
                    } catch {
                        DispatchQueue.main.async { failure?(error) }
                    }
                }
            }
        }

        fileprivate func execute(on data: Data, failure: FailureHandler?) { handler(data, failure) }
    }

    internal struct CallbackNotification {
        static let optionsURLKey = "SwifterCallbackNotificationOptionsURLKey"
    }
    
    internal struct DataParameters {
        static let dataKey = "SwifterDataParameterKey"
        static let fileNameKey = "SwifterDataParameterFilename"
    }

    // MARK: - Static Properties

    internal static let decoder: JSONDecoder = {
        let decoder = JSONDecoder()

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "eee MMM dd HH:mm:ss ZZZZ yyyy"
        dateFormatter.locale = Locale(identifier: "en_US")

        decoder.dateDecodingStrategy = .formatted(dateFormatter)

        return decoder
    }()

    // MARK: - Properties
    
    public var client: SwifterClientProtocol

    // MARK: - Initializers
    
    public init(consumerKey: String, consumerSecret: String, appOnly: Bool = false) {
        self.client = appOnly
            ? AppOnlyClient(consumerKey: consumerKey, consumerSecret: consumerSecret)
            : OAuthClient(consumerKey: consumerKey, consumerSecret: consumerSecret)
    }

    public init(consumerKey: String, consumerSecret: String, oauthToken: String, oauthTokenSecret: String) {
        self.client = OAuthClient(consumerKey: consumerKey, consumerSecret: consumerSecret , accessToken: oauthToken, accessTokenSecret: oauthTokenSecret)
    }

    #if os(macOS) || os(iOS)
    public init(account: ACAccount) {
        self.client = AccountsClient(account: account)
    }
    #endif

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: - JSON Requests
    
    @discardableResult
    internal func jsonRequest(path: String, baseURL: TwitterURL, method: HTTPMethodType, parameters: Dictionary<String, Any>, uploadProgress: HTTPRequest.UploadProgressHandler? = nil, downloadProgress: JSONSuccessHandler? = nil, rawDownloadProgress: RawSuccessHandler? = nil, success: JSONSuccessHandler? = nil, rawSuccess: RawSuccessHandler? = nil, failure: HTTPRequest.FailureHandler? = nil) -> HTTPRequest {
        let jsonDownloadProgressHandler: HTTPRequest.DownloadProgressHandler = { data, _, _, response in
            if let downloadProgress = downloadProgress {
                RawSuccessHandler(decoding: JSON.self) { json in downloadProgress(json, response) }
                    .execute(on: data, failure: { _ in
                        let jsonString = String(data: data, encoding: .utf8)
                        let jsonChunks = jsonString!.components(separatedBy: "\r\n")

                        for chunk in jsonChunks where !chunk.utf16.isEmpty {
                            guard let chunkData = chunk.data(using: .utf8) else { continue }
                            RawSuccessHandler(decoding: JSON.self) { json in
                                downloadProgress(json, response)
                            }.execute(on: chunkData, failure: failure)
                        }
                    })
            }

            rawDownloadProgress?.execute(on: data, failure: failure)
        }

        let jsonSuccessHandler: HTTPRequest.SuccessHandler = { data, response in
            if let success = success {
                RawSuccessHandler(decoding: JSON.self) { json in
                    success(json, response)
                }.execute(on: data, failure: failure)
            }
            rawSuccess?.execute(on: data, failure: failure)
        }

        if method == .GET {
            return self.client.get(path, baseURL: baseURL, parameters: parameters, uploadProgress: uploadProgress, downloadProgress: jsonDownloadProgressHandler, success: jsonSuccessHandler, failure: failure)
        } else {
            return self.client.post(path, baseURL: baseURL, parameters: parameters, uploadProgress: uploadProgress, downloadProgress: jsonDownloadProgressHandler, success: jsonSuccessHandler, failure: failure)
        }
    }

    @discardableResult
    internal func getJSON(path: String, baseURL: TwitterURL, parameters: Dictionary<String, Any>, uploadProgress: HTTPRequest.UploadProgressHandler? = nil, downloadProgress: JSONSuccessHandler? = nil, rawDownloadProgress: RawSuccessHandler? = nil, success: JSONSuccessHandler?, rawSuccess: RawSuccessHandler? = nil, failure: HTTPRequest.FailureHandler?) -> HTTPRequest {
        return self.jsonRequest(path: path, baseURL: baseURL, method: .GET, parameters: parameters, uploadProgress: uploadProgress, downloadProgress: downloadProgress, rawDownloadProgress: rawDownloadProgress, success: success, rawSuccess: rawSuccess, failure: failure)
    }

    @discardableResult
    internal func postJSON(path: String, baseURL: TwitterURL, parameters: Dictionary<String, Any>, uploadProgress: HTTPRequest.UploadProgressHandler? = nil, downloadProgress: JSONSuccessHandler? = nil, rawDownloadProgress: RawSuccessHandler? = nil, success: JSONSuccessHandler?, rawSuccess: RawSuccessHandler? = nil, failure: HTTPRequest.FailureHandler?) -> HTTPRequest {
        return self.jsonRequest(path: path, baseURL: baseURL, method: .POST, parameters: parameters, uploadProgress: uploadProgress, downloadProgress: downloadProgress, rawDownloadProgress: rawDownloadProgress, success: success, rawSuccess: rawSuccess, failure: failure)
    }
    
}
