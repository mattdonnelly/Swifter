//
//  SwifterLists.swift
//  Swifter
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

    func getListsSubscribedByUserWithID(userID: Int, reverse: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/list.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["userID"] = userID.bridgeToObjectiveC()

        if reverse {
            parameters["reverse"] = reverse!.bridgeToObjectiveC()
        }

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getListsSubscribedByUserWithScreenName(screenName: String, reverse: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/list.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["screen_name"] = screenName.bridgeToObjectiveC()

        if reverse {
            parameters["reverse"] = reverse!.bridgeToObjectiveC()
        }

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getListStatuesWithListID(listID: Int, ownerScreenName: String, sinceID: Int?, maxID: Int?, count: Int?, includeEntities: Bool?, includeRTs: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/statuses.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["list_id"] = listID.bridgeToObjectiveC()
        parameters["owner_screen_name"] = ownerScreenName.bridgeToObjectiveC()

        if sinceID {
            parameters["since_id"] = sinceID!.bridgeToObjectiveC()
        }
        if maxID {
            parameters["max_id"] = maxID!.bridgeToObjectiveC()
        }
        if count {
            parameters["count"] = count!.bridgeToObjectiveC()
        }
        if includeEntities {
            parameters["include_entities"] = includeEntities!.bridgeToObjectiveC()
        }
        if includeRTs {
            parameters["include_rts"] = includeRTs!.bridgeToObjectiveC()
        }

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getListStatuesWithListID(listID: Int, ownerID: Int, sinceID: Int?, maxID: Int?, count: Int?, includeEntities: Bool?, includeRTs: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/statuses.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["list_id"] = listID.bridgeToObjectiveC()
        parameters["owner_id"] = ownerID.bridgeToObjectiveC()

        if sinceID {
            parameters["since_id"] = sinceID!.bridgeToObjectiveC()
        }
        if maxID {
            parameters["max_id"] = maxID!.bridgeToObjectiveC()
        }
        if count {
            parameters["count"] = count!.bridgeToObjectiveC()
        }
        if includeEntities {
            parameters["include_entities"] = includeEntities!.bridgeToObjectiveC()
        }
        if includeRTs {
            parameters["include_rts"] = includeRTs!.bridgeToObjectiveC()
        }

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getListStatuesWithSlug(slug: String, ownerScreenName: String, sinceID: Int?, maxID: Int?, count: Int?, includeEntities: Bool?, includeRTs: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/statuses.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["slug"] = slug.bridgeToObjectiveC()
        parameters["owner_screen_name"] = ownerScreenName.bridgeToObjectiveC()

        if sinceID {
            parameters["since_id"] = sinceID!.bridgeToObjectiveC()
        }
        if maxID {
            parameters["max_id"] = maxID!.bridgeToObjectiveC()
        }
        if count {
            parameters["count"] = count!.bridgeToObjectiveC()
        }
        if includeEntities {
            parameters["include_entities"] = includeEntities!.bridgeToObjectiveC()
        }
        if includeRTs {
            parameters["include_rts"] = includeRTs!.bridgeToObjectiveC()
        }

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getListStatuesWithSlug(slug: String, ownerID: Int, sinceID: Int?, maxID: Int?, count: Int?, includeEntities: Bool?, includeRTs: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/statuses.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["slug"] = slug.bridgeToObjectiveC()
        parameters["owner_id"] = ownerID.bridgeToObjectiveC()

        if sinceID {
            parameters["since_id"] = sinceID!.bridgeToObjectiveC()
        }
        if maxID {
            parameters["max_id"] = maxID!.bridgeToObjectiveC()
        }
        if count {
            parameters["count"] = count!.bridgeToObjectiveC()
        }
        if includeEntities {
            parameters["include_entities"] = includeEntities!.bridgeToObjectiveC()
        }
        if includeRTs {
            parameters["include_rts"] = includeRTs!.bridgeToObjectiveC()
        }

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postDestroyListMembersWithListID(listID: Int, userID: Int, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/members/destroy.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["list_id"] = listID.bridgeToObjectiveC()
        parameters["user_id"] = userID.bridgeToObjectiveC()

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postDestroyListMembersWithListID(listID: Int, screenName: String, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/members/destroy.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["list_id"] = listID.bridgeToObjectiveC()
        parameters["screen_name"] = screenName.bridgeToObjectiveC()

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postDestroyListMembersWithSlug(slug: String, userID: Int, ownerScreenName: String, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/members/destroy.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["slug"] = slug.bridgeToObjectiveC()
        parameters["userID"] = userID.bridgeToObjectiveC()
        parameters["owner_screen_name"] = ownerScreenName.bridgeToObjectiveC()

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postDestroyListMemberWithSlug(slug: String, screenName: String, ownerScreenName: String, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/members/destroy.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["slug"] = slug.bridgeToObjectiveC()
        parameters["screen_name"] = screenName.bridgeToObjectiveC()
        parameters["owner_screen_name"] = ownerScreenName.bridgeToObjectiveC()

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postDestroyListMembersWithSlug(slug: String, userID: Int, ownerID: Int, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/members/destroy.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["slug"] = slug.bridgeToObjectiveC()
        parameters["userID"] = userID.bridgeToObjectiveC()
        parameters["owner_id"] = ownerID.bridgeToObjectiveC()

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postDestroyListMembersWithSlug(slug: String, screenName: String, ownerID: Int, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/members/destroy.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["slug"] = slug.bridgeToObjectiveC()
        parameters["screen_name"] = screenName.bridgeToObjectiveC()
        parameters["owner_id"] = ownerID.bridgeToObjectiveC()

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getListMembershipsWithUserID(userID: Int, cursor: Int?, filterToOwnedLists: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/memberships.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["user_id"] = userID.bridgeToObjectiveC()

        if cursor {
            parameters["cursor"] = cursor!.bridgeToObjectiveC()
        }
        if filterToOwnedLists {
            parameters["filter_to_owned_lists"] = filterToOwnedLists!.bridgeToObjectiveC()
        }

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getListMembershipsWithScreenName(screenName: String, cursor: Int?, filterToOwnedLists: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/memberships.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["screen_name"] = screenName.bridgeToObjectiveC()

        if cursor {
            parameters["cursor"] = cursor!.bridgeToObjectiveC()
        }
        if filterToOwnedLists {
            parameters["filter_to_owned_lists"] = filterToOwnedLists!.bridgeToObjectiveC()
        }

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getListSubscribersWithListID(listID: Int, ownerScreenName: String?, cursor: Int?, includeEntities: Bool?, skipStatus: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/subscribers.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["list_id"] = listID.bridgeToObjectiveC()
        if ownerScreenName {
            parameters["owner_screen_name"] = ownerScreenName!.bridgeToObjectiveC()
        }
        if cursor {
            parameters["cursor"] = cursor!.bridgeToObjectiveC()
        }
        if includeEntities {
            parameters["include_entities"] = includeEntities!.bridgeToObjectiveC()
        }
        if skipStatus {
            parameters["skip_status"] = skipStatus!.bridgeToObjectiveC()
        }

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getListSubscribersWithListID(listID: Int, ownerID: Int?, cursor: Int?, includeEntities: Bool?, skipStatus: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/subscribers.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["list_id"] = listID.bridgeToObjectiveC()
        if ownerID {
            parameters["owner_id"] = ownerID!.bridgeToObjectiveC()
        }
        if cursor {
            parameters["cursor"] = cursor!.bridgeToObjectiveC()
        }
        if includeEntities {
            parameters["include_entities"] = includeEntities!.bridgeToObjectiveC()
        }
        if skipStatus {
            parameters["skip_status"] = skipStatus!.bridgeToObjectiveC()
        }

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getListSubscribersWithSlug(slug: String, ownerScreenName: String?, cursor: Int?, includeEntities: Bool?, skipStatus: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/subscribers.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["slug"] = slug.bridgeToObjectiveC()
        if ownerScreenName {
            parameters["owner_screen_name"] = ownerScreenName!.bridgeToObjectiveC()
        }
        if cursor {
            parameters["cursor"] = cursor!.bridgeToObjectiveC()
        }
        if includeEntities {
            parameters["include_entities"] = includeEntities!.bridgeToObjectiveC()
        }
        if skipStatus {
            parameters["skip_status"] = skipStatus!.bridgeToObjectiveC()
        }

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getListSubscribersWithSlug(slug: String, ownerID: Int?, cursor: Int?, includeEntities: Bool?, skipStatus: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/subscribers.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["slug"] = slug.bridgeToObjectiveC()
        if ownerID {
            parameters["owner_id"] = ownerID!.bridgeToObjectiveC()
        }
        if cursor {
            parameters["cursor"] = cursor!.bridgeToObjectiveC()
        }
        if includeEntities {
            parameters["include_entities"] = includeEntities!.bridgeToObjectiveC()
        }
        if skipStatus {
            parameters["skip_status"] = skipStatus!.bridgeToObjectiveC()
        }

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postCreateListsSubscribersWithListID(listID: Int, ownerScreenName: String, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/subscribers/create.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["owner_screen_name"] = ownerScreenName.bridgeToObjectiveC()
        parameters["list_id"] = listID.bridgeToObjectiveC()

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postCreateListsSubscribersWithListID(listID: Int, ownerID: Int, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/subscribers/create.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["owner_id"] = ownerID.bridgeToObjectiveC()
        parameters["list_id"] = listID.bridgeToObjectiveC()

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postCreateListsSubscribersWithSlug(slug: String, ownerScreenName: String, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/subscribers/create.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["owner_screen_name"] = ownerScreenName.bridgeToObjectiveC()
        parameters["slug"] = slug.bridgeToObjectiveC()

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postCreateListsSubscribersWithSlug(slug: String, ownerID: Int, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/subscribers/create.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["owner_id"] = ownerID.bridgeToObjectiveC()
        parameters["slug"] = slug.bridgeToObjectiveC()

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getListSubscribersShowWithListID(listID: Int, userID: Int, includeEntities: Bool?, skipStatus: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/subscribers/show.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["list_id"] = listID.bridgeToObjectiveC()
        parameters["user_id"] = userID.bridgeToObjectiveC()

        if includeEntities {
            parameters["include_entities"] = includeEntities!.bridgeToObjectiveC()
        }
        if skipStatus {
            parameters["skip_status"] = skipStatus!.bridgeToObjectiveC()
        }

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getListSubscribersShowWithListID(listID: Int, screenName: String, includeEntities: Bool?, skipStatus: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/subscribers/show.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["list_id"] = listID.bridgeToObjectiveC()
        parameters["screen_name"] = screenName.bridgeToObjectiveC()

        if includeEntities {
            parameters["include_entities"] = includeEntities!.bridgeToObjectiveC()
        }
        if skipStatus {
            parameters["skip_status"] = skipStatus!.bridgeToObjectiveC()
        }

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getListSubscribersShowWithSlug(slug: String, ownerID: Int, userID: Int, includeEntities: Bool?, skipStatus: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/subscribers/show.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["slug"] = slug.bridgeToObjectiveC()
        parameters["owner_id"] = ownerID.bridgeToObjectiveC()
        parameters["user_id"] = userID.bridgeToObjectiveC()

        if includeEntities {
            parameters["include_entities"] = includeEntities!.bridgeToObjectiveC()
        }
        if skipStatus {
            parameters["skip_status"] = skipStatus!.bridgeToObjectiveC()
        }

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getListSubscribersShowWithSlug(slug: String, ownerID: Int, screenName: Int, includeEntities: Bool?, skipStatus: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/subscribers/show.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["slug"] = slug.bridgeToObjectiveC()
        parameters["owner_id"] = ownerID.bridgeToObjectiveC()
        parameters["screen_name"] = screenName.bridgeToObjectiveC()

        if includeEntities {
            parameters["include_entities"] = includeEntities!.bridgeToObjectiveC()
        }
        if skipStatus {
            parameters["skip_status"] = skipStatus!.bridgeToObjectiveC()
        }

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getListSubscribersShowWithSlug(slug: String, ownerScreenName: Int, userID: Int, includeEntities: Bool?, skipStatus: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/subscribers/show.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["slug"] = slug.bridgeToObjectiveC()
        parameters["owner_screen_name"] = ownerScreenName.bridgeToObjectiveC()
        parameters["user_id"] = userID.bridgeToObjectiveC()

        if includeEntities {
            parameters["include_entities"] = includeEntities!.bridgeToObjectiveC()
        }
        if skipStatus {
            parameters["skip_status"] = skipStatus!.bridgeToObjectiveC()
        }

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getListSubscribersShowWithSlug(slug: String, ownerScreenName: Int, screenName: Int, includeEntities: Bool?, skipStatus: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/subscribers/show.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["slug"] = slug.bridgeToObjectiveC()
        parameters["owner_screen_name"] = ownerScreenName.bridgeToObjectiveC()
        parameters["screen_name"] = screenName.bridgeToObjectiveC()

        if includeEntities {
            parameters["include_entities"] = includeEntities!.bridgeToObjectiveC()
        }
        if skipStatus {
            parameters["skip_status"] = skipStatus!.bridgeToObjectiveC()
        }

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postDestroyListsSubscribersWithListID(listID: Int, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/subscribers/destroy.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["listID"] = listID.bridgeToObjectiveC()

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postDestroyListsSubscribersWithSlug(slug: String, ownerScreenName: String, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/subscribers/destroy.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["slug"] = slug.bridgeToObjectiveC()
        parameters["owner_screen_name"] = ownerScreenName.bridgeToObjectiveC()

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postDestroyListsSubscribersWithSlug(slug: String, ownerID: Int, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/subscribers/destroy.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["slug"] = slug.bridgeToObjectiveC()
        parameters["owner_id"] = ownerID.bridgeToObjectiveC()

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postCreateListsMembersWithListID(listID: Int, userID: Int, includeEntities: Bool?, skipStatus: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/members/create_all.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["list_id"] = listID.bridgeToObjectiveC()
        parameters["user_id"] = userID.bridgeToObjectiveC()

        if includeEntities {
            parameters["include_entities"] = includeEntities!.bridgeToObjectiveC()
        }
        if skipStatus {
            parameters["skip_status"] = skipStatus!.bridgeToObjectiveC()
        }

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postCreateListsMembersWithListID(listID: Int, screenName: String, includeEntities: Bool?, skipStatus: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/members/create_all.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["list_id"] = listID.bridgeToObjectiveC()
        parameters["screen_name"] = screenName.bridgeToObjectiveC()

        if includeEntities {
            parameters["include_entities"] = includeEntities!.bridgeToObjectiveC()
        }
        if skipStatus {
            parameters["skip_status"] = skipStatus!.bridgeToObjectiveC()
        }

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postCreateListsMembersWithSlug(slug: String, ownerID: Int, userID: Int, includeEntities: Bool?, skipStatus: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/members/create_all.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["slug"] = slug.bridgeToObjectiveC()
        parameters["owner_id"] = ownerID.bridgeToObjectiveC()
        parameters["user_id"] = userID.bridgeToObjectiveC()

        if includeEntities {
            parameters["include_entities"] = includeEntities!.bridgeToObjectiveC()
        }
        if skipStatus {
            parameters["skip_status"] = skipStatus!.bridgeToObjectiveC()
        }

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postCreateListsMembersWithSlug(slug: String, ownerID: Int, screenName: Int, includeEntities: Bool?, skipStatus: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/members/create_all.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["slug"] = slug.bridgeToObjectiveC()
        parameters["owner_id"] = ownerID.bridgeToObjectiveC()
        parameters["screen_name"] = screenName.bridgeToObjectiveC()

        if includeEntities {
            parameters["include_entities"] = includeEntities!.bridgeToObjectiveC()
        }
        if skipStatus {
            parameters["skip_status"] = skipStatus!.bridgeToObjectiveC()
        }

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postCreateListsMembersWithSlug(slug: String, ownerScreenName: Int, userID: Int, includeEntities: Bool?, skipStatus: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/members/create_all.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["slug"] = slug.bridgeToObjectiveC()
        parameters["owner_screen_name"] = ownerScreenName.bridgeToObjectiveC()
        parameters["user_id"] = userID.bridgeToObjectiveC()

        if includeEntities {
            parameters["include_entities"] = includeEntities!.bridgeToObjectiveC()
        }
        if skipStatus {
            parameters["skip_status"] = skipStatus!.bridgeToObjectiveC()
        }

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postCreateListsMembersWithSlug(slug: String, ownerScreenName: Int, screenName: Int, includeEntities: Bool?, skipStatus: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/members/create_all.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["slug"] = slug.bridgeToObjectiveC()
        parameters["owner_screen_name"] = ownerScreenName.bridgeToObjectiveC()
        parameters["screen_name"] = screenName.bridgeToObjectiveC()

        if includeEntities {
            parameters["include_entities"] = includeEntities!.bridgeToObjectiveC()
        }
        if skipStatus {
            parameters["skip_status"] = skipStatus!.bridgeToObjectiveC()
        }
        
        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getListMembersShowWithListID(listID: Int, userID: Int, includeEntities: Bool?, skipStatus: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/members/show.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["list_id"] = listID.bridgeToObjectiveC()
        parameters["user_id"] = userID.bridgeToObjectiveC()

        if includeEntities {
            parameters["include_entities"] = includeEntities!.bridgeToObjectiveC()
        }
        if skipStatus {
            parameters["skip_status"] = skipStatus!.bridgeToObjectiveC()
        }

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getListMembersShowWithListID(listID: Int, screenName: String, includeEntities: Bool?, skipStatus: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/members/show.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["list_id"] = listID.bridgeToObjectiveC()
        parameters["screen_name"] = screenName.bridgeToObjectiveC()

        if includeEntities {
            parameters["include_entities"] = includeEntities!.bridgeToObjectiveC()
        }
        if skipStatus {
            parameters["skip_status"] = skipStatus!.bridgeToObjectiveC()
        }

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getListMembersShowWithSlug(slug: String, ownerID: Int, userID: Int, includeEntities: Bool?, skipStatus: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/members/show.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["slug"] = slug.bridgeToObjectiveC()
        parameters["owner_id"] = ownerID.bridgeToObjectiveC()
        parameters["user_id"] = userID.bridgeToObjectiveC()

        if includeEntities {
            parameters["include_entities"] = includeEntities!.bridgeToObjectiveC()
        }
        if skipStatus {
            parameters["skip_status"] = skipStatus!.bridgeToObjectiveC()
        }

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getListMembersShowWithSlug(slug: String, ownerID: Int, screenName: Int, includeEntities: Bool?, skipStatus: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/members/show.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["slug"] = slug.bridgeToObjectiveC()
        parameters["owner_id"] = ownerID.bridgeToObjectiveC()
        parameters["screen_name"] = screenName.bridgeToObjectiveC()

        if includeEntities {
            parameters["include_entities"] = includeEntities!.bridgeToObjectiveC()
        }
        if skipStatus {
            parameters["skip_status"] = skipStatus!.bridgeToObjectiveC()
        }

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getListMembersShowWithSlug(slug: String, ownerScreenName: Int, userID: Int, includeEntities: Bool?, skipStatus: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/members/show.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["slug"] = slug.bridgeToObjectiveC()
        parameters["owner_screen_name"] = ownerScreenName.bridgeToObjectiveC()
        parameters["user_id"] = userID.bridgeToObjectiveC()

        if includeEntities {
            parameters["include_entities"] = includeEntities!.bridgeToObjectiveC()
        }
        if skipStatus {
            parameters["skip_status"] = skipStatus!.bridgeToObjectiveC()
        }

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getListMembersShowWithSlug(slug: String, ownerScreenName: Int, screenName: Int, includeEntities: Bool?, skipStatus: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/members/show.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["slug"] = slug.bridgeToObjectiveC()
        parameters["owner_screen_name"] = ownerScreenName.bridgeToObjectiveC()
        parameters["screen_name"] = screenName.bridgeToObjectiveC()

        if includeEntities {
            parameters["include_entities"] = includeEntities!.bridgeToObjectiveC()
        }
        if skipStatus {
            parameters["skip_status"] = skipStatus!.bridgeToObjectiveC()
        }
        
        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getListMembersWithListID(listID: Int, ownerScreenName: String?, cursor: Int?, includeEntities: Bool?, skipStatus: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/members.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["list_id"] = listID.bridgeToObjectiveC()
        if ownerScreenName {
            parameters["owner_screen_name"] = ownerScreenName!.bridgeToObjectiveC()
        }
        if cursor {
            parameters["cursor"] = cursor!.bridgeToObjectiveC()
        }
        if includeEntities {
            parameters["include_entities"] = includeEntities!.bridgeToObjectiveC()
        }
        if skipStatus {
            parameters["skip_status"] = skipStatus!.bridgeToObjectiveC()
        }

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getListMembersWithListID(listID: Int, ownerID: Int?, cursor: Int?, includeEntities: Bool?, skipStatus: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/members.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["list_id"] = listID.bridgeToObjectiveC()
        if ownerID {
            parameters["owner_id"] = ownerID!.bridgeToObjectiveC()
        }
        if cursor {
            parameters["cursor"] = cursor!.bridgeToObjectiveC()
        }
        if includeEntities {
            parameters["include_entities"] = includeEntities!.bridgeToObjectiveC()
        }
        if skipStatus {
            parameters["skip_status"] = skipStatus!.bridgeToObjectiveC()
        }

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getListMembersWithSlug(slug: String, ownerScreenName: String?, cursor: Int?, includeEntities: Bool?, skipStatus: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/members.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["slug"] = slug.bridgeToObjectiveC()
        if ownerScreenName {
            parameters["owner_screen_name"] = ownerScreenName!.bridgeToObjectiveC()
        }
        if cursor {
            parameters["cursor"] = cursor!.bridgeToObjectiveC()
        }
        if includeEntities {
            parameters["include_entities"] = includeEntities!.bridgeToObjectiveC()
        }
        if skipStatus {
            parameters["skip_status"] = skipStatus!.bridgeToObjectiveC()
        }

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getListMembersWithSlug(slug: String, ownerID: Int?, cursor: Int?, includeEntities: Bool?, skipStatus: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/members.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["slug"] = slug.bridgeToObjectiveC()
        if ownerID {
            parameters["owner_id"] = ownerID!.bridgeToObjectiveC()
        }
        if cursor {
            parameters["cursor"] = cursor!.bridgeToObjectiveC()
        }
        if includeEntities {
            parameters["include_entities"] = includeEntities!.bridgeToObjectiveC()
        }
        if skipStatus {
            parameters["skip_status"] = skipStatus!.bridgeToObjectiveC()
        }

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postCreateListsMembersWithListID(listID: Int, ownerScreenName: String, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/subscribers/create.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["owner_screen_name"] = ownerScreenName.bridgeToObjectiveC()
        parameters["list_id"] = listID.bridgeToObjectiveC()

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postCreateListsMembersWithListID(listID: Int, ownerID: Int, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/subscribers/create.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["owner_id"] = ownerID.bridgeToObjectiveC()
        parameters["list_id"] = listID.bridgeToObjectiveC()

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postCreateListsMembersWithSlug(slug: String, ownerScreenName: String, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/subscribers/create.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["owner_screen_name"] = ownerScreenName.bridgeToObjectiveC()
        parameters["slug"] = slug.bridgeToObjectiveC()

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postCreateListsMembersWithSlug(slug: String, ownerID: Int, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/subscribers/create.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["owner_id"] = ownerID.bridgeToObjectiveC()
        parameters["slug"] = slug.bridgeToObjectiveC()

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postDestroyListsWithListID(listID: Int, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/destroy.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["list_id"] = listID.bridgeToObjectiveC()

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postDestroyListsWithSlug(slug: String, ownerID: Int, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/destroy.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["slug"] = slug.bridgeToObjectiveC()
        parameters["owner_id"] = ownerID.bridgeToObjectiveC()

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postDestroyListsWithSlug(slug: String, ownerScreenName: String, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/destroy.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["slug"] = slug.bridgeToObjectiveC()
        parameters["owner_screen_name"] = ownerScreenName.bridgeToObjectiveC()

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postUpdateListsWithListID(listID: Int, name: String?, public: Bool?, description: String?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/update.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["list_id"] = listID.bridgeToObjectiveC()

        if name {
            parameters["name"] = name!.bridgeToObjectiveC()
        }
        if public {
            if public! {
                parameters["mode"] = "public".bridgeToObjectiveC()
            }
            else {
                parameters["mode"] = "private".bridgeToObjectiveC()
            }
        }
        if description {
            parameters["description"] = description!.bridgeToObjectiveC()
        }

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postUpdateListsWithSlug(slug: String, ownerID: Int, name: String?, public: Bool?, description: String?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/update.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["slug"] = slug.bridgeToObjectiveC()
        parameters["owner_id"] = ownerID.bridgeToObjectiveC()

        if name {
            parameters["name"] = name!.bridgeToObjectiveC()
        }
        if public {
            if public! {
                parameters["mode"] = "public".bridgeToObjectiveC()
            }
            else {
                parameters["mode"] = "private".bridgeToObjectiveC()
            }
        }
        if description {
            parameters["description"] = description!.bridgeToObjectiveC()
        }

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postUpdateListsWithSlug(slug: String, ownerScreenName: String, name: String?, public: Bool?, description: String?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/update.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["slug"] = slug.bridgeToObjectiveC()
        parameters["owner_screen_name"] = ownerScreenName.bridgeToObjectiveC()

        if name {
            parameters["name"] = name!.bridgeToObjectiveC()
        }
        if public {
            if public! {
                parameters["mode"] = "public".bridgeToObjectiveC()
            }
            else {
                parameters["mode"] = "private".bridgeToObjectiveC()
            }
        }
        if description {
            parameters["description"] = description!.bridgeToObjectiveC()
        }

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postCreateListsWithName(name: String, public: Bool?, description: String?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/create.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["name"] = name.bridgeToObjectiveC()

        if public {
            if public! {
                parameters["mode"] = "public".bridgeToObjectiveC()
            }
            else {
                parameters["mode"] = "private".bridgeToObjectiveC()
            }
        }
        if description {
            parameters["description"] = description!.bridgeToObjectiveC()
        }

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getListsShowWithID(listID: Int, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/show.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["list_id"] = listID.bridgeToObjectiveC()

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getListsShowWithSlug(slug: String, ownerID: Int, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/show.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["slug"] = slug.bridgeToObjectiveC()
        parameters["owner_id"] = ownerID.bridgeToObjectiveC()

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getListsShowWithSlug(slug: String, ownerScreenName: String, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/show.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["slug"] = slug.bridgeToObjectiveC()
        parameters["owner_screen_name"] = ownerScreenName.bridgeToObjectiveC()

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getListsSubscribersWithUserID(userID: Int, count: Int?, cursor: Int?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/subscriptions.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["user_id"] = userID.bridgeToObjectiveC()

        if count {
            parameters["count"] = count!.bridgeToObjectiveC()
        }
        if cursor {
            parameters["cursor"] = cursor!.bridgeToObjectiveC()
        }

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getListsSubscribersWithScreenName(screenName: String, count: Int?, cursor: Int?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/subscriptions.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["screen_name"] = screenName.bridgeToObjectiveC()

        if count {
            parameters["count"] = count!.bridgeToObjectiveC()
        }
        if cursor {
            parameters["cursor"] = cursor!.bridgeToObjectiveC()
        }

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postDestroyAllListMembersWithListID(listID: Int, userID: Int, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/members/destroy_all.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["list_id"] = listID.bridgeToObjectiveC()
        parameters["user_id"] = userID.bridgeToObjectiveC()

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postDestroyAllListMembersWithListID(listID: Int, screenName: String, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/members/destroy_all.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["list_id"] = listID.bridgeToObjectiveC()
        parameters["screen_name"] = screenName.bridgeToObjectiveC()

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postDestroyAllListMembersWithSlug(slug: String, userID: Int, ownerScreenName: String, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/members/destroy_all.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["slug"] = slug.bridgeToObjectiveC()
        parameters["userID"] = userID.bridgeToObjectiveC()
        parameters["owner_screen_name"] = ownerScreenName.bridgeToObjectiveC()

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postDestroyAllListMemberWithSlug(slug: String, screenName: String, ownerScreenName: String, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/members/destroy_all.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["slug"] = slug.bridgeToObjectiveC()
        parameters["screen_name"] = screenName.bridgeToObjectiveC()
        parameters["owner_screen_name"] = ownerScreenName.bridgeToObjectiveC()

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postDestroyAllListMembersWithSlug(slug: String, userID: Int, ownerID: Int, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/members/destroy_all.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["slug"] = slug.bridgeToObjectiveC()
        parameters["userID"] = userID.bridgeToObjectiveC()
        parameters["owner_id"] = ownerID.bridgeToObjectiveC()

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postDestroyAllListMembersWithSlug(slug: String, screenName: String, ownerID: Int, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/members/destroy_all.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["slug"] = slug.bridgeToObjectiveC()
        parameters["screen_name"] = screenName.bridgeToObjectiveC()
        parameters["owner_id"] = ownerID.bridgeToObjectiveC()

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getListsOwnershipsWithUserID(userID: Int, count: Int?, cursor: Int?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/ownerships.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["user_id"] = userID.bridgeToObjectiveC()

        if count {
            parameters["count"] = count!.bridgeToObjectiveC()
        }
        if cursor {
            parameters["cursor"] = cursor!.bridgeToObjectiveC()
        }

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

}
