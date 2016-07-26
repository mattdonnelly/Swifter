//
//  SwifterAppOnlyClient.swift
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

internal class SwifterAppOnlyClient: SwifterClientProtocol  {

    var consumerKey: String
    var consumerSecret: String

    var credential: SwifterCredential?

    var dataEncoding: NSStringEncoding

    init(consumerKey: String, consumerSecret: String) {
        self.consumerKey = consumerKey
        self.consumerSecret = consumerSecret
        self.dataEncoding = NSUTF8StringEncoding
    }

    func get(path: String, baseURL: NSURL, parameters: Dictionary<String, Any>, uploadProgress: SwifterHTTPRequest.UploadProgressHandler?, downloadProgress: SwifterHTTPRequest.DownloadProgressHandler?, success: SwifterHTTPRequest.SuccessHandler?, failure: SwifterHTTPRequest.FailureHandler?) -> SwifterHTTPRequest {
        let url = NSURL(string: path, relativeToURL: baseURL)

        let request = SwifterHTTPRequest(URL: url!, method: .GET, parameters: parameters)
        request.downloadProgressHandler = downloadProgress
        request.successHandler = success
        request.failureHandler = failure
        request.dataEncoding = self.dataEncoding

        if let bearerToken = self.credential?.accessToken?.key {
            request.headers = ["Authorization": "Bearer \(bearerToken)"];
        }

        request.start()
        return request
    }

    func post(path: String, baseURL: NSURL, parameters: Dictionary<String, Any>, uploadProgress: SwifterHTTPRequest.UploadProgressHandler?, downloadProgress: SwifterHTTPRequest.DownloadProgressHandler?, success: SwifterHTTPRequest.SuccessHandler?, failure: SwifterHTTPRequest.FailureHandler?) -> SwifterHTTPRequest {
        let url = NSURL(string: path, relativeToURL: baseURL)

        let request = SwifterHTTPRequest(URL: url!, method: .POST, parameters: parameters)
        request.downloadProgressHandler = downloadProgress
        request.successHandler = success
        request.failureHandler = failure
        request.dataEncoding = self.dataEncoding

        if let bearerToken = self.credential?.accessToken?.key {
            request.headers = ["Authorization": "Bearer \(bearerToken)"];
        } else {
            let basicCredentials = SwifterAppOnlyClient.base64EncodedCredentialsWithKey(self.consumerKey, secret: self.consumerSecret)
            request.headers = ["Authorization": "Basic \(basicCredentials)"];
            request.encodeParameters = true
        }

        request.start()
        return request
    }

    class func base64EncodedCredentialsWithKey(key: String, secret: String) -> String {
        let encodedKey = key.urlEncodedStringWithEncoding()
        let encodedSecret = secret.urlEncodedStringWithEncoding()
        let bearerTokenCredentials = "\(encodedKey):\(encodedSecret)"
        if let data = bearerTokenCredentials.dataUsingEncoding(NSUTF8StringEncoding) {
            return data.base64EncodedStringWithOptions([])
        }
        return String()
    }

}
