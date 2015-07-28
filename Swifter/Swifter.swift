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

    internal(set) var apiURL: NSURL
    internal(set) var uploadURL: NSURL
    internal(set) var streamURL: NSURL
    internal(set) var userStreamURL: NSURL
    internal(set) var siteStreamURL: NSURL

    public var client: SwifterClientProtocol

    // MARK: - Initializers

    public convenience init(consumerKey: String, consumerSecret: String) {
        self.init(consumerKey: consumerKey, consumerSecret: consumerSecret, appOnly: false)
    }

    public init(consumerKey: String, consumerSecret: String, appOnly: Bool) {
        if appOnly {
            self.client = SwifterAppOnlyClient(consumerKey: consumerKey, consumerSecret: consumerSecret)
        }
        else {
            self.client = SwifterOAuthClient(consumerKey: consumerKey, consumerSecret: consumerSecret)
        }

        self.apiURL = NSURL(string: "https://api.twitter.com/1.1/")!
        self.uploadURL = NSURL(string: "https://upload.twitter.com/1.1/")!
        self.streamURL = NSURL(string: "https://stream.twitter.com/1.1/")!
        self.userStreamURL = NSURL(string: "https://userstream.twitter.com/1.1/")!
        self.siteStreamURL = NSURL(string: "https://sitestream.twitter.com/1.1/")!
    }

    public init(consumerKey: String, consumerSecret: String, oauthToken: String, oauthTokenSecret: String) {
        self.client = SwifterOAuthClient(consumerKey: consumerKey, consumerSecret: consumerSecret , accessToken: oauthToken, accessTokenSecret: oauthTokenSecret)

        self.apiURL = NSURL(string: "https://api.twitter.com/1.1/")!
        self.uploadURL = NSURL(string: "https://upload.twitter.com/1.1/")!
        self.streamURL = NSURL(string: "https://stream.twitter.com/1.1/")!
        self.userStreamURL = NSURL(string: "https://userstream.twitter.com/1.1/")!
        self.siteStreamURL = NSURL(string: "https://sitestream.twitter.com/1.1/")!
    }

    public init(account: ACAccount) {
        self.client = SwifterAccountsClient(account: account)

        self.apiURL = NSURL(string: "https://api.twitter.com/1.1/")!
        self.uploadURL = NSURL(string: "https://upload.twitter.com/1.1/")!
        self.streamURL = NSURL(string: "https://stream.twitter.com/1.1/")!
        self.userStreamURL = NSURL(string: "https://userstream.twitter.com/1.1/")!
        self.siteStreamURL = NSURL(string: "https://sitestream.twitter.com/1.1/")!
    }

    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    // MARK: - JSON Requests

    internal func jsonRequestWithPath(path: String, baseURL: NSURL, method: String, parameters: Dictionary<String, Any>, uploadProgress: SwifterHTTPRequest.UploadProgressHandler? = nil, downloadProgress: JSONSuccessHandler? = nil, success: JSONSuccessHandler? = nil, failure: SwifterHTTPRequest.FailureHandler? = nil) -> SwifterHTTPRequest {
        let buffer = NSMutableData()
        let jsonDownloadProgressHandler: SwifterHTTPRequest.DownloadProgressHandler = {
            data, _, _, response in

            if downloadProgress == nil {
                return
            }

            do {
                buffer.appendData(data)
                let object = try NSJSONSerialization.JSONObjectWithData(buffer, options: .MutableContainers)
                let json = JSON(object)
                buffer.setData(NSData())
                downloadProgress?(json: json, response: response)
            } catch _ as NSError {
                if let jsonString = NSString(data: buffer, encoding: NSUTF8StringEncoding) {
                    let chunks = jsonString.componentsSeparatedByString("\r\n")
                    for chunk in chunks {
                        if chunk.utf16.count == 0 {
                            continue
                        }
                        if let chunkData = chunk.dataUsingEncoding(NSUTF8StringEncoding) {
                            do {
                                let object = try NSJSONSerialization.JSONObjectWithData(chunkData, options: .MutableContainers)
                                let json = JSON(object)
                                buffer.setData(NSData())
                                downloadProgress?(json: json, response: response)
                            } catch _ as NSError {
                                buffer.setData(chunkData)
                            } catch {
                                fatalError()
                            }
                        }
                    }
                }
            } catch {
                fatalError()
            }
        }

        let jsonSuccessHandler: SwifterHTTPRequest.SuccessHandler = {
            data, response in

            dispatch_async(dispatch_get_global_queue(QOS_CLASS_UTILITY, 0)) {
                var error: NSError?
                do {
                    let jsonResult = try JSON.parseJSONData(data)
                    dispatch_async(dispatch_get_main_queue()) {
                        if let success = success {
                            success(json: jsonResult, response: response)
                        }
                    }
                } catch let error1 as NSError {
                    error = error1
                    dispatch_async(dispatch_get_main_queue()) {
                        if let failure = failure {
                            failure(error: error!)
                        }
                    }
                } catch {
                    fatalError()
                }
            }
        }

        if method == "GET" {
            return self.client.get(path, baseURL: baseURL, parameters: parameters, uploadProgress: uploadProgress, downloadProgress: jsonDownloadProgressHandler, success: jsonSuccessHandler, failure: failure)
        }
        else {
            return self.client.post(path, baseURL: baseURL, parameters: parameters, uploadProgress: uploadProgress, downloadProgress: jsonDownloadProgressHandler, success: jsonSuccessHandler, failure: failure)
        }
    }

    internal func getJSONWithPath(path: String, baseURL: NSURL, parameters: Dictionary<String, Any>, uploadProgress: SwifterHTTPRequest.UploadProgressHandler?, downloadProgress: JSONSuccessHandler?, success: JSONSuccessHandler?, failure: SwifterHTTPRequest.FailureHandler?) -> SwifterHTTPRequest {
        return self.jsonRequestWithPath(path, baseURL: baseURL, method: "GET", parameters: parameters, uploadProgress: uploadProgress, downloadProgress: downloadProgress, success: success, failure: failure)
    }

    internal func postJSONWithPath(path: String, baseURL: NSURL, parameters: Dictionary<String, Any>, uploadProgress: SwifterHTTPRequest.UploadProgressHandler?, downloadProgress: JSONSuccessHandler?, success: JSONSuccessHandler?, failure: SwifterHTTPRequest.FailureHandler?) -> SwifterHTTPRequest {
        return self.jsonRequestWithPath(path, baseURL: baseURL, method: "POST", parameters: parameters, uploadProgress: uploadProgress, downloadProgress: downloadProgress, success: success, failure: failure)
    }
    
}
