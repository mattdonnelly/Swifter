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

// MARK: - Tweet Mode
public enum TweetMode {
    case `default`
    case extended
    case compat
    case other(String)
    
    var stringValue: String? {
        switch self {
        case .default:
            return nil
        case .extended:
            return "extended"
        case .compat:
            return "compat"
        case .other(let string):
            return string
        }
    }
}

public class Swifter {
    
    // MARK: - Types

    public typealias SuccessHandler = (JSON) -> Void
    public typealias CursorSuccessHandler = (JSON, _ previousCursor: String?, _ nextCursor: String?) -> Void
    public typealias JSONSuccessHandler = (JSON, _ response: HTTPURLResponse) -> Void
    public typealias FailureHandler = (_ error: Error) -> Void

    internal struct CallbackNotification {
        static let optionsURLKey = "SwifterCallbackNotificationOptionsURLKey"
    }
    
    internal struct DataParameters {
        static let dataKey = "SwifterDataParameterKey"
        static let fileNameKey = "SwifterDataParameterFilename"
    }

    // MARK: - Properties
    
    public var client: SwifterClientProtocol
    private var chunkBuffer: String?

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
    internal func jsonRequest(path: String, baseURL: TwitterURL, method: HTTPMethodType, parameters: Dictionary<String, Any>, uploadProgress: HTTPRequest.UploadProgressHandler? = nil, downloadProgress: JSONSuccessHandler? = nil, success: JSONSuccessHandler? = nil, failure: HTTPRequest.FailureHandler? = nil) -> HTTPRequest {
        let jsonDownloadProgressHandler: HTTPRequest.DownloadProgressHandler = { [weak self] data, _, _, response in
            guard let `self` = self else { return }
            guard let _ = downloadProgress else { return }
            self.handleStreamProgress(data: data, response: response, handler: downloadProgress)
        }

        let jsonSuccessHandler: HTTPRequest.SuccessHandler = { data, response in

            DispatchQueue.global(qos: .utility).async {
                do {
                    let jsonResult = try JSON.parse(jsonData: data)
                    DispatchQueue.main.async {
                        success?(jsonResult, response)
                    }
                } catch {
                    DispatchQueue.main.async {
                        if case 200 ... 299 = response.statusCode, data.count == 0 {
						    success?(JSON("{}"), response)
                        } else {
                            failure?(error)
                        }
                    }
                }
            }
        }

        if method == .GET {
            return self.client.get(path, baseURL: baseURL, parameters: parameters, uploadProgress: uploadProgress, downloadProgress: jsonDownloadProgressHandler, success: jsonSuccessHandler, failure: failure)
        } else {
            return self.client.post(path, baseURL: baseURL, parameters: parameters, uploadProgress: uploadProgress, downloadProgress: jsonDownloadProgressHandler, success: jsonSuccessHandler, failure: failure)
        }
    }
    
    private func handleStreamProgress(data: Data, response: HTTPURLResponse, handler: JSONSuccessHandler? = nil) {
        let chunkSeparator = "\r\n"
        if var jsonString = String(data: data, encoding: .utf8) {
            if let remaining = chunkBuffer {
                jsonString = remaining + jsonString
            }
            let jsonChunks = jsonString.components(separatedBy: chunkSeparator)
            for chunk in jsonChunks where !chunk.utf16.isEmpty {
                if let chunkData = chunk.data(using: .utf8) {
                    guard let jsonResult = try? JSON.parse(jsonData: chunkData) else {
                        self.chunkBuffer = chunk
                        return
                    }
                    chunkBuffer = nil
                    handler?(jsonResult, response)
                }
            }
        }
    }

    @discardableResult
    internal func getJSON(path: String, baseURL: TwitterURL, parameters: Dictionary<String, Any>, uploadProgress: HTTPRequest.UploadProgressHandler? = nil, downloadProgress: JSONSuccessHandler? = nil, success: JSONSuccessHandler?, failure: HTTPRequest.FailureHandler?) -> HTTPRequest {
        return self.jsonRequest(path: path, baseURL: baseURL, method: .GET, parameters: parameters, uploadProgress: uploadProgress, downloadProgress: downloadProgress, success: success, failure: failure)
    }

    @discardableResult
    internal func postJSON(path: String, baseURL: TwitterURL, parameters: Dictionary<String, Any>, uploadProgress: HTTPRequest.UploadProgressHandler? = nil, downloadProgress: JSONSuccessHandler? = nil, success: JSONSuccessHandler?, failure: HTTPRequest.FailureHandler?) -> HTTPRequest {
        return self.jsonRequest(path: path, baseURL: baseURL, method: .POST, parameters: parameters, uploadProgress: uploadProgress, downloadProgress: downloadProgress, success: success, failure: failure)
    }
    
}
