//
//  OAuthToken.swift
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
