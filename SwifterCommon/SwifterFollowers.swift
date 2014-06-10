//
//  SwifterFollowers.swift
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

    func getFriendshipsNoRetweetsIDsWithStringifyIDs(stringifyIDs: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "friendships/no_retweets/ids.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["stringify_ids"] = stringifyIDs!.bridgeToObjectiveC()

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getFriendsIDsWithID(id: Int, cursor: Int?, stringifyIDs: Bool?, count: Int?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "friends/ids.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["id"] = id.bridgeToObjectiveC()

        if cursor {
            parameters["cursor"] = cursor!.bridgeToObjectiveC()
        }
        if stringifyIDs {
            parameters["stringify_ids"] = stringifyIDs!.bridgeToObjectiveC()
        }
        if count {
            parameters["count"] = count!.bridgeToObjectiveC()
        }

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getFriendsIDsWithScreenName(screenName: String, cursor: Int?, stringifyIDs: Bool?, count: Int?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "friends/ids.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["screen_name"] = screenName.bridgeToObjectiveC()

        if cursor {
            parameters["cursor"] = cursor!.bridgeToObjectiveC()
        }
        if stringifyIDs {
            parameters["stringify_ids"] = stringifyIDs!.bridgeToObjectiveC()
        }
        if count {
            parameters["count"] = count!.bridgeToObjectiveC()
        }

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getFollowersIDsWithID(id: Int, cursor: Int?, stringifyIDs: Bool?, count: Int?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "followers/ids.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["id"] = id.bridgeToObjectiveC()

        if cursor {
            parameters["cursor"] = cursor!.bridgeToObjectiveC()
        }
        if stringifyIDs {
            parameters["stringify_ids"] = stringifyIDs!.bridgeToObjectiveC()
        }
        if count {
            parameters["count"] = count!.bridgeToObjectiveC()
        }

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getFollowersIDsWithScreenName(screenName: String, cursor: Int?, stringifyIDs: Bool?, count: Int?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "followers/ids.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["screen_name"] = screenName.bridgeToObjectiveC()

        if cursor {
            parameters["cursor"] = cursor!.bridgeToObjectiveC()
        }
        if stringifyIDs {
            parameters["stringify_ids"] = stringifyIDs!.bridgeToObjectiveC()
        }
        if count {
            parameters["count"] = count!.bridgeToObjectiveC()
        }

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getFriendshipsIncomingWithCursor(cursor: String?, stringifyIDs: String?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "friendships/incoming.json"

        var parameters = Dictionary<String, AnyObject>()
        if cursor {
            parameters["cursor"] = cursor!.bridgeToObjectiveC()
        }
        if stringifyIDs {
            parameters["stringify_urls"] = stringifyIDs!.bridgeToObjectiveC()
        }

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getFriendshipsOutgoingWithCursor(cursor: String?, stringifyIDs: String?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "friendships/outgoing.json"

        var parameters = Dictionary<String, AnyObject>()
        if cursor {
            parameters["cursor"] = cursor!.bridgeToObjectiveC()
        }
        if stringifyIDs {
            parameters["stringify_urls"] = stringifyIDs!.bridgeToObjectiveC()
        }

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postCreateFriendshipWithID(id: Int, follow: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "friendships/create.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["id"] = id.bridgeToObjectiveC()

        if follow {
            parameters["follow"] = follow!.bridgeToObjectiveC()
        }

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postCreateFriendshipWithScreenName(screenName: String, follow: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "friendships/create.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["screen_name"] = screenName.bridgeToObjectiveC()

        if follow {
            parameters["follow"] = follow!.bridgeToObjectiveC()
        }

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postDestroyFriendshipWithID(id: Int, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "friendships/destroy.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["id"] = id.bridgeToObjectiveC()

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postDestroyFriendshipWithScreenName(screenName: String, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "friendships/destroy.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["screen_name"] = screenName.bridgeToObjectiveC()

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postUpdateFriendshipWithID(id: Int, device: Bool?, retweets: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "friendships/update.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["id"] = id.bridgeToObjectiveC()

        if device {
            parameters["device"] = device!.bridgeToObjectiveC()
        }
        if retweets {
            parameters["retweets"] = retweets!.bridgeToObjectiveC()
        }

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postUpdateFriendshipWithScreenName(screenName: String, device: Bool?, retweets: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "friendships/update.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["screen_name"] = screenName.bridgeToObjectiveC()

        if device {
            parameters["device"] = device!.bridgeToObjectiveC()
        }
        if retweets {
            parameters["retweets"] = retweets!.bridgeToObjectiveC()
        }

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getFriendshipsShowWithSourceID(sourceID: Int?, orSourceScreenName sourceScreenName: String?, targetID: Int?, orTargetScreenName targetScreenName: String?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        assert(sourceID || sourceScreenName, "Either a source screenName or a userID must be provided.")
        assert(targetID || targetScreenName, "Either a target screenName or a userID must be provided.")

        let path = "friendships/show.json"

        var parameters = Dictionary<String, AnyObject>()
        if sourceID {
            parameters["source_id"] = sourceID!.bridgeToObjectiveC()
        }
        else if sourceScreenName {
            parameters["source_screen_name"] = sourceScreenName!.bridgeToObjectiveC()
        }
        if targetID {
            parameters["target_id"] = targetID!.bridgeToObjectiveC()
        }
        else if targetScreenName {
            parameters["targetScreenName"] = targetScreenName!.bridgeToObjectiveC()
        }

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getFriendsListWithID(id: Int, cursor: Int?, count: Int?, skipStatus: Bool?, includeUserEntities: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "friendships/list.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["id"] = id.bridgeToObjectiveC()

        if cursor {
            parameters["cursor"] = cursor!.bridgeToObjectiveC()
        }
        if count {
            parameters["count"] = count!.bridgeToObjectiveC()
        }
        if skipStatus {
            parameters["skip_status"] = skipStatus!.bridgeToObjectiveC()
        }
        if includeUserEntities {
            parameters["include_user_entities"] = includeUserEntities!.bridgeToObjectiveC()
        }

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getFriendsListWithScreenName(screenName: String, cursor: Int?, count: Int?, skipStatus: Bool?, includeUserEntities: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "friendships/list.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["screen_name"] = screenName.bridgeToObjectiveC()

        if cursor {
            parameters["cursor"] = cursor!.bridgeToObjectiveC()
        }
        if count {
            parameters["count"] = count!.bridgeToObjectiveC()
        }
        if skipStatus {
            parameters["skip_status"] = skipStatus!.bridgeToObjectiveC()
        }
        if includeUserEntities {
            parameters["include_user_entities"] = includeUserEntities!.bridgeToObjectiveC()
        }

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getFollowersListWithID(id: Int, cursor: Int?, count: Int?, skipStatus: Bool?, includeUserEntities: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "followers/list.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["id"] = id.bridgeToObjectiveC()

        if cursor {
            parameters["cursor"] = cursor!.bridgeToObjectiveC()
        }
        if count {
            parameters["count"] = count!.bridgeToObjectiveC()
        }
        if skipStatus {
            parameters["skip_status"] = skipStatus!.bridgeToObjectiveC()
        }
        if includeUserEntities {
            parameters["include_user_entities"] = includeUserEntities!.bridgeToObjectiveC()
        }

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getFollowersListWithScreenName(screenName: String, cursor: Int?, count: Int?, skipStatus: Bool?, includeUserEntities: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "followers/list.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["screen_name"] = screenName.bridgeToObjectiveC()

        if cursor {
            parameters["cursor"] = cursor!.bridgeToObjectiveC()
        }
        if count {
            parameters["count"] = count!.bridgeToObjectiveC()
        }
        if skipStatus {
            parameters["skip_status"] = skipStatus!.bridgeToObjectiveC()
        }
        if includeUserEntities {
            parameters["include_user_entities"] = includeUserEntities!.bridgeToObjectiveC()
        }

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getFriendshipsLookupWithScreenName(screenName: String, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "followers/lookup.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["screen_name"] = screenName.bridgeToObjectiveC()

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getFriendshipsLookupWithID(id: Int, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "followers/lookup.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["id"] = id.bridgeToObjectiveC()

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getUsersContributeesWithUserID(id: Int, includeEntities: Bool?, skipStatus: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "users/contributees.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["id"] = id.bridgeToObjectiveC()

        if includeEntities {
            parameters["include_entities"] = includeEntities!.bridgeToObjectiveC()
        }
        if skipStatus {
            parameters["skip_status"] = skipStatus!.bridgeToObjectiveC()
        }

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getUsersContributeesWithScreenName(screenName: String, includeEntities: Bool?, skipStatus: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "users/contributees.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["screen_name"] = screenName.bridgeToObjectiveC()

        if includeEntities {
            parameters["include_entities"] = includeEntities!.bridgeToObjectiveC()
        }
        if skipStatus {
            parameters["skip_status"] = skipStatus!.bridgeToObjectiveC()
        }

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getUsersContributorsWithUserID(id: Int, includeEntities: Bool?, skipStatus: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "users/contributors.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["id"] = id.bridgeToObjectiveC()

        if includeEntities {
            parameters["include_entities"] = includeEntities!.bridgeToObjectiveC()
        }
        if skipStatus {
            parameters["skip_status"] = skipStatus!.bridgeToObjectiveC()
        }

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getUsersContributorsWithScreenName(screenName: String, includeEntities: Bool?, skipStatus: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "users/contributors.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["screen_name"] = screenName.bridgeToObjectiveC()

        if includeEntities {
            parameters["include_entities"] = includeEntities!.bridgeToObjectiveC()
        }
        if skipStatus {
            parameters["skip_status"] = skipStatus!.bridgeToObjectiveC()
        }

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postAccountRemoveProfileBannerWithSuccess(success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "account/remove_profile_banner.json"

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: [:], progress: nil, success: success, failure: failure)
    }

    func postAccountUpdateProfileBannerWithImageData(imageData: NSData?, width: Int?, height: Int?, offsetLeft: Int?, offsetTop: Int?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "account/update_profile_banner.json"

        var parameters = Dictionary<String, AnyObject>()
        if imageData {
            parameters["banner"] = imageData!.base64EncodedStringWithOptions(nil).bridgeToObjectiveC()
        }
        if width {
            parameters["width"] = width!.bridgeToObjectiveC()
        }
        if height {
            parameters["height"] = height!.bridgeToObjectiveC()
        }
        if offsetLeft {
            parameters["offset_left"] = offsetLeft!.bridgeToObjectiveC()
        }
        if offsetTop {
            parameters["offset_top"] = offsetTop!.bridgeToObjectiveC()
        }

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getUsersProfileBannerWithUserID(userID: Int, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "users/profile_banner.json"

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: [:], progress: nil, success: success, failure: failure)
    }

}
