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

public extension Swifter {

    /**
    POST	statuses/filter

    Returns public statuses that match one or more filter predicates. Multiple parameters may be specified which allows most clients to use a single connection to the Streaming API. Both GET and POST requests are supported, but GET requests with too many parameters may cause the request to be rejected for excessive URL length. Use a POST request to avoid long URLs.

    The track, follow, and locations fields should be considered to be combined with an OR operator. track=foo&follow=1234 returns Tweets matching "foo" OR created by user 1234.

    The default access level allows up to 400 track keywords, 5,000 follow userids and 25 0.1-360 degree location boxes. If you need elevated access to the Streaming API, you should explore our partner providers of Twitter data here: https://dev.twitter.com/programs/twitter-certified-products/products#Certified-Data-Products

    At least one predicate parameter (follow, locations, or track) must be specified.
    */
    public func postStatusesFilterWithFollow(follow: [String]? = nil, track: [String]? = nil, locations: [String]? = nil, delimited: Bool? = nil, stallWarnings: Bool? = nil, filter_level: String? = nil, language: [String]? = nil, progress: ((status: Dictionary<String, JSONValue>? ) -> Void)? = nil, stallWarningHandler: ((code: String?, message: String?, percentFull: Int?) -> Void)? = nil, failure: FailureHandler? = nil) -> SwifterHTTPRequest {
        assert(follow != nil || track != nil || locations != nil, "At least one predicate parameter (follow, locations, or track) must be specified")

        let path = "statuses/filter.json"

        var parameters = Dictionary<String, Any>()
        parameters["delimited"] ??= delimited
        parameters["stall_warnings"] ??= stallWarnings
        parameters["filter_level"] ??= filter_level
        parameters["language"] ??= language?.joinWithSeparator(",")
        parameters["follow"] ??= follow?.joinWithSeparator(",")
        parameters["track"] ??= track?.joinWithSeparator(",")
        parameters["locations"] ??= locations?.joinWithSeparator(",")

        return self.postJSONWithPath(path, baseURL: self.streamURL, parameters: parameters, downloadProgress: { json, _ in
            if let stallWarning = json["warning"].object {
                stallWarningHandler?(code: stallWarning["code"]?.string, message: stallWarning["message"]?.string, percentFull: stallWarning["percent_full"]?.integer)
            } else {
                progress?(status: json.object)
            }

            }, success: { json, _ in
                progress?(status: json.object)
                }, failure: failure)
    }

    /**
    GET    statuses/sample

    Returns a small random sample of all public statuses. The Tweets returned by the default access level are the same, so if two different clients connect to this endpoint, they will see the same Tweets.
    */
    public func getStatusesSampleDelimited(delimited: Bool? = nil, stallWarnings: Bool? = nil, filter_level: String? = nil, language: [String]? = nil, progress: ((status: Dictionary<String, JSONValue>?) -> Void)? = nil, stallWarningHandler: ((code: String?, message: String?, percentFull: Int?) -> Void)? = nil, failure: FailureHandler? = nil) -> SwifterHTTPRequest {
        let path = "statuses/sample.json"

        var parameters = Dictionary<String, Any>()
        parameters["delimited"] ??= delimited
        parameters["stall_warnings"] ??= stallWarnings
        parameters["filter_level"] ??= filter_level
        parameters["language"] ??= language?.joinWithSeparator(",")

        return self.getJSONWithPath(path, baseURL: self.streamURL, parameters: parameters, downloadProgress: { json, _ in
            if let stallWarning = json["warning"].object {
                stallWarningHandler?(code: stallWarning["code"]?.string, message: stallWarning["message"]?.string, percentFull: stallWarning["percent_full"]?.integer)
            } else {
                progress?(status: json.object)
            }

            }, success: { json, _ in
                progress?(status: json.object)
                }, failure: failure)
    }

    /**
    GET    statuses/firehose

    This endpoint requires special permission to access.

    Returns all public statuses. Few applications require this level of access. Creative use of a combination of other resources and various access levels can satisfy nearly every application use case.
    */
    public func getStatusesFirehose(count: Int? = nil, delimited: Bool? = nil, stallWarnings: Bool? = nil, filter_level: String? = nil, language: [String]? = nil, progress: ((status: Dictionary<String, JSONValue>?) -> Void)? = nil, stallWarningHandler: ((code: String?, message: String?, percentFull: Int?) -> Void)? = nil, failure: FailureHandler? = nil) -> SwifterHTTPRequest {
        let path = "statuses/firehose.json"

        var parameters = Dictionary<String, Any>()
        parameters["count"] ??= count
        parameters["delimited"] ??= delimited
        parameters["stall_warnings"] ??= stallWarnings
        parameters["filter_level"] ??= filter_level
        parameters["language"] ??= language?.joinWithSeparator(",")

        return self.getJSONWithPath(path, baseURL: self.streamURL, parameters: parameters, downloadProgress: { json, _ in
            if let stallWarning = json["warning"].object {
                stallWarningHandler?(code: stallWarning["code"]?.string, message: stallWarning["message"]?.string, percentFull: stallWarning["percent_full"]?.integer)
            } else {
                progress?(status: json.object)
            }

            }, success: { json, _ in
                progress?(status: json.object)
                }, failure: failure)
    }

    /**
    GET    user

    Streams messages for a single user, as described in User streams https://dev.twitter.com/docs/streaming-apis/streams/user
    */
    public func getUserStreamDelimited(delimited: Bool? = nil, stallWarnings: Bool? = nil, includeMessagesFromUserOnly: Bool = false, includeReplies: Bool = false, track: [String]? = nil, locations: [String]? = nil, stringifyFriendIDs: Bool? = nil, filter_level: String? = nil, language: [String]? = nil, progress: ((status: Dictionary<String, JSONValue>?) -> Void)? = nil, stallWarningHandler: ((code: String?, message: String?, percentFull: Int?) -> Void)? = nil, failure: FailureHandler? = nil) -> SwifterHTTPRequest {
        let path = "user.json"

        var parameters = Dictionary<String, Any>()
        parameters["delimited"] ??= delimited
        parameters["stall_warnings"] ??= stallWarnings
        parameters["filter_level"] ??= filter_level
        parameters["language"] ??= language?.joinWithSeparator(",")
        parameters["stringify_friend_ids"] ??= stringifyFriendIDs
        parameters["track"] ??= track?.joinWithSeparator(",")
        parameters["locations"] ??= locations?.joinWithSeparator(",")
        parameters["with"] ??= includeMessagesFromUserOnly ? "user" : nil
        parameters["replies"] ??= includeReplies ? "all" : nil

        return self.getJSONWithPath(path, baseURL: self.userStreamURL, parameters: parameters, downloadProgress: { json, _ in
            if let stallWarning = json["warning"].object {
                stallWarningHandler?(code: stallWarning["code"]?.string, message: stallWarning["message"]?.string, percentFull: stallWarning["percent_full"]?.integer)
            } else {
                progress?(status: json.object)
            }

            }, success: { json, _ in
                progress?(status: json.object)
                }, failure: failure)
    }

    /**
    GET    site

    Streams messages for a set of users, as described in Site streams https://dev.twitter.com/docs/streaming-apis/streams/site
    */
    public func getSiteStreamDelimited(delimited: Bool? = nil, stallWarnings: Bool? = nil, restrictToUserMessages: Bool = false, includeReplies: Bool = false, stringifyFriendIDs: Bool? = nil, progress: ((status: Dictionary<String, JSONValue>?) -> Void)? = nil, stallWarningHandler: ((code: String?, message: String?, percentFull: Int?) -> Void)? = nil, failure: FailureHandler? = nil) -> SwifterHTTPRequest {
        let path = "site.json"

        var parameters = Dictionary<String, Any>()
        parameters["delimited"] ??= delimited
        parameters["stall_warnings"] ??= stallWarnings
        parameters["stringify_friend_ids"] ??= stringifyFriendIDs
        parameters["with"] ??= restrictToUserMessages ? "user" : nil
        parameters["replies"] ??= includeReplies ? "all" : nil

        return self.getJSONWithPath(path, baseURL: self.streamURL, parameters: parameters, downloadProgress: { json, _ in
            stallWarningHandler?(code: json["warning"]["code"].string, message: json["warning"]["message"].string, percentFull: json["warning"]["percent_full"].integer)
            }, success: { json, _ in
                progress?(status: json.object)
            }, failure: failure)
    }
    
}
