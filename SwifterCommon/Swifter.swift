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

#if os(iOS)
    import UIKit
#else
    import AppKit
#endif

class Swifter {

    typealias JSONRequestSuccessHandler = (json: AnyObject, response: NSHTTPURLResponse) -> Void
    typealias RequestFailureHandler = (error: NSError) -> Void

    struct CallbackNotification {
        static let notificationName = "SwifterCallbackNotificationName"
        static let optionsURLKey = "SwifterCallbackNotificationOptionsURLKey"
    }

    struct SwifterError {
        static let domain = "SwifterErrorDomain"
    }

    var apiURL: NSURL
    var uploadURL: NSURL
    var streamURL: NSURL
    var userStreamURL: NSURL
    var siteStreamURL: NSURL

    var client: SwifterClientProtocol

    init(consumerKey: String, consumerSecret: String) {
        self.client = SwifterOAuthClient(consumerKey: consumerKey, consumerSecret: consumerSecret)
        self.apiURL = NSURL(string: "https://api.twitter.com/1.1/")
        self.uploadURL = NSURL(string: "https://upload.twitter.com/1.1/")
        self.streamURL = NSURL(string: "https://stream.twitter.com/1.1/")
        self.userStreamURL = NSURL(string: "https://userstream.twitter.com/1.1/")
        self.siteStreamURL = NSURL(string: "https://sitestream.twitter.com/1.1/")    }

    init(account: ACAccount) {
        self.client = SwifterOSClient(account: account)
        self.apiURL = NSURL(string: "https://api.twitter.com/1.1/")
        self.uploadURL = NSURL(string: "https://upload.twitter.com/1.1/")
        self.streamURL = NSURL(string: "https://stream.twitter.com/1.1/")
        self.userStreamURL = NSURL(string: "https://userstream.twitter.com/1.1/")
        self.siteStreamURL = NSURL(string: "https://sitestream.twitter.com/1.1/")    }

    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    func commonInit() {

    }

    func jsonRequestWithPath(path: String, baseURL: NSURL, method: String, parameters: Dictionary<String, AnyObject>, progress: JSONRequestSuccessHandler?, success: JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let jsonDownloadProgressHandler: SwifterHTTPRequest.DownloadProgressHandler = {
            data, _, _, response in

            if !progress {
                return
            }

            var error: NSError?
            var jsonResult: AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &error)

            if !error {
                progress?(json: jsonResult!, response: response)
            }

            let jsonString = NSString(data: data, encoding: NSUTF8StringEncoding)
            let jsonChunks = jsonString.componentsSeparatedByString("\r\n") as String[]

            for chunk in jsonChunks {
                if chunk.utf16count == 0 {
                    continue
                }

                let chunkData = chunk.dataUsingEncoding(NSUTF8StringEncoding)
                jsonResult = NSJSONSerialization.JSONObjectWithData(chunkData, options: nil, error: &error)

                if !error {
                    progress?(json: jsonResult!, response: response)
                }
            }
        }

        let jsonSuccessHandler: SwifterHTTPRequest.DataRequestSuccessHandler = {
            data, response in

            var error: NSError?
            let jsonResult: AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &error)

            if error {
                failure?(error: error!)
            }
            else {
                success?(json: jsonResult!, response: response)
            }
        }

        self.client.dataRequestWithPath(path, baseURL: baseURL, method: method, parameters: parameters, progress: jsonDownloadProgressHandler, success: jsonSuccessHandler, failure: failure)
    }

    func getJSONWithPath(path: String, baseURL: NSURL, parameters: Dictionary<String, AnyObject>, progress: JSONRequestSuccessHandler?, success: JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        self.jsonRequestWithPath(path, baseURL: baseURL, method: "GET", parameters: parameters, progress: progress, success: success, failure: failure)
    }

    func postJSONWithPath(path: String, baseURL: NSURL, parameters: Dictionary<String, AnyObject>, progress: JSONRequestSuccessHandler?, success: JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        self.jsonRequestWithPath(path, baseURL: baseURL, method: "POST", parameters: parameters, progress: progress, success: success, failure: failure)
    }
    
}
