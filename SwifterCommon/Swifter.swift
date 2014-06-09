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

    struct CallbackNotification {
        static let notificationName = "SwifterCallbackNotificationName"
        static let optionsURLKey = "SwifterCallbackNotificationOptionsURLKey"
    }

    struct SwifterError {
        static let domain = "SwifterErrorDomain"
    }

    var baseURL: NSURL

    var requestManager: SwifterOAuthClient

    var stringEncoding: NSStringEncoding {
        set {
            requestManager.stringEncoding = stringEncoding
        }
        get {
            return requestManager.stringEncoding
        }
    }

    init(baseURL: NSURL, consumerKey: String, consumerSecret: String) {
        self.baseURL = baseURL
        self.requestManager = SwifterOAuthClient(baseURL: baseURL, consumerKey: consumerKey, consumerSecret: consumerSecret)
        self.stringEncoding = NSUTF8StringEncoding
    }

    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    func authorizeWithCallbackURL(callbackURL: NSURL, success: SwifterTokenRequestSuccessHandler, failure: ((error: NSError) -> Void)?) {
        self.requestOAuthRequestTokenWithCallbackURL(callbackURL, success: {
            token, response in

            var requestToken = token

            NSNotificationCenter.defaultCenter().addObserverForName(CallbackNotification.notificationName, object: nil, queue: NSOperationQueue.mainQueue(), usingBlock:{
                notification in

                NSNotificationCenter.defaultCenter().removeObserver(self)

                let url = notification.userInfo[CallbackNotification.optionsURLKey] as NSURL

                let parameters = url.query.parametersFromQueryString()
                requestToken.verifier = parameters["oauth_verifier"]

                self.requestOAuthAccessTokenWithRequestToken(requestToken, success: {
                    accessToken, response in

                    self.requestManager.accessToken = accessToken
                    success(accessToken: accessToken, response: response)

                    }, failure: failure)
                })

            let authorizeURL = NSURL(string: "/oauth/authorize", relativeToURL: self.baseURL)
            let queryURL = NSURL(string: authorizeURL.absoluteString + "?oauth_token=\(token.key)")

            #if os(iOS)
                UIApplication.sharedApplication().openURL(queryURL)
                #else
                NSWorkspace.sharedWorkspace().openURL(queryURL)
            #endif
            }, failure: failure)
    }

    func requestOAuthRequestTokenWithCallbackURL(callbackURL: NSURL, success: SwifterTokenRequestSuccessHandler, failure: SwifterRequestFailureHandler?) {
        let parameters: Dictionary<String, AnyObject> = ["oauth_callback": callbackURL.absoluteString.bridgeToObjectiveC()]

        self.requestManager.postRequestWithPath("/oauth/request_token", parameters: parameters, success: {
            data, response in

            let responseString = NSString(data: data, encoding: NSUTF8StringEncoding)
            let accessToken = OAuthAccessToken(queryString: responseString)
            success(accessToken: accessToken, response: response)

            }, failure: failure)
    }

    func requestOAuthAccessTokenWithRequestToken(requestToken: OAuthAccessToken, success: SwifterTokenRequestSuccessHandler, failure: SwifterRequestFailureHandler?) {
        if requestToken.verifier {
            let parameters: Dictionary<String, AnyObject> = ["oauth_token": requestToken.key.bridgeToObjectiveC(), "oauth_verifier": requestToken.verifier!.bridgeToObjectiveC()]

            self.requestManager.postRequestWithPath("/oauth/access_token", parameters: parameters, success: {
                data, response in

                let responseString = NSString(data: data, encoding: NSUTF8StringEncoding)
                let accessToken = OAuthAccessToken(queryString: responseString)
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
