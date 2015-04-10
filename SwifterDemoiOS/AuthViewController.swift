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

class AuthViewController: UIViewController {
    
    // Default to using the iOS account framework for handling twitter auth
    let useACAccount = true

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    @IBAction func didTouchUpInsideLoginButton(sender: AnyObject) {
        let failureHandler: ((NSError) -> Void) = {
            error in

            self.alertWithTitle("Error", message: error.localizedDescription)
        }

        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate

        if useACAccount {

            let accountStore = ACAccountStore()
            let accountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)

            // Prompt the user for permission to their twitter account stored in the phone's settings
            accountStore.requestAccessToAccountsWithType(accountType, options: nil) {
                granted, error in

                if granted {
                    let twitterAccounts = accountStore.accountsWithAccountType(accountType)

                    if twitterAccounts?.count == 0
                    {
                        self.alertWithTitle("Error", message: "There are no Twitter accounts configured. You can add or create a Twitter account in Settings.")
                    }
                    else {
                        appDelegate.account = twitterAccounts[2] as ACAccount
                        appDelegate.swifter = Swifter(account: appDelegate.account!)

                        self.showPhotoView()
                    }
                }
                else {
                    self.alertWithTitle("Error", message: error.localizedDescription)
                }
            }
        }
        else {

            appDelegate.swifter.authorizeWithCallbackURL(NSURL(string: "swifter://success")!, success: {
                accessToken, response in

                },failure: failureHandler
            )
        }
    }
    
    func showPhotoView() {
        
        let failureHandler: ((NSError) -> Void) = {
            error in
            self.alertWithTitle("Error", message: error.localizedDescription)
        }

        // ensure that presentViewController happens from the main thread/queue
        dispatch_async(dispatch_get_main_queue(), {
            let photoViewController = self.storyboard!.instantiateViewControllerWithIdentifier("CameraViewController") as CameraViewController
            self.presentViewController(photoViewController, animated: true, completion: nil)
        });
        
        
    }

    func alertWithTitle(title: String, message: String) {
        var alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }

}