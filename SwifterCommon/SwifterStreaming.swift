//
//  SwifterStreaming.swift
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

    func postStatusesFilter(follow: String[]?, track: String[]?, locations: String[]?, delimited: Bool?, stallWarnings: Bool?, progress: JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler) {
        assert(follow || track || locations, "At least one predicate parameter (follow, locations, or track) must be specified")

        let path = "statuses/filter.json"

        var parameters = Dictionary<String, AnyObject>()
        if follow {
            parameters["follow"] = follow!.bridgeToObjectiveC().componentsJoinedByString(",")
        }
        if track {
            parameters["track"] = track!.bridgeToObjectiveC().componentsJoinedByString(",")
        }
        if locations {
            parameters["locations"] = locations!.bridgeToObjectiveC().componentsJoinedByString(",")
        }
        if delimited {
            parameters["delimited"] = delimited!
        }
        if stallWarnings {
            parameters["stall_warnings"] = stallWarnings!
        }

        self.postJSONWithPath(path, baseURL: self.streamURL, parameters: parameters, progress: progress, success: nil, failure: failure)
    }

    func getStatusesSampleDelimited(delimited: Bool?, stallWarnings: Bool?, progress: JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "statuses/sample.json"

        var parameters = Dictionary<String, AnyObject>()
        if delimited {
            parameters["delimited"] = delimited!
        }
        if stallWarnings {
            parameters["stall_warnings"] = stallWarnings!
        }

        self.getJSONWithPath(path, baseURL: self.streamURL, parameters: parameters, progress: progress, success: nil, failure: failure)
    }

    func getStatusesFirehose(count: Int?, delimited: Bool?, stallWarnings: Bool?, progress: JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "statuses/firehose.json"

        var parameters = Dictionary<String, AnyObject>()
        if count {
            parameters["count"] = count!
        }
        if delimited {
            parameters["delimited"] = delimited!
        }
        if stallWarnings {
            parameters["stall_warnings"] = stallWarnings!
        }

        self.getJSONWithPath(path, baseURL: self.streamURL, parameters: parameters, progress: progress, success: nil, failure: failure)
    }

    func getUserStream(delimited: Bool?, stallWarnings: Bool?, includeMessagesFromFollowedAccounts: Bool?, includeReplies: Bool?, track: String[]?, locations: String[]?, stringifyFriendIDs: Bool?, progress: JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "user.json"

        var parameters = Dictionary<String, AnyObject>()
        if delimited {
            parameters["delimited"] = delimited!
        }
        if stallWarnings {
            parameters["stall_warnings"] = stallWarnings!
        }
        if includeMessagesFromFollowedAccounts {
            if includeMessagesFromFollowedAccounts! {
                parameters["with"] = "user"
            }
        }
        if includeReplies {
            if includeReplies! {
                parameters["replies"] = "all"
            }
        }
        if track {
            parameters["track"] = track!.bridgeToObjectiveC().componentsJoinedByString(",")
        }
        if locations {
            parameters["locations"] = locations!.bridgeToObjectiveC().componentsJoinedByString(",")
        }
        if stringifyFriendIDs {
            parameters["stringify_friend_ids"] = stringifyFriendIDs!
        }

        self.postJSONWithPath(path, baseURL: self.userStreamURL, parameters: parameters, progress: progress, success: nil, failure: failure)
    }

    func getFollowStream(delimited: Bool?, stallWarnings: Bool?, includeMessagesFromFollowedAccounts: Bool?, includeReplies: Bool?, stringifyFriendIDs: Bool?, progress: JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "site.json"

        var parameters = Dictionary<String, AnyObject>()
        if delimited {
            parameters["delimited"] = delimited!
        }
        if stallWarnings {
            parameters["stall_warnings"] = stallWarnings!
        }
        if includeMessagesFromFollowedAccounts {
            if includeMessagesFromFollowedAccounts! {
                parameters["with"] = "user"
            }
        }
        if includeReplies {
            if includeReplies! {
                parameters["replies"] = "all"
            }
        }
        if stringifyFriendIDs {
            parameters["stringify_friend_ids"] = stringifyFriendIDs!
        }

        self.postJSONWithPath(path, baseURL: self.siteStreamURL, parameters: parameters, progress: progress, success: nil, failure: failure)
    }

}
