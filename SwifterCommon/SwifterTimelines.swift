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

    func getTimelineAtPath(path: String, parameters: Dictionary<String, AnyObject>, count: Int?, sinceID: Int?, maxID: Int?, trimUser: Bool?, contributorDetails: Bool?, includeEntities: Bool?, success: JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        var params = parameters

        if count {
            params["count"] = count!
        }
        if sinceID {
            params["since_id"] = sinceID!
        }
        if maxID {
            params["max_id"] = maxID!
        }
        if trimUser {
            params["trim_user"] = Int(trimUser!)
        }
        if contributorDetails {
            params["contributor_details"] = Int(!contributorDetails!)
        }
        if includeEntities {
            params["include_entities"] = Int(includeEntities!)
        }

        self.getJSONWithPath(path, baseURL: self.apiURL, parameters: params, progress: nil, success: success, failure: failure)
    }

    func getStatusesMentionTimelineWithCount(count: Int?, sinceID: Int?, maxID: Int?, trimUser: Bool?, contributorDetails: Bool?, includeEntities: Bool?, success: JSONRequestSuccessHandler, failure: RequestFailureHandler?) {
        self.getTimelineAtPath("statuses/mentions_timeline.json", parameters: [:], count: count, sinceID: sinceID, maxID: maxID, trimUser: trimUser, contributorDetails: contributorDetails, includeEntities: includeEntities, success: success, failure: failure)
    }

    func getStatusesUserTimelineWithUserID(userID: String, count: Int?, sinceID: Int?, maxID: Int?, trimUser: Bool?, contributorDetails: Bool?, includeEntities: Bool?, success: JSONRequestSuccessHandler, failure: RequestFailureHandler?) {
        var parameters: Dictionary<String, AnyObject> = ["user_id": userID.bridgeToObjectiveC()]

        self.getTimelineAtPath("statuses/mentions_timeline.json", parameters: [:], count: count, sinceID: sinceID, maxID: maxID, trimUser: trimUser, contributorDetails: contributorDetails, includeEntities: includeEntities, success: success, failure: failure)
    }

    func getStatusesHomeTimelineWithCount(count: Int?, sinceID: Int?, maxID: Int?, trimUser: Bool?, contributorDetails: Bool?, includeEntities: Bool?, success: JSONRequestSuccessHandler, failure: RequestFailureHandler?) {
        self.getTimelineAtPath("statuses/home_timeline.json", parameters: [:], count: count, sinceID: sinceID, maxID: maxID, trimUser: trimUser, contributorDetails: contributorDetails, includeEntities: includeEntities, success: success, failure: failure)
    }

    func getStatusesRetweetsOfMeWithCount(count: Int?, sinceID: Int?, maxID: Int?, trimUser: Bool?, contributorDetails: Bool?, includeEntities: Bool?, success: JSONRequestSuccessHandler, failure: RequestFailureHandler?) {
        self.getTimelineAtPath("statuses/retweets_of_me.json", parameters: [:], count: count, sinceID: sinceID, maxID: maxID, trimUser: trimUser, contributorDetails: contributorDetails, includeEntities: includeEntities, success: success, failure: failure)
    }

}
