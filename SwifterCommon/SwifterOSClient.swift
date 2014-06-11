//
//  SwifterOSClient.swift
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
import Social

class SwifterOSClient: SwifterClientProtocol {

    var credential: SwifterCredential?

    init(account: ACAccount) {
        self.credential = SwifterCredential(account: account)
    }

    func requestWithPath(path: String, baseURL: NSURL, method: String, parameters: Dictionary<String, AnyObject>, progress: SwifterHTTPRequest.DownloadProgressHandler?, success: SwifterHTTPRequest.RequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        var requestMethod = method == "POST" ? SLRequestMethod.POST : SLRequestMethod.GET

        let url = NSURL(string: path, relativeToURL: baseURL)

        let socialRequest = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: requestMethod, URL: url, parameters: parameters.bridgeToObjectiveC())
        socialRequest.account = self.credential!.account!

        let request = SwifterHTTPRequest(request: socialRequest.preparedURLRequest())
        request.downloadRequestProgressHandler = progress
        request.requestSuccessHandler = success
        request.requestFailureHandler = failure

        request.start()
    }

    func dataRequestWithPath(path: String, baseURL: NSURL, method: String, parameters: Dictionary<String, AnyObject>, progress: SwifterHTTPRequest.DownloadProgressHandler?, success: SwifterHTTPRequest.DataRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        var requestMethod = method == "POST" ? SLRequestMethod.POST : SLRequestMethod.GET

        let url = NSURL(string: path, relativeToURL: baseURL)

        let socialRequest = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: requestMethod, URL: url, parameters: parameters)
        socialRequest.account = self.credential!.account!

        let request = SwifterHTTPRequest(request: socialRequest.preparedURLRequest())
        request.downloadRequestProgressHandler = progress
        request.dataRequestSuccessHandler = success
        request.requestFailureHandler = failure

        request.start()
    }

    func get(path: String, baseURL: NSURL, parameters: Dictionary<String, AnyObject>, progress: SwifterHTTPRequest.DownloadProgressHandler?, success: SwifterHTTPRequest.DataRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        self.dataRequestWithPath(path, baseURL: baseURL, method: "GET", parameters: parameters, progress: progress, success: success, failure: failure)
    }

    func post(path: String, baseURL: NSURL, parameters: Dictionary<String, AnyObject>, progress: SwifterHTTPRequest.DownloadProgressHandler?, success: SwifterHTTPRequest.DataRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        self.dataRequestWithPath(path, baseURL: baseURL, method: "POST", parameters: parameters, progress: progress, success: success, failure: failure)
    }

}
