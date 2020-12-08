//
//  ViewController.swift
//  SwifterDemoMac
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

import Cocoa
import Accounts
import SwifterMac
import AuthenticationServices

enum AuthorizationMode {
    @available(macOS, deprecated: 10.13)
    case account
    case browser
}

let authorizationMode: AuthorizationMode = .browser

class ViewController: NSViewController {
    private var swifter = Swifter(
        consumerKey: "nLl1mNYc25avPPF4oIzMyQzft",
        consumerSecret: "Qm3e5JTXDhbbLl44cq6WdK00tSUwa17tWlO8Bf70douE4dcJe2"
    )
    @objc dynamic var tweets: [Tweet] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        switch authorizationMode {
        case .account:
            authorizeWithACAccountStore()
        case .browser:
            authorizeWithWebLogin()
        }
    }

    @available(macOS, deprecated: 10.13)
    private func authorizeWithACAccountStore() {
        if #available(macOS 10.13, *) {
            self.alert(title: "Deprecated",
                       message: "ACAccountStore was deprecated on macOS 10.13, please use the OAuth flow instead")
            return
        }
        let store = ACAccountStore()
        let type = store.accountType(withAccountTypeIdentifier: ACAccountTypeIdentifierTwitter)
        store.requestAccessToAccounts(with: type, options: nil) { granted, error in
            guard let twitterAccounts = store.accounts(with: type), granted else {
                self.alert(error: error)
                return
            }
            if twitterAccounts.isEmpty {
                self.alert(title: "Error", message: "There are no Twitter accounts configured. You can add or create a Twitter account in Settings.")
                return
            } else {
                let twitterAccount = twitterAccounts[0] as! ACAccount
                self.swifter = Swifter(account: twitterAccount)
                self.fetchTwitterHomeStream()
            }
        }
    }

    private func authorizeWithWebLogin() {
        let callbackUrl = URL(string: "swifter://success")!

        if #available(macOS 10.15, *) {
            swifter.authorize(withProvider: self, callbackURL: callbackUrl) { _, _ in
                self.fetchTwitterHomeStream()
            } failure: { self.alert(error: $0) }
        } else {
            swifter.authorize(withCallback: callbackUrl) { _, _ in
                self.fetchTwitterHomeStream()
            } failure: { self.alert(error: $0) }
        }
    }

    private func fetchTwitterHomeStream() {
        swifter.getHomeTimeline(count: 100) { json in
            guard let tweets = json.array else { return }
            self.tweets = tweets.map {
                return Tweet(name: $0["user"]["name"].string!, text: $0["text"].string!)
            }
        } failure: { self.alert(error: $0) }
    }

    private func alert(title: String, message: String) {
        let alert = NSAlert()
        alert.alertStyle = .warning
        alert.messageText = title
        alert.informativeText = message
        alert.runModal()
    }

    private func alert(error: Error) {
        NSAlert(error: error).runModal()
    }
}

// This is need for ASWebAuthenticationSession
@available(macOS 10.15, *)
extension ViewController: ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return self.view.window!
    }
}
