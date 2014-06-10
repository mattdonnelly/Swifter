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

extension Swifter {

    func getStatusesAtPath(path: String, parameters: Dictionary<String, AnyObject>, count: Int, sinceID: Int, maxID: Int, trimUser: Bool, contributorDetails: Bool, includeEntities: Bool, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        var params = parameters

        if count > 0 {
            params["count"] = count.bridgeToObjectiveC()
        }
        if sinceID > 0 {
            params["since_id"] = sinceID.bridgeToObjectiveC()
        }
        if maxID > 0 {
            params["max_id"] = maxID.bridgeToObjectiveC()
        }

        params["trim_user"] = Int(trimUser)
        params["contributor_details"] = Int(contributorDetails)
        params["include_entities"] = Int(includeEntities)

        self.oauthClient.jsonRequestWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getStatusesMentionTimelineWithCount(count: Int, sinceID: Int, maxID: Int, trimUser: Bool, contributorDetails: Bool, includeEntities: Bool, success: SwifterOAuthClient.JSONRequestSuccessHandler, failure: RequestFailureHandler?) {
        self.getStatusesAtPath("statuses/mentions_timeline.json", parameters: [:], count: count, sinceID: sinceID, maxID: maxID, trimUser: trimUser, contributorDetails: contributorDetails, includeEntities: includeEntities, success: success, failure: failure)
    }

    func getStatusesUserTimelineWithUserID(userID: String, count: Int, sinceID: Int, maxID: Int, trimUser: Bool, contributorDetails: Bool, includeEntities: Bool, success: SwifterOAuthClient.JSONRequestSuccessHandler, failure: RequestFailureHandler?) {
        var parameters: Dictionary<String, AnyObject> = ["user_id": userID.bridgeToObjectiveC()]

        self.getStatusesAtPath("statuses/mentions_timeline.json", parameters: [:], count: count, sinceID: sinceID, maxID: maxID, trimUser: trimUser, contributorDetails: contributorDetails, includeEntities: includeEntities, success: success, failure: failure)
    }

    func getStatusesHomeTimelineWithCount(count: Int, sinceID: Int, maxID: Int, trimUser: Bool, contributorDetails: Bool, includeEntities: Bool, success: SwifterOAuthClient.JSONRequestSuccessHandler, failure: RequestFailureHandler?) {
        self.getStatusesAtPath("statuses/home_timeline.json", parameters: [:], count: count, sinceID: sinceID, maxID: maxID, trimUser: trimUser, contributorDetails: contributorDetails, includeEntities: includeEntities, success: success, failure: failure)
    }

    func getStatusesRetweetsOfMeWithCount(count: Int, sinceID: Int, maxID: Int, trimUser: Bool, contributorDetails: Bool, includeEntities: Bool, success: SwifterOAuthClient.JSONRequestSuccessHandler, failure: RequestFailureHandler?) {
        self.getStatusesAtPath("statuses/retweets_of_me.json", parameters: [:], count: count, sinceID: sinceID, maxID: maxID, trimUser: trimUser, contributorDetails: contributorDetails, includeEntities: includeEntities, success: success, failure: failure)
    }

}
