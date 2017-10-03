//
//  SwifterTimelines.swift
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

    // Convenience method
    private func getTimeline(at path: String, parameters: Dictionary<String, Any>, count: Int? = nil, sinceID: String? = nil, maxID: String? = nil, trimUser: Bool? = nil, contributorDetails: Bool? = nil, includeEntities: Bool? = nil, success: SuccessHandler? = nil, failure: FailureHandler? = nil) {
        var params = parameters
        params["count"] ??= count
        params["since_id"] ??= sinceID
        params["max_id"] ??= maxID
        params["trim_user"] ??= trimUser
        params["contributor_details"] ??= contributorDetails
        params["include_entities"] ??= includeEntities

        self.getJSON(path: path, baseURL: .api, parameters: params, success: { json, _ in
            success?(json)
            }, failure: failure)
    }

    /**
    GET	statuses/mentions_timeline
    Returns Tweets (*: mentions for the user)

    Returns the 20 most recent mentions (tweets containing a users's @screen_name) for the authenticating user.

    The timeline returned is the equivalent of the one seen when you view your mentions on twitter.com.

    This method can only return up to 800 tweets.
    */
    public func getMentionsTimelineTweets(count: Int? = nil, sinceID: String? = nil, maxID: String? = nil, trimUser: Bool? = nil, contributorDetails: Bool? = nil, includeEntities: Bool? = nil, success: SuccessHandler? = nil, failure: FailureHandler?) {
        self.getTimeline(at: "statuses/mentions_timeline.json", parameters: [:], count: count, sinceID: sinceID, maxID: maxID, trimUser: trimUser, contributorDetails: contributorDetails, includeEntities: includeEntities, success: success, failure: failure)
    }


    /**
    GET	statuses/user_timeline
    Returns Tweets (*: tweets for the user)

    Returns a collection of the most recent Tweets posted by the user indicated by the screen_name or user_id parameters.

    User timelines belonging to protected users may only be requested when the authenticated user either "owns" the timeline or is an approved follower of the owner.

    The timeline returned is the equivalent of the one seen when you view a user's profile on twitter.com.

    This method can only return up to 3,200 of a user's most recent Tweets. Native retweets of other statuses by the user is included in this total, regardless of whether include_rts is set to false when requesting this resource.
    */
    public func getTimeline(for userID: String, count: Int? = nil, sinceID: String? = nil, maxID: String? = nil, trimUser: Bool? = nil, contributorDetails: Bool? = nil, includeEntities: Bool? = nil, success: SuccessHandler? = nil, failure: FailureHandler? = nil) {
        let parameters: Dictionary<String, Any> = ["user_id": userID]

        self.getTimeline(at: "statuses/user_timeline.json", parameters: parameters, count: count, sinceID: sinceID, maxID: maxID, trimUser: trimUser, contributorDetails: contributorDetails, includeEntities: includeEntities, success: success, failure: failure)
    }

    /**
    GET	statuses/home_timeline

    Returns Tweets (*: tweets from people the user follows)

    Returns a collection of the most recent Tweets and retweets posted by the authenticating user and the users they follow. The home timeline is central to how most users interact with the Twitter service.

    Up to 800 Tweets are obtainable on the home timeline. It is more volatile for users that follow many users or follow users who tweet frequently.
    */
    public func getHomeTimeline(count: Int? = nil, sinceID: String? = nil, maxID: String? = nil, trimUser: Bool? = nil, contributorDetails: Bool? = nil, includeEntities: Bool? = nil, success: SuccessHandler? = nil, failure: FailureHandler? = nil) {
        self.getTimeline(at: "statuses/home_timeline.json", parameters: [:], count: count, sinceID: sinceID, maxID: maxID, trimUser: trimUser, contributorDetails: contributorDetails, includeEntities: includeEntities, success: success, failure: failure)
    }

    /**
    GET    statuses/retweets_of_me

    Returns the most recent tweets authored by the authenticating user that have been retweeted by others. This timeline is a subset of the user's GET statuses/user_timeline. See Working with Timelines for instructions on traversing timelines.
    */
    public func getRetweetsOfMe(count: Int? = nil, sinceID: String? = nil, maxID: String? = nil, trimUser: Bool? = nil, contributorDetails: Bool? = nil, includeEntities: Bool? = nil, success: SuccessHandler? = nil, failure: FailureHandler? = nil) {
        self.getTimeline(at: "statuses/retweets_of_me.json", parameters: [:], count: count, sinceID: sinceID, maxID: maxID, trimUser: trimUser, contributorDetails: contributorDetails, includeEntities: includeEntities, success: success, failure: failure)
    }

}
