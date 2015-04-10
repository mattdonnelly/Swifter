//
//  TweetsViewController.swift
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
import SwifteriOS

import TwitterKit

class TweetsViewController: UITableViewController {

    var tweets: [TWTRTweet] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    func showTweets() {
        Twitter.sharedInstance().logInGuestWithCompletion { (session: TWTRGuestSession!, error: NSError!) in
            Twitter.sharedInstance().APIClient.loadTweetWithID("20") { (tweet: TWTRTweet!, error: NSError!) in
                self.view.addSubview(TWTRTweetView(tweet: tweet))
            }
        }
        
//        Twitter.sharedInstance().APIClient.loadTweetsWithIDs(<#tweetIDStrings: [AnyObject]!#>, completion: <#TWTRLoadTweetsCompletion!##([AnyObject]!, NSError!) -> Void#>)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let failureHandler: ((NSError) -> Void) = {
            error in
            self.alertWithTitle("Error", message: error.localizedDescription)
        }
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        appDelegate.swifter.getStatusesUserTimelineWithUserID(appDelegate.account!.username, count: 20, sinceID: nil, maxID: nil, trimUser: true, contributorDetails: false, includeEntities: true,
            success: {
                (statuses: [JSONValue]?) in

                var ids  : [AnyObject] = []
                for s :JSONValue in statuses!.generate() {
                    ids.append(s["id_str"].string!);
                }
                
                Twitter.sharedInstance().logInGuestWithCompletion { (session: TWTRGuestSession!, error: NSError!) in
                    Twitter.sharedInstance().APIClient.loadTweetsWithIDs(ids) { (completion: [AnyObject]!, error: NSError!) in

                        var tweets : [TWTRTweet] = []
                        for o : AnyObject in completion {
                            
                            print(o)
                            
                        }

                    }
                }
            },
            failure: failureHandler
        )
        
        println("TweetsViewController viewDidLoad")
        
    }
    
    override func viewWillLayoutSubviews()
    {
        super.viewWillLayoutSubviews()
        self.tableView.contentInset = UIEdgeInsetsMake(self.topLayoutGuide.length, 0, 0, 0)
        self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(self.topLayoutGuide.length, 0, 0, 0)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
//        var id = tweets[indexPath.row]["id"].string
        
        let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: nil)

//        cell.textLabel?.text = tweets[indexPath.row]["text"].string
        cell.textLabel?.text = "test text"
        
        return cell
    }
    
    func alertWithTitle(title: String, message: String) {
        var alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }


}
