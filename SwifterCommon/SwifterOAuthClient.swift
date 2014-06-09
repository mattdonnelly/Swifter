//
//  SwifterOAuthClient.swift
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

class SwifterOAuthClient {

    struct OAuth {
        static let version = "1.0"
        static let signatureMethod = "HMAC-SHA1"
    }

    var baseURL: NSURL

    var consumerKey: String
    var consumerSecret: String

    var accessToken: OAuthAccessToken?

    var stringEncoding: NSStringEncoding

    init(baseURL: NSURL, consumerKey: String, consumerSecret: String) {
        self.baseURL = baseURL
        self.consumerKey = consumerKey
        self.consumerSecret = consumerSecret
        self.stringEncoding = NSUTF8StringEncoding
    }

    func dataRequestWithMethod(method: String, path: String, parameters: Dictionary<String, AnyObject>, success: ((data: NSData, response: NSHTTPURLResponse) -> Void), failure: ((error: NSError) -> Void)?) {
        let request = self.requestWithMethod(method, path: path, parameters: parameters)

        let dataTask = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in

            if error {
                failure?(error: error)
            }
            else {
                let httpResponse = response as NSHTTPURLResponse

                if httpResponse.statusCode == 200 {
                    success(data: data, response: httpResponse)
                }
                else {
                    let httpError = NSError(domain: NSURLErrorDomain, code: httpResponse.statusCode, userInfo: httpResponse.allHeaderFields)
                    failure?(error: httpError)
                }
            }
        }

        dataTask.resume()
    }

    func getRequestWithPath(path: String, parameters: Dictionary<String, AnyObject>, success: ((data: NSData, response: NSHTTPURLResponse) -> Void), failure: ((error: NSError) -> Void)?) {
        self.dataRequestWithMethod("GET", path: path, parameters: parameters, success: success, failure: failure)
    }

    func postRequestWithPath(path: String, parameters: Dictionary<String, AnyObject>, success: ((data: NSData, response: NSHTTPURLResponse) -> Void), failure: ((error: NSError) -> Void)?) {
        self.dataRequestWithMethod("POST", path: path, parameters: parameters, success: success, failure: failure)
    }

    func requestWithMethod(method: String, path: String, parameters: Dictionary<String, AnyObject>) -> NSMutableURLRequest {
        let url = NSURL(string: path, relativeToURL: self.baseURL)
        let request = NSMutableURLRequest(URL: url)

        request.HTTPMethod = method

        var nonOAuthParameters = parameters.filter { key, _ in !key.hasPrefix("oauth_") }

        if nonOAuthParameters.count > 0 && (method == "POST" || method == "PUT") {
            var error: NSError?
            var jsonData = NSJSONSerialization.dataWithJSONObject(nonOAuthParameters, options: nil, error: &error)

            if error {
                println(error!.localizedDescription)
            }
            else {
                let charset = CFStringConvertEncodingToIANACharSetName(CFStringConvertNSStringEncodingToEncoding(self.stringEncoding))
                request.setValue("application/json; charset=\(charset)", forHTTPHeaderField: "Content-Type")
                request.HTTPBody = jsonData
            }
        }

        let authorizationHeader = self.authorizationHeaderForMethod(method, url: url, parameters: parameters)
        request.setValue(authorizationHeader, forHTTPHeaderField: "Authorization")
        request.HTTPShouldHandleCookies = false

        return request
    }

    func authorizationHeaderForMethod(method: String, url: NSURL, parameters: Dictionary<String, AnyObject>) -> String {
        var authorizationParameters = Dictionary<String, AnyObject>()
        authorizationParameters["oauth_version"] = OAuth.version
        authorizationParameters["oauth_signature_method"] =  OAuth.signatureMethod
        authorizationParameters["oauth_consumer_key"] = self.consumerKey.bridgeToObjectiveC()
        authorizationParameters["oauth_timestamp"] = "\(Int(NSDate().timeIntervalSince1970))".bridgeToObjectiveC()
        authorizationParameters["oauth_nonce"] = NSUUID().UUIDString.bridgeToObjectiveC()

        if self.accessToken {
            authorizationParameters["oauth_token"] = self.accessToken!.key
        }

        for (key, value: AnyObject) in parameters {
            if key.hasPrefix("oauth_") {
                authorizationParameters.updateValue(value, forKey: key)
            }
        }

        let combinedParameters = authorizationParameters.join(parameters)

        authorizationParameters["oauth_signature"] = self.oauthSignatureForMethod(method, url: url, parameters: combinedParameters, accessToken: self.accessToken)

        let authorizationParameterComponents = authorizationParameters.urlEncodedQueryStringWithEncoding(self.stringEncoding).componentsSeparatedByString("&") as String[]
        authorizationParameterComponents.sort { $0 < $1 }

        var headerComponents = String[]()
        for component in authorizationParameterComponents {
            let subcomponent = component.componentsSeparatedByString("=") as String[]
            if subcomponent.count == 2 {
                headerComponents.append("\(subcomponent[0])=\"\(subcomponent[1])\"")
            }
        }

        return "OAuth " + headerComponents.bridgeToObjectiveC().componentsJoinedByString(", ")
    }

    func oauthSignatureForMethod(method: String, url: NSURL, parameters: Dictionary<String, AnyObject>, accessToken token: OAuthAccessToken?) -> String {
        var tokenSecret: NSString = ""
        if token {
            tokenSecret = token!.secret.urlEncodedStringWithEncoding(self.stringEncoding)
        }

        let encodedConsumerSecret = self.consumerSecret.urlEncodedStringWithEncoding(self.stringEncoding)

        let signingKey = "\(encodedConsumerSecret)&\(tokenSecret)"
        let signingKeyData = signingKey.bridgeToObjectiveC().dataUsingEncoding(self.stringEncoding)

        let parameterComponents = parameters.urlEncodedQueryStringWithEncoding(self.stringEncoding).componentsSeparatedByString("&") as String[]
        parameterComponents.sort { $0 < $1 }

        let parameterString = parameterComponents.bridgeToObjectiveC().componentsJoinedByString("&")
        let encodedParameterString = parameterString.urlEncodedStringWithEncoding(self.stringEncoding)

        let encodedURL = url.absoluteString.urlEncodedStringWithEncoding(self.stringEncoding)

        let signatureBaseString = "\(method)&\(encodedURL)&\(encodedParameterString)"
        let signatureBaseStringData = signatureBaseString.dataUsingEncoding(self.stringEncoding)

        return HMACSHA1Signature.signatureForKey(signingKeyData, data: signatureBaseStringData).base64EncodedStringWithOptions(nil)
    }

}
