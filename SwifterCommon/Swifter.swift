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

    typealias RequestFailureHandler = (error: NSError) -> Void

    struct CallbackNotification {
        static let notificationName = "SwifterCallbackNotificationName"
        static let optionsURLKey = "SwifterCallbackNotificationOptionsURLKey"
    }

    struct SwifterError {
        static let domain = "SwifterErrorDomain"
    }

    var apiURL: NSURL
    var streamingURL: NSURL

    var oauthClient: SwifterOAuthClient

    var stringEncoding: NSStringEncoding {
        set {
            oauthClient.stringEncoding = stringEncoding
        }
        get {
            return oauthClient.stringEncoding
        }
    }

    init(apiURL: NSURL, streamingURL: NSURL, consumerKey: String, consumerSecret: String) {
        self.apiURL = apiURL
        self.streamingURL = streamingURL
        self.oauthClient = SwifterOAuthClient(consumerKey: consumerKey, consumerSecret: consumerSecret)
        self.stringEncoding = NSUTF8StringEncoding
    }

    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
}
