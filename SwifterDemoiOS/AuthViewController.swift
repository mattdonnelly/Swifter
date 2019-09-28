//
//  AuthViewController.swift
//  SwifterDemoiOS
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

import UIKit
import Accounts
import Social
import SwifteriOS
import SafariServices

class AuthViewController: UIViewController, SFSafariViewControllerDelegate {
    private var swifter = Swifter(
        consumerKey: "nLl1mNYc25avPPF4oIzMyQzft",
        consumerSecret: "Qm3e5JTXDhbbLl44cq6WdK00tSUwa17tWlO8Bf70douE4dcJe2")
    private var jsonResult: [JSON] = []

    @IBAction func didTouchUpInsideLoginButton(_ sender: AnyObject) {
        let failureHandler: (Error) -> Void = { error in
            self.alert(title: "Error", message: error.localizedDescription)
        }

        // You can change the authorizationMode to test different results via the AppDelegate
        switch authorizationMode {
        case .acaccount:
            let store = ACAccountStore()
            let type = store.accountType(withAccountTypeIdentifier: ACAccountTypeIdentifierTwitter)
            store.requestAccessToAccounts(with: type, options: nil) { granted, error in
                guard let twitterAccounts = store.accounts(with: type), granted else {
                    self.alert(title: "Error", message: error!.localizedDescription)
                    return
                }

                if twitterAccounts.isEmpty {
                    self.alert(title: "Error", message: "There are no Twitter accounts configured. You can add or create a Twitter account in Settings.")
                } else {
                    let twitterAccount = twitterAccounts[0] as! ACAccount
                    self.swifter = Swifter(account: twitterAccount)
                    self.fetchTwitterHomeStream()
                }
            }
        case .browser:
            let url = URL(string: "swifter://success")!
            swifter.authorize(withCallback: url, presentingFrom: self, success: { _, _ in
                self.fetchTwitterHomeStream()
            }, failure: failureHandler)
        case .sso:
            swifter.authorizeSSO(success: { _ in
                self.fetchTwitterHomeStream()
            }, failure: failureHandler)
        }
    }

    func fetchTwitterHomeStream() {
        let failureHandler: (Error) -> Void = { error in
            self.alert(title: "Error", message: error.localizedDescription)
        }
        swifter.getHomeTimeline(count: 20, success: { json in
            // Successfully fetched timeline, so lets create and push the table view
            self.jsonResult = json.array ?? []
            self.performSegue(withIdentifier: "showTweets", sender: self)
        }, failure: failureHandler)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? TweetsViewController else { return }
        destination.tweets = jsonResult
    }

    func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
