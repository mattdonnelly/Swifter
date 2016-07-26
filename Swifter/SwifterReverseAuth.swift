// Swifter-Reverse-Auth.swift
//
// Copyright (c) 2015 Gurpartap Singh (http://github.com/Gurpartap)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import Foundation


let swifterApiURL = NSURL(string: "https://api.twitter.com")!


public extension Swifter {
    
    public func postReverseOAuthTokenRequest(success: (authenticationHeader: String) -> Void, failure: SwifterHTTPRequest.FailureHandler?) {
        let path = "/oauth/request_token"
        
        var parameters = Dictionary<String, Any>()
        parameters["x_auth_mode"] = "reverse_auth"
        
        self.client.post(path, baseURL: swifterApiURL, parameters: parameters, uploadProgress: nil, downloadProgress: nil, success: { data, response in
            let responseString = NSString(data: data, encoding: NSUTF8StringEncoding)!
            success(authenticationHeader: responseString as String)
        }, failure: failure)
    }
    
    public func postReverseAuthAccessTokenWithAuthenticationHeader(authenticationHeader: String, success: TokenSuccessHandler, failure: SwifterHTTPRequest.FailureHandler?) {
        let path =  "/oauth/access_token"
        
        let shortHeader = authenticationHeader.stringByReplacingOccurrencesOfString("OAuth ", withString: "")
        let authenticationHeaderDictionary = shortHeader.parametersDictionaryFromCommaSeparatedParametersString()
        
        let consumerKey = authenticationHeaderDictionary["oauth_consumer_key"]!
        
        var parameters = Dictionary<String, Any>()
        parameters["x_reverse_auth_target"] = consumerKey
        parameters["x_reverse_auth_parameters"] = authenticationHeader
        
        self.client.post(path, baseURL: swifterApiURL, parameters: parameters, uploadProgress: nil, downloadProgress: nil, success: { data, response in
            let responseString = NSString(data: data, encoding: NSUTF8StringEncoding)!
            let accessToken = SwifterCredential.OAuthAccessToken(queryString: responseString as String)
            success(accessToken: accessToken, response: response)
        }, failure: failure)
        
    }
    
}

