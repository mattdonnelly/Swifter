//
//  SwifterTweets.swift
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

    func getStatusesRetweetsWithID(id: Int, count: Int?, trimUser: Bool?, success: JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "statuses/retweets/\(id).json"

        var parameters = Dictionary<String, AnyObject>()
        if count {
            parameters["count"] = count!
        }
        if trimUser {
            parameters["trim_user"] = trimUser!
        }

        self.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }


    func getStatusesShowWithID(id: Int, count: Int?, trimUser: Bool?, includeMyRetweet: Bool?, includeEntities: Bool?, success: JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "statuses/show.json"

        var parameters = Dictionary<String, AnyObject>()
        if count {
            parameters["count"] = count!
        }
        if trimUser {
            parameters["trim_user"] = trimUser!
        }
        if includeMyRetweet {
            parameters["include_my_retweet"] = includeMyRetweet!
        }
        if includeEntities {
            parameters["include_entities"] = includeEntities!
        }

        self.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postStatusesDestroyWithID(id: Int, trimUser: Bool?, success: JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "statuses/destroy/\(id).json"

        var parameters = Dictionary<String, AnyObject>()
        if trimUser {
            parameters["trim_user"] = trimUser!
        }

        self.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postStatusesUpdate(status: String, mediaIDs: String[]?, inReplyToStatusID: Int?, lat: Double?, long: Double?, placeID: Double?, displayCoordinates: Bool?, trimUser: Bool?, success: JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        var path: String = "statuses/update.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["status"] = status

        if mediaIDs {
            let mediaIDsString = mediaIDs!.bridgeToObjectiveC().componentsJoinedByString(",")
            parameters["media_ids"] = mediaIDsString
        }

        if inReplyToStatusID {
            parameters["in_reply_to_status_id"] = inReplyToStatusID!
        }
        if placeID {
            parameters["place_id"] = placeID!
            parameters["display_coordinates"] = true
        }
        else if lat && long {
            parameters["lat"] = lat!
            parameters["long"] = long!
            parameters["display_coordinates"] = true
        }
        if trimUser {
            parameters["trim_user"] = trimUser!
        }

        self.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postStatusesRetweetWithID(id: Int, trimUser: Bool?, success: JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "statuses/retweet/\(id).json"

        var parameters = Dictionary<String, AnyObject>()
        if trimUser {
            parameters["trim_user"] = trimUser!
        }

        self.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getStatusesOEmbedWithID(id: Int, url: NSURL, maxWidth: Int?, hideMedia: Bool?, hideThread: Bool?, omitScript: Bool?, align: String?, related: String?, lang: String?, success: JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "statuses/oembed"

        var parameters = Dictionary<String, AnyObject>()
        parameters["id"] = id
        parameters["url"] = url

        if maxWidth {
            parameters["max_width"] = maxWidth!
        }
        if hideMedia {
            parameters["hide_media"] = hideMedia!
        }
        if hideThread {
            parameters["hide_thread"] = hideThread!
        }
        if omitScript {
            parameters["omit_scipt"] = omitScript!
        }
        if align {
            parameters["align"] = align!
        }
        if related {
            parameters["related"] = related!
        }
        if lang {
            parameters["lang"] = lang!
        }

        self.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getStatusesRetweetersWithID(id: Int, cursor: Int?, stringifyIDs: Bool?, success: JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "statuses/oembed"

        var parameters = Dictionary<String, AnyObject>()
        parameters["id"] = id

        if cursor {
            parameters["cursor"] = cursor!
        }
        if stringifyIDs {
            parameters["stringify_ids"] = cursor!
        }

        self.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

}
