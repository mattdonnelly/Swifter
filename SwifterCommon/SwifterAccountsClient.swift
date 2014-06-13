//
//  SwifterAccountsClient.swift
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

class SwifterAccountsClient: SwifterClientProtocol {

    var credential: SwifterCredential?

    init(account: ACAccount) {
        self.credential = SwifterCredential(account: account)
    }

    func get(path: String, baseURL: NSURL, parameters: Dictionary<String, AnyObject>, uploadProgress: SwifterHTTPRequest.UploadProgressHandler?, downloadProgress: SwifterHTTPRequest.DownloadProgressHandler?, success: SwifterHTTPRequest.SuccessHandler?, failure: SwifterHTTPRequest.FailureHandler?) {
        let url = NSURL(string: path, relativeToURL: baseURL)

        var localParameters = Dictionary<String, String>()
        for (key, value: AnyObject) in parameters {
            localParameters[key] = "\(value)"
        }

        let socialRequest = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: url, parameters: localParameters)
        socialRequest.account = self.credential!.account!

        let request = SwifterHTTPRequest(request: socialRequest.preparedURLRequest())
        request.parameters = parameters
        request.downloadProgressHandler = downloadProgress
        request.successHandler = success
        request.failureHandler = failure
        
        request.start()
    }

    func post(path: String, baseURL: NSURL, parameters: Dictionary<String, AnyObject>, uploadProgress: SwifterHTTPRequest.UploadProgressHandler?, downloadProgress: SwifterHTTPRequest.DownloadProgressHandler?, success: SwifterHTTPRequest.SuccessHandler?, failure: SwifterHTTPRequest.FailureHandler?) {
        let url = NSURL(string: path, relativeToURL: baseURL)

        var localParameters = parameters

        var postData: NSData?
        var postDataKey: String?

        if let key : AnyObject = localParameters[Swifter.DataParameters.dataKey] {
            postDataKey = key as? String
            postData = localParameters[postDataKey!] as? NSData

            localParameters.removeValueForKey(Swifter.DataParameters.dataKey)
            localParameters.removeValueForKey(postDataKey!)
        }

        var postDataFileName: String?
        if let fileName : AnyObject = localParameters[Swifter.DataParameters.fileNameKey] {
            postDataFileName = fileName as? String
            localParameters.removeValueForKey(postDataFileName!)
        }

        for (key, value: AnyObject) in localParameters {
            localParameters[key] = "\(value)"
        }

        let socialRequest = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.POST, URL: url, parameters: localParameters)
        socialRequest.account = self.credential!.account!

        if postData {
            let fileName = postDataFileName ? postDataFileName! as String : "media.jpg"

            socialRequest.addMultipartData(postData!, withName: postDataKey!, type: "application/octet-stream", filename: fileName)
        }

        let request = SwifterHTTPRequest(request: socialRequest.preparedURLRequest())
        request.parameters = parameters
        request.downloadProgressHandler = downloadProgress
        request.successHandler = success
        request.failureHandler = failure
        
        request.start()
    }

}
