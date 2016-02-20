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
import Accounts

public class Swifter {

    // MARK: - Types

    public typealias JSONSuccessHandler = (json: JSON, response: NSHTTPURLResponse) -> Void
    public typealias FailureHandler = (error: NSError) -> Void

    internal struct CallbackNotification {
        static let notificationName = "SwifterCallbackNotificationName"
        static let optionsURLKey = "SwifterCallbackNotificationOptionsURLKey"
    }

    internal struct SwifterError {
        static let domain = "SwifterErrorDomain"
        static let appOnlyAuthenticationErrorCode = 1
    }

    internal struct DataParameters {
        static let dataKey = "SwifterDataParameterKey"
        static let fileNameKey = "SwifterDataParameterFilename"
    }

    // MARK: - Properties

    let apiURL = NSURL(string: "https://api.twitter.com/1.1/")!
    let uploadURL = NSURL(string: "https://upload.twitter.com/1.1/")!
    let streamURL = NSURL(string: "https://stream.twitter.com/1.1/")!
    let userStreamURL = NSURL(string: "https://userstream.twitter.com/1.1/")!
    let siteStreamURL = NSURL(string: "https://sitestream.twitter.com/1.1/")!

    public var client: SwifterClientProtocol

    // MARK: - Initializers
    
    public init(consumerKey: String, consumerSecret: String, appOnly: Bool = false) {
        self.client = appOnly
            ? SwifterAppOnlyClient(consumerKey: consumerKey, consumerSecret: consumerSecret)
            : SwifterOAuthClient(consumerKey: consumerKey, consumerSecret: consumerSecret)
    }

    public init(consumerKey: String, consumerSecret: String, oauthToken: String, oauthTokenSecret: String) {
        self.client = SwifterOAuthClient(consumerKey: consumerKey, consumerSecret: consumerSecret , accessToken: oauthToken, accessTokenSecret: oauthTokenSecret)
    }

    public init(account: ACAccount) {
        self.client = SwifterAccountsClient(account: account)
    }

    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    // MARK: - JSON Requests

    internal func jsonRequestWithPath(path: String, baseURL: NSURL, method: HTTPMethodType, parameters: Dictionary<String, Any>, uploadProgress: SwifterHTTPRequest.UploadProgressHandler? = nil, downloadProgress: JSONSuccessHandler? = nil, success: JSONSuccessHandler? = nil, failure: SwifterHTTPRequest.FailureHandler? = nil) -> SwifterHTTPRequest {
        let jsonDownloadProgressHandler: SwifterHTTPRequest.DownloadProgressHandler = { data, _, _, response in

            guard downloadProgress != nil else { return }

            if let jsonResult = try? JSON.parseJSONData(data) {
                downloadProgress?(json: jsonResult, response: response)
            } else {
                let jsonString = NSString(data: data, encoding: NSUTF8StringEncoding)
                let jsonChunks = jsonString!.componentsSeparatedByString("\r\n") as [String]
                
                for chunk in jsonChunks where !chunk.utf16.isEmpty {
                    if let chunkData = chunk.dataUsingEncoding(NSUTF8StringEncoding),
                        let jsonResult = try? JSON.parseJSONData(chunkData) {
                        downloadProgress?(json: jsonResult, response: response)
                    }
                }
            }
        }

        let jsonSuccessHandler: SwifterHTTPRequest.SuccessHandler = { data, response in

            dispatch_async(dispatch_get_global_queue(QOS_CLASS_UTILITY, 0)) {
                do {
                    let jsonResult = try JSON.parseJSONData(data)
                    dispatch_async(dispatch_get_main_queue()) {
                        success?(json: jsonResult, response: response)
                    }
                } catch let error as NSError {
                    dispatch_async(dispatch_get_main_queue()) {
                        failure?(error: error)
                    }
                }
            }
        }

        if method == .GET {
            return self.client.get(path, baseURL: baseURL, parameters: parameters, uploadProgress: uploadProgress, downloadProgress: jsonDownloadProgressHandler, success: jsonSuccessHandler, failure: failure)
        }
        else {
            return self.client.post(path, baseURL: baseURL, parameters: parameters, uploadProgress: uploadProgress, downloadProgress: jsonDownloadProgressHandler, success: jsonSuccessHandler, failure: failure)
        }
    }

    internal func getJSONWithPath(path: String, baseURL: NSURL, parameters: Dictionary<String, Any>, uploadProgress: SwifterHTTPRequest.UploadProgressHandler? = nil, downloadProgress: JSONSuccessHandler? = nil, success: JSONSuccessHandler?, failure: SwifterHTTPRequest.FailureHandler?) -> SwifterHTTPRequest {
        return self.jsonRequestWithPath(path, baseURL: baseURL, method: .GET, parameters: parameters, uploadProgress: uploadProgress, downloadProgress: downloadProgress, success: success, failure: failure)
    }

    internal func postJSONWithPath(path: String, baseURL: NSURL, parameters: Dictionary<String, Any>, uploadProgress: SwifterHTTPRequest.UploadProgressHandler? = nil, downloadProgress: JSONSuccessHandler? = nil, success: JSONSuccessHandler?, failure: SwifterHTTPRequest.FailureHandler?) -> SwifterHTTPRequest {
        return self.jsonRequestWithPath(path, baseURL: baseURL, method: .POST, parameters: parameters, uploadProgress: uploadProgress, downloadProgress: downloadProgress, success: success, failure: failure)
    }
    
}
