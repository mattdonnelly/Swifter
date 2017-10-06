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

#if os(iOS)
    import UIKit
    import SafariServices
#elseif os(macOS)
    import AppKit
#endif

public extension Swifter {
    
    public typealias TokenSuccessHandler = (Credential.OAuthAccessToken?, URLResponse) -> Void
    
    /**
     Begin Authorization with a Callback URL.
     - OS X only
     */
    #if os(macOS)
    public func authorize(with callbackURL: URL, success: TokenSuccessHandler?, failure: FailureHandler? = nil) {
        self.postOAuthRequestToken(with: callbackURL, success: { token, response in
            var requestToken = token!
            
            NotificationCenter.default.addObserver(forName: .SwifterCallbackNotification, object: nil, queue: .main) { notification in
                NotificationCenter.default.removeObserver(self)
                let url = notification.userInfo![CallbackNotification.optionsURLKey] as! URL
                let parameters = url.query!.queryStringParameters
                requestToken.verifier = parameters["oauth_verifier"]
                
                    self.postOAuthAccessToken(with: requestToken, success: { accessToken, response in
                    self.client.credential = Credential(accessToken: accessToken!)
                    success?(accessToken!, response)
                    }, failure: failure)
            }
            
            let authorizeURL = URL(string: "oauth/authorize", relativeTo: TwitterURL.oauth.url)
            let queryURL = URL(string: authorizeURL!.absoluteString + "?oauth_token=\(token!.key)")!
            NSWorkspace.shared.open(queryURL)
        }, failure: failure)
    }
    #endif
    
    /**
     Begin Authorization with a Callback URL
     
     - Parameter presentFromViewController: The viewController used to present the SFSafariViewController.
     The UIViewController must inherit SFSafariViewControllerDelegate
     
     */
    
    #if os(iOS)
    public func authorize(with callbackURL: URL, presentFrom presentingViewController: UIViewController? , success: TokenSuccessHandler?, failure: FailureHandler? = nil) {
        self.postOAuthRequestToken(with: callbackURL, success: { token, response in
            var requestToken = token!
            NotificationCenter.default.addObserver(forName: .SwifterCallbackNotification, object: nil, queue: .main) { notification in
                NotificationCenter.default.removeObserver(self)
                presentingViewController?.presentedViewController?.dismiss(animated: true, completion: nil)
                let url = notification.userInfo![CallbackNotification.optionsURLKey] as! URL
                
                let parameters = url.query!.queryStringParameters
                requestToken.verifier = parameters["oauth_verifier"]
                
                self.postOAuthAccessToken(with: requestToken, success: { accessToken, response in
                    self.client.credential = Credential(accessToken: accessToken!)
                    success?(accessToken!, response)
                    }, failure: failure)
            }
            
            let authorizeURL = URL(string: "oauth/authorize", relativeTo: TwitterURL.oauth.url)
            let queryURL = URL(string: authorizeURL!.absoluteString + "?oauth_token=\(token!.key)")!
            
            if #available(iOS 9.0, *) , let delegate = presentingViewController as? SFSafariViewControllerDelegate {
                let safariView = SFSafariViewController(url: queryURL)
                safariView.delegate = delegate
                presentingViewController?.present(safariView, animated: true, completion: nil)
            } else {
                UIApplication.shared.openURL(queryURL)
            }
        }, failure: failure)
    }
    #endif
    
    public class func handleOpenURL(_ url: URL) {
        let notification = Notification(name: .SwifterCallbackNotification, object: nil, userInfo: [CallbackNotification.optionsURLKey: url])
        NotificationCenter.default.post(notification)
    }
    
    public func authorizeAppOnly(success: TokenSuccessHandler?, failure: FailureHandler?) {
        self.postOAuth2BearerToken(success: { json, response in
            if let tokenType = json["token_type"].string {
                if tokenType == "bearer" {
                    let accessToken = json["access_token"].string
                    
                    let credentialToken = Credential.OAuthAccessToken(key: accessToken!, secret: "")
                    
                    self.client.credential = Credential(accessToken: credentialToken)
                    
                    success?(credentialToken, response)
                } else {
                    let error = SwifterError(message: "Cannot find bearer token in server response", kind: .invalidAppOnlyBearerToken)
                    failure?(error)
                }
            } else if case .object = json["errors"] {
                let error = SwifterError(message: json["errors"]["message"].string!, kind: .responseError(code: json["errors"]["code"].integer!))
                failure?(error)
            } else {
                let error = SwifterError(message: "Cannot find JSON dictionary in response", kind: .invalidJSONResponse)
                failure?(error)
            }
            
            }, failure: failure)
    }
    
    public func postOAuth2BearerToken(success: JSONSuccessHandler?, failure: FailureHandler?) {
        let path = "oauth2/token"
        
        var parameters = Dictionary<String, Any>()
        parameters["grant_type"] = "client_credentials"
        
        self.jsonRequest(path: path, baseURL: .oauth, method: .POST, parameters: parameters, success: success, failure: failure)
    }
    
    public func invalidateOAuth2BearerToken(success: TokenSuccessHandler?, failure: FailureHandler?) {
        let path = "oauth2/invalidate_token"
        
        self.jsonRequest(path: path, baseURL: .oauth, method: .POST, parameters: [:], success: { json, response in
            if let accessToken = json["access_token"].string {
                self.client.credential = nil
                let credentialToken = Credential.OAuthAccessToken(key: accessToken, secret: "")
                success?(credentialToken, response)
            } else {
                success?(nil, response)
            }
        }, failure: failure)
    }
    
    public func postOAuthRequestToken(with callbackURL: URL, success: @escaping TokenSuccessHandler, failure: FailureHandler?) {
        let path = "oauth/request_token"
        let parameters: [String: Any] =  ["oauth_callback": callbackURL.absoluteString]
        
        self.client.post(path, baseURL: .oauth, parameters: parameters, uploadProgress: nil, downloadProgress: nil, success: { data, response in
            let responseString = String(data: data, encoding: .utf8)!
            let accessToken = Credential.OAuthAccessToken(queryString: responseString)
            success(accessToken, response)
        }, failure: failure)
    }
    
    public func postOAuthAccessToken(with requestToken: Credential.OAuthAccessToken, success: @escaping TokenSuccessHandler, failure: FailureHandler?) {
        if let verifier = requestToken.verifier {
            let path =  "oauth/access_token"
            let parameters: [String: Any] = ["oauth_token": requestToken.key, "oauth_verifier": verifier]
            
            self.client.post(path, baseURL: .oauth, parameters: parameters, uploadProgress: nil, downloadProgress: nil, success: { data, response in
                
                let responseString = String(data: data, encoding: .utf8)!
                let accessToken = Credential.OAuthAccessToken(queryString: responseString)
                success(accessToken, response)
                
                }, failure: failure)
        } else {
            let error = SwifterError(message: "Bad OAuth response received from server", kind: .badOAuthResponse)
            failure?(error)
        }
    }
    
}
