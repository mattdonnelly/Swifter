//
//  SwifterAuth.swift
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

extension Swifter {

    typealias TokenRequestSuccessHandler = (accessToken: SwifterCredential.OAuthAccessToken, response: NSURLResponse) -> Void

    func authorizeWithCallbackURL(callbackURL: NSURL, success: TokenRequestSuccessHandler, failure: ((error: NSError) -> Void)?) {
        self.postOAuthRequestTokenWithCallbackURL(callbackURL, success: {
            token, response in

            var requestToken = token

            NSNotificationCenter.defaultCenter().addObserverForName(CallbackNotification.notificationName, object: nil, queue: NSOperationQueue.mainQueue(), usingBlock:{
                notification in

                NSNotificationCenter.defaultCenter().removeObserver(self)

                let url = notification.userInfo[CallbackNotification.optionsURLKey] as NSURL

                let parameters = url.query.parametersFromQueryString()
                requestToken.verifier = parameters["oauth_verifier"]

                self.postOAuthAccessTokenWithRequestToken(requestToken, success: {
                    accessToken, response in

                    self.client.credential = SwifterCredential(accessToken: accessToken)
                    success(accessToken: accessToken, response: response)

                    }, failure: failure)
                })

            let authorizeURL = NSURL(string: "/oauth/authorize", relativeToURL: self.apiURL)
            let queryURL = NSURL(string: authorizeURL.absoluteString + "?oauth_token=\(token.key)")

            #if os(iOS)
                UIApplication.sharedApplication().openURL(queryURL)
            #else
                NSWorkspace.sharedWorkspace().openURL(queryURL)
            #endif
            }, failure: failure)
    }

    func postOAuthRequestTokenWithCallbackURL(callbackURL: NSURL, success: TokenRequestSuccessHandler, failure: RequestFailureHandler?) {
        let parameters: Dictionary<String, AnyObject> = ["oauth_callback": callbackURL.absoluteString as String]

        self.client.requestWithPath("/oauth/request_token", baseURL: self.apiURL, method: "POST", parameters: parameters, progress: nil, success: {
            responseString, response in

            let accessToken = SwifterCredential.OAuthAccessToken(queryString: responseString)
            success(accessToken: accessToken, response: response)

            }, failure: failure)
    }

    func postOAuthAccessTokenWithRequestToken(requestToken: SwifterCredential.OAuthAccessToken, success: TokenRequestSuccessHandler, failure: RequestFailureHandler?) {
        if requestToken.verifier {
            let parameters: Dictionary<String, AnyObject> = ["oauth_token": requestToken.key, "oauth_verifier": requestToken.verifier!]

            self.client.requestWithPath("/oauth/access_token", baseURL: self.apiURL, method: "POST", parameters: parameters, progress: nil, success: {
                responseString, response in

                let accessToken = SwifterCredential.OAuthAccessToken(queryString: responseString)
                success(accessToken: accessToken, response: response)

                }, failure: failure)
        }
        else {
            let userInfo = [NSLocalizedFailureReasonErrorKey: "Bad OAuth response received from server"]
            let error = NSError(domain: SwifterError.domain, code: NSURLErrorBadServerResponse, userInfo: userInfo)
            failure?(error: error)
        }
    }

    class func handleOpenURL(url: NSURL) {
        let notification = NSNotification(name: CallbackNotification.notificationName, object: nil,
            userInfo: [CallbackNotification.optionsURLKey: url])
        NSNotificationCenter.defaultCenter().postNotification(notification)
    }

}
