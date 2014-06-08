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

#if os(iOS)
    import UIKit
#else
    import AppKit
#endif

class Swifter {

    typealias SwifterTokenRequestSuccessHandler = (accessToken: OAuthAccessToken, response: NSURLResponse) -> Void
    typealias SwifterRequestFailureHandler = (error: NSError) -> Void

    struct OAuthConstants {
        static let version = "1.0"
        static let signatureMethod = "HMAC-SHA1"
    }

    struct OAuthAccessToken {
        var key: String
        var secret: String
        var verifier: String?
        var session: String?

        var expiration: NSDate?
        var renewable: Bool
        var expired: Bool {
        get {
            return self.expiration?.compare(NSDate()) == NSComparisonResult.OrderedAscending
        }
        }

        var userInfo: Dictionary<String, String>?

        init(queryString: String) {
            var attributes = queryString.parametersFromQueryString()

            println(attributes)

            self.key = attributes["oauth_token"]!
            self.secret = attributes["oauth_token_secret"]!
            self.session = attributes["oauth_session_handle"]

            if let expiration = attributes["oauth_token_duration"] {
                self.expiration = NSDate(timeIntervalSinceNow: expiration.bridgeToObjectiveC().doubleValue)
            }

            self.renewable = false
            if let canBeRenewed = attributes["oauth_token_renewable"] {
                self.renewable = canBeRenewed.lowercaseString.hasPrefix("t")
            }

            attributes.removeValueForKey("oauth_token")
            attributes.removeValueForKey("oauth_token_secret")
            attributes.removeValueForKey("oauth_session_handle")
            attributes.removeValueForKey("oauth_token_duration")
            attributes.removeValueForKey("oauth_token_renewable")
            
            if attributes.count > 0 {
                self.userInfo = attributes
            }
        }
    }

    var baseURL: NSURL

    var consumerKey: String
    var consumerSecret: String

    var realm: String?

    var requestToken: String?
    var requestTokenSecret: String?

    var accessToken: OAuthAccessToken?

    var stringEncoding: NSStringEncoding

    init(baseURL: NSURL, consumerKey: String, consumerSecret: String) {
        self.baseURL = baseURL
        self.consumerKey = consumerKey
        self.consumerSecret = consumerSecret
        self.stringEncoding = NSUTF8StringEncoding
    }

    func authorizeWithCallbackURL(callbackURL: NSURL, success: SwifterTokenRequestSuccessHandler, failure: ((error: NSError) -> Void)?) {
        self.requestOAuthRequestTokenWithCallbackURL(callbackURL, success: {
            accessToken, response in

            let authorizeURL = NSURL(string: "/oauth/authorize", relativeToURL: self.baseURL)
            let queryURL = NSURL(string: authorizeURL.absoluteString + "?oauth_token=\(accessToken.key)")

            #if os(iOS)
                UIApplication.sharedApplication().openURL(queryURL)
            #else
                NSWorkspace.sharedWorkspace().openURL(queryURL)
            #endif
        }, failure: failure)
    }

    func requestOAuthRequestTokenWithCallbackURL(callbackURL: NSURL, success: SwifterTokenRequestSuccessHandler, failure: SwifterRequestFailureHandler?) {
        let parameters: Dictionary<String, AnyObject> = ["oauth_callback": callbackURL.absoluteString.bridgeToObjectiveC()]
        let request = self.requestWithMethod("POST", path: "/oauth/request_token", parameters: parameters)

        let dataTask = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in

            if error {
                failure?(error: error)
            }
            else {
                let httpResponse = response as NSHTTPURLResponse

                if httpResponse.statusCode == 200 {
                    let responseString = NSString(data: data, encoding: NSUTF8StringEncoding)
                    let accessToken = OAuthAccessToken(queryString: responseString)
                    success(accessToken: accessToken, response: response)
                }
                else {
                    failure?(error: NSError(domain: NSHTTPURLResponse.localizedStringForStatusCode(httpResponse.statusCode), code: httpResponse.statusCode, userInfo: httpResponse.allHeaderFields))
                }
            }
        }

        dataTask.resume()
    }

    func requestOAuthAccessTokenWithRequestToken(requestToken: OAuthAccessToken, success: SwifterRequestFailureHandler, failure: SwifterRequestFailureHandler?) {

    }

    func requestWithMethod(method: String, path: String, parameters: Dictionary<String, AnyObject>) -> NSMutableURLRequest {
        let url = NSURL.URLWithString(path, relativeToURL: self.baseURL)
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = method

        var filteredParameters = Dictionary<String, AnyObject>()
        for (key, value: AnyObject) in parameters {
            if !key.hasPrefix("oauth_") {
                filteredParameters.updateValue(value, forKey: key)
            }
        }

        let charset = CFStringConvertEncodingToIANACharSetName(CFStringConvertNSStringEncodingToEncoding(self.stringEncoding))
        request.setValue("application/json; charset=\(charset)", forHTTPHeaderField: "Content-Type")

        if filteredParameters.count > 0 {
            if method == "GET" || method == "HEAD" || method == "DELETE" {
                let queryStart = NSString(string: path).containsString("?") ? "?" : "&"
                let queryURL = NSURL.URLWithString(url.absoluteString + queryStart + filteredParameters.urlEncodedString(self.stringEncoding))
                request.URL = queryURL
            }
            else {
                var error: NSError?
                var jsonData = NSJSONSerialization.dataWithJSONObject(filteredParameters, options: nil, error: &error)
                request.HTTPBody = jsonData

                if error {
                    println(error!.localizedDescription)
                }
            }
        }

        let authorizationHeader = self.authorizationHeaderForMethod(method, url: url, parameters: parameters)
        request.setValue(authorizationHeader, forHTTPHeaderField: "Authorization")
        request.HTTPShouldHandleCookies = false

        return request
    }

    func authorizationHeaderForMethod(method: String, url: NSURL, parameters: Dictionary<String, AnyObject>) -> String {
        var authorizationParameters = self.oauthParameters()

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

        let authorizationParameterComponents = authorizationParameters.urlEncodedString(self.stringEncoding).componentsSeparatedByString("&") as String[]
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

    func oauthParameters() -> Dictionary<String, AnyObject> {
        var parameters = Dictionary<String, AnyObject>()
        parameters["oauth_version"] = OAuthConstants.version
        parameters["oauth_signature_method"] =  OAuthConstants.signatureMethod
        parameters["oauth_consumer_key"] = self.consumerKey.bridgeToObjectiveC()
        parameters["oauth_timestamp"] = "\(Int(NSDate().timeIntervalSince1970))".bridgeToObjectiveC()
        parameters["oauth_nonce"] = NSUUID().UUIDString.bridgeToObjectiveC()

        if self.accessToken {
            parameters["oauth_token"] = self.accessToken!.key.bridgeToObjectiveC()
        }

        if self.realm {
            parameters["realm"] = self.realm!.bridgeToObjectiveC()
        }

        return parameters
    }

    func oauthSignatureForMethod(method: String, url: NSURL, parameters: Dictionary<String, AnyObject>, accessToken token: OAuthAccessToken?) -> String {
        var tokenSecret: NSString = ""
        if token {
            tokenSecret = token!.secret.stringByAddingPercentEscapesUsingEncoding(self.stringEncoding)
        }

        let encodedConsumerSecret = self.consumerSecret.stringByAddingPercentEscapesUsingEncoding(self.stringEncoding)

        let signingKey = "\(encodedConsumerSecret)&\(tokenSecret)"
        let signingKeyData = signingKey.bridgeToObjectiveC().dataUsingEncoding(self.stringEncoding)

        let parameterComponents = parameters.urlEncodedString(self.stringEncoding).componentsSeparatedByString("&") as String[]
        parameterComponents.sort { $0 < $1 }

        let parameterString = parameterComponents.bridgeToObjectiveC().componentsJoinedByString("&")
        let encodedParameterString = parameterString.stringByAddingPercentEscapesUsingEncoding(self.stringEncoding)

        let encodedURL = url.absoluteString.stringByAddingPercentEscapesUsingEncoding(self.stringEncoding)

        let signatureBaseString = "\(method)&\(encodedURL)&\(encodedParameterString)"
        let signatureBaseStringData = signatureBaseString.dataUsingEncoding(self.stringEncoding)

        return HMACSHA1Signature.signatureForKey(signingKeyData, data: signatureBaseStringData).base64EncodedStringWithOptions(nil)
    }

}
