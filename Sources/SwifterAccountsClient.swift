//
//  AccountsClient.swift
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

#if os(macOS) || os(iOS)
import Accounts
import Social

internal class AccountsClient: SwifterClientProtocol {

    var credential: Credential?

    init(account: ACAccount) {
        self.credential = Credential(account: account)
    }

    func get(_ path: String, baseURL: TwitterURL, parameters: Dictionary<String, Any>, uploadProgress: HTTPRequest.UploadProgressHandler?, downloadProgress: HTTPRequest.DownloadProgressHandler?, success: HTTPRequest.SuccessHandler?, failure: HTTPRequest.FailureHandler?) -> HTTPRequest {
        let url = URL(string: path, relativeTo: baseURL.url)

        let stringifiedParameters = parameters.stringifiedDictionary()
        
        let socialRequest = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: .GET, url: url, parameters: stringifiedParameters)!
        socialRequest.account = self.credential!.account!

        let request = HTTPRequest(request: socialRequest.preparedURLRequest())
        request.parameters = parameters
        request.downloadProgressHandler = downloadProgress
        request.successHandler = success
        request.failureHandler = failure
        
        request.start()
        return request
    }

    func post(_ path: String, baseURL: TwitterURL, parameters: Dictionary<String, Any>, uploadProgress: HTTPRequest.UploadProgressHandler?, downloadProgress: HTTPRequest.DownloadProgressHandler?, success: HTTPRequest.SuccessHandler?, failure: HTTPRequest.FailureHandler?) -> HTTPRequest {
        let url = URL(string: path, relativeTo: baseURL.url)

        var params = parameters
        
        var postData: Data?
        var postDataKey: String?

        if let keyString = params[Swifter.DataParameters.dataKey] as? String {
            postDataKey = keyString
            postData = params[keyString] as? Data
            
            params.removeValue(forKey: Swifter.DataParameters.dataKey)
            params.removeValue(forKey: keyString)
        }

        var postDataFileName: String?
        if let fileName = params[Swifter.DataParameters.fileNameKey] as? String {
            postDataFileName = fileName
			params.removeValue(forKey: Swifter.DataParameters.fileNameKey)
       }

        let stringifiedParameters = params.stringifiedDictionary()

        let socialRequest = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: .POST, url: url, parameters: stringifiedParameters)!
        socialRequest.account = self.credential!.account!

        if let data = postData {
            let fileName = postDataFileName ?? "media.jpg"
            socialRequest.addMultipartData(data, withName: postDataKey!, type: "application/octet-stream", filename: fileName)
        }

        let request = HTTPRequest(request: socialRequest.preparedURLRequest())
        request.parameters = parameters
        request.downloadProgressHandler = downloadProgress
        request.successHandler = success
        request.failureHandler = failure
        
        request.start()
        return request
    }

}
#endif
