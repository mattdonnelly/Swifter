//
//  SwifterLists.swift
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

    func getListsSubscribedByUserWithID(userID: Int, reverse: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/list.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["userID"] = userID

        if reverse {
            parameters["reverse"] = reverse!
        }

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getListsSubscribedByUserWithScreenName(screenName: String, reverse: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/list.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["screen_name"] = screenName

        if reverse {
            parameters["reverse"] = reverse!
        }

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getListStatuesWithListID(listID: Int, ownerScreenName: String, sinceID: Int?, maxID: Int?, count: Int?, includeEntities: Bool?, includeRTs: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/statuses.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["list_id"] = listID
        parameters["owner_screen_name"] = ownerScreenName

        if sinceID {
            parameters["since_id"] = sinceID!
        }
        if maxID {
            parameters["max_id"] = maxID!
        }
        if count {
            parameters["count"] = count!
        }
        if includeEntities {
            parameters["include_entities"] = includeEntities!
        }
        if includeRTs {
            parameters["include_rts"] = includeRTs!
        }

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getListStatuesWithListID(listID: Int, ownerID: Int, sinceID: Int?, maxID: Int?, count: Int?, includeEntities: Bool?, includeRTs: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/statuses.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["list_id"] = listID
        parameters["owner_id"] = ownerID

        if sinceID {
            parameters["since_id"] = sinceID!
        }
        if maxID {
            parameters["max_id"] = maxID!
        }
        if count {
            parameters["count"] = count!
        }
        if includeEntities {
            parameters["include_entities"] = includeEntities!
        }
        if includeRTs {
            parameters["include_rts"] = includeRTs!
        }

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getListStatuesWithSlug(slug: String, ownerScreenName: String, sinceID: Int?, maxID: Int?, count: Int?, includeEntities: Bool?, includeRTs: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/statuses.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["slug"] = slug
        parameters["owner_screen_name"] = ownerScreenName

        if sinceID {
            parameters["since_id"] = sinceID!
        }
        if maxID {
            parameters["max_id"] = maxID!
        }
        if count {
            parameters["count"] = count!
        }
        if includeEntities {
            parameters["include_entities"] = includeEntities!
        }
        if includeRTs {
            parameters["include_rts"] = includeRTs!
        }

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getListStatuesWithSlug(slug: String, ownerID: Int, sinceID: Int?, maxID: Int?, count: Int?, includeEntities: Bool?, includeRTs: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/statuses.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["slug"] = slug
        parameters["owner_id"] = ownerID

        if sinceID {
            parameters["since_id"] = sinceID!
        }
        if maxID {
            parameters["max_id"] = maxID!
        }
        if count {
            parameters["count"] = count!
        }
        if includeEntities {
            parameters["include_entities"] = includeEntities!
        }
        if includeRTs {
            parameters["include_rts"] = includeRTs!
        }

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postDestroyListMembersWithListID(listID: Int, userID: Int, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/members/destroy.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["list_id"] = listID
        parameters["user_id"] = userID

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postDestroyListMembersWithListID(listID: Int, screenName: String, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/members/destroy.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["list_id"] = listID
        parameters["screen_name"] = screenName

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postDestroyListMembersWithSlug(slug: String, userID: Int, ownerScreenName: String, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/members/destroy.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["slug"] = slug
        parameters["userID"] = userID
        parameters["owner_screen_name"] = ownerScreenName

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postDestroyListMemberWithSlug(slug: String, screenName: String, ownerScreenName: String, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/members/destroy.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["slug"] = slug
        parameters["screen_name"] = screenName
        parameters["owner_screen_name"] = ownerScreenName

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postDestroyListMembersWithSlug(slug: String, userID: Int, ownerID: Int, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/members/destroy.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["slug"] = slug
        parameters["userID"] = userID
        parameters["owner_id"] = ownerID

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postDestroyListMembersWithSlug(slug: String, screenName: String, ownerID: Int, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/members/destroy.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["slug"] = slug
        parameters["screen_name"] = screenName
        parameters["owner_id"] = ownerID

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getListMembershipsWithUserID(userID: Int, cursor: Int?, filterToOwnedLists: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/memberships.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["user_id"] = userID

        if cursor {
            parameters["cursor"] = cursor!
        }
        if filterToOwnedLists {
            parameters["filter_to_owned_lists"] = filterToOwnedLists!
        }

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getListMembershipsWithScreenName(screenName: String, cursor: Int?, filterToOwnedLists: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/memberships.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["screen_name"] = screenName

        if cursor {
            parameters["cursor"] = cursor!
        }
        if filterToOwnedLists {
            parameters["filter_to_owned_lists"] = filterToOwnedLists!
        }

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getListSubscribersWithListID(listID: Int, ownerScreenName: String?, cursor: Int?, includeEntities: Bool?, skipStatus: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/subscribers.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["list_id"] = listID
        if ownerScreenName {
            parameters["owner_screen_name"] = ownerScreenName!
        }
        if cursor {
            parameters["cursor"] = cursor!
        }
        if includeEntities {
            parameters["include_entities"] = includeEntities!
        }
        if skipStatus {
            parameters["skip_status"] = skipStatus!
        }

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getListSubscribersWithListID(listID: Int, ownerID: Int?, cursor: Int?, includeEntities: Bool?, skipStatus: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/subscribers.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["list_id"] = listID
        if ownerID {
            parameters["owner_id"] = ownerID!
        }
        if cursor {
            parameters["cursor"] = cursor!
        }
        if includeEntities {
            parameters["include_entities"] = includeEntities!
        }
        if skipStatus {
            parameters["skip_status"] = skipStatus!
        }

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getListSubscribersWithSlug(slug: String, ownerScreenName: String?, cursor: Int?, includeEntities: Bool?, skipStatus: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/subscribers.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["slug"] = slug
        if ownerScreenName {
            parameters["owner_screen_name"] = ownerScreenName!
        }
        if cursor {
            parameters["cursor"] = cursor!
        }
        if includeEntities {
            parameters["include_entities"] = includeEntities!
        }
        if skipStatus {
            parameters["skip_status"] = skipStatus!
        }

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getListSubscribersWithSlug(slug: String, ownerID: Int?, cursor: Int?, includeEntities: Bool?, skipStatus: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/subscribers.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["slug"] = slug
        if ownerID {
            parameters["owner_id"] = ownerID!
        }
        if cursor {
            parameters["cursor"] = cursor!
        }
        if includeEntities {
            parameters["include_entities"] = includeEntities!
        }
        if skipStatus {
            parameters["skip_status"] = skipStatus!
        }

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postCreateListsSubscribersWithListID(listID: Int, ownerScreenName: String, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/subscribers/create.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["owner_screen_name"] = ownerScreenName
        parameters["list_id"] = listID

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postCreateListsSubscribersWithListID(listID: Int, ownerID: Int, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/subscribers/create.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["owner_id"] = ownerID
        parameters["list_id"] = listID

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postCreateListsSubscribersWithSlug(slug: String, ownerScreenName: String, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/subscribers/create.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["owner_screen_name"] = ownerScreenName
        parameters["slug"] = slug

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postCreateListsSubscribersWithSlug(slug: String, ownerID: Int, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/subscribers/create.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["owner_id"] = ownerID
        parameters["slug"] = slug

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getListSubscribersShowWithListID(listID: Int, userID: Int, includeEntities: Bool?, skipStatus: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/subscribers/show.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["list_id"] = listID
        parameters["user_id"] = userID

        if includeEntities {
            parameters["include_entities"] = includeEntities!
        }
        if skipStatus {
            parameters["skip_status"] = skipStatus!
        }

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getListSubscribersShowWithListID(listID: Int, screenName: String, includeEntities: Bool?, skipStatus: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/subscribers/show.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["list_id"] = listID
        parameters["screen_name"] = screenName

        if includeEntities {
            parameters["include_entities"] = includeEntities!
        }
        if skipStatus {
            parameters["skip_status"] = skipStatus!
        }

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getListSubscribersShowWithSlug(slug: String, ownerID: Int, userID: Int, includeEntities: Bool?, skipStatus: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/subscribers/show.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["slug"] = slug
        parameters["owner_id"] = ownerID
        parameters["user_id"] = userID

        if includeEntities {
            parameters["include_entities"] = includeEntities!
        }
        if skipStatus {
            parameters["skip_status"] = skipStatus!
        }

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getListSubscribersShowWithSlug(slug: String, ownerID: Int, screenName: Int, includeEntities: Bool?, skipStatus: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/subscribers/show.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["slug"] = slug
        parameters["owner_id"] = ownerID
        parameters["screen_name"] = screenName

        if includeEntities {
            parameters["include_entities"] = includeEntities!
        }
        if skipStatus {
            parameters["skip_status"] = skipStatus!
        }

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getListSubscribersShowWithSlug(slug: String, ownerScreenName: Int, userID: Int, includeEntities: Bool?, skipStatus: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/subscribers/show.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["slug"] = slug
        parameters["owner_screen_name"] = ownerScreenName
        parameters["user_id"] = userID

        if includeEntities {
            parameters["include_entities"] = includeEntities!
        }
        if skipStatus {
            parameters["skip_status"] = skipStatus!
        }

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getListSubscribersShowWithSlug(slug: String, ownerScreenName: Int, screenName: Int, includeEntities: Bool?, skipStatus: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/subscribers/show.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["slug"] = slug
        parameters["owner_screen_name"] = ownerScreenName
        parameters["screen_name"] = screenName

        if includeEntities {
            parameters["include_entities"] = includeEntities!
        }
        if skipStatus {
            parameters["skip_status"] = skipStatus!
        }

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postDestroyListsSubscribersWithListID(listID: Int, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/subscribers/destroy.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["listID"] = listID

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postDestroyListsSubscribersWithSlug(slug: String, ownerScreenName: String, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/subscribers/destroy.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["slug"] = slug
        parameters["owner_screen_name"] = ownerScreenName

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postDestroyListsSubscribersWithSlug(slug: String, ownerID: Int, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/subscribers/destroy.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["slug"] = slug
        parameters["owner_id"] = ownerID

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postCreateListsMembersWithListID(listID: Int, userID: Int, includeEntities: Bool?, skipStatus: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/members/create_all.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["list_id"] = listID
        parameters["user_id"] = userID

        if includeEntities {
            parameters["include_entities"] = includeEntities!
        }
        if skipStatus {
            parameters["skip_status"] = skipStatus!
        }

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postCreateListsMembersWithListID(listID: Int, screenName: String, includeEntities: Bool?, skipStatus: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/members/create_all.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["list_id"] = listID
        parameters["screen_name"] = screenName

        if includeEntities {
            parameters["include_entities"] = includeEntities!
        }
        if skipStatus {
            parameters["skip_status"] = skipStatus!
        }

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postCreateListsMembersWithSlug(slug: String, ownerID: Int, userID: Int, includeEntities: Bool?, skipStatus: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/members/create_all.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["slug"] = slug
        parameters["owner_id"] = ownerID
        parameters["user_id"] = userID

        if includeEntities {
            parameters["include_entities"] = includeEntities!
        }
        if skipStatus {
            parameters["skip_status"] = skipStatus!
        }

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postCreateListsMembersWithSlug(slug: String, ownerID: Int, screenName: Int, includeEntities: Bool?, skipStatus: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/members/create_all.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["slug"] = slug
        parameters["owner_id"] = ownerID
        parameters["screen_name"] = screenName

        if includeEntities {
            parameters["include_entities"] = includeEntities!
        }
        if skipStatus {
            parameters["skip_status"] = skipStatus!
        }

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postCreateListsMembersWithSlug(slug: String, ownerScreenName: Int, userID: Int, includeEntities: Bool?, skipStatus: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/members/create_all.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["slug"] = slug
        parameters["owner_screen_name"] = ownerScreenName
        parameters["user_id"] = userID

        if includeEntities {
            parameters["include_entities"] = includeEntities!
        }
        if skipStatus {
            parameters["skip_status"] = skipStatus!
        }

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postCreateListsMembersWithSlug(slug: String, ownerScreenName: Int, screenName: Int, includeEntities: Bool?, skipStatus: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/members/create_all.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["slug"] = slug
        parameters["owner_screen_name"] = ownerScreenName
        parameters["screen_name"] = screenName

        if includeEntities {
            parameters["include_entities"] = includeEntities!
        }
        if skipStatus {
            parameters["skip_status"] = skipStatus!
        }
        
        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getListMembersShowWithListID(listID: Int, userID: Int, includeEntities: Bool?, skipStatus: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/members/show.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["list_id"] = listID
        parameters["user_id"] = userID

        if includeEntities {
            parameters["include_entities"] = includeEntities!
        }
        if skipStatus {
            parameters["skip_status"] = skipStatus!
        }

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getListMembersShowWithListID(listID: Int, screenName: String, includeEntities: Bool?, skipStatus: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/members/show.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["list_id"] = listID
        parameters["screen_name"] = screenName

        if includeEntities {
            parameters["include_entities"] = includeEntities!
        }
        if skipStatus {
            parameters["skip_status"] = skipStatus!
        }

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getListMembersShowWithSlug(slug: String, ownerID: Int, userID: Int, includeEntities: Bool?, skipStatus: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/members/show.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["slug"] = slug
        parameters["owner_id"] = ownerID
        parameters["user_id"] = userID

        if includeEntities {
            parameters["include_entities"] = includeEntities!
        }
        if skipStatus {
            parameters["skip_status"] = skipStatus!
        }

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getListMembersShowWithSlug(slug: String, ownerID: Int, screenName: Int, includeEntities: Bool?, skipStatus: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/members/show.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["slug"] = slug
        parameters["owner_id"] = ownerID
        parameters["screen_name"] = screenName

        if includeEntities {
            parameters["include_entities"] = includeEntities!
        }
        if skipStatus {
            parameters["skip_status"] = skipStatus!
        }

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getListMembersShowWithSlug(slug: String, ownerScreenName: Int, userID: Int, includeEntities: Bool?, skipStatus: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/members/show.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["slug"] = slug
        parameters["owner_screen_name"] = ownerScreenName
        parameters["user_id"] = userID

        if includeEntities {
            parameters["include_entities"] = includeEntities!
        }
        if skipStatus {
            parameters["skip_status"] = skipStatus!
        }

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getListMembersShowWithSlug(slug: String, ownerScreenName: Int, screenName: Int, includeEntities: Bool?, skipStatus: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/members/show.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["slug"] = slug
        parameters["owner_screen_name"] = ownerScreenName
        parameters["screen_name"] = screenName

        if includeEntities {
            parameters["include_entities"] = includeEntities!
        }
        if skipStatus {
            parameters["skip_status"] = skipStatus!
        }
        
        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getListMembersWithListID(listID: Int, ownerScreenName: String?, cursor: Int?, includeEntities: Bool?, skipStatus: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/members.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["list_id"] = listID
        if ownerScreenName {
            parameters["owner_screen_name"] = ownerScreenName!
        }
        if cursor {
            parameters["cursor"] = cursor!
        }
        if includeEntities {
            parameters["include_entities"] = includeEntities!
        }
        if skipStatus {
            parameters["skip_status"] = skipStatus!
        }

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getListMembersWithListID(listID: Int, ownerID: Int?, cursor: Int?, includeEntities: Bool?, skipStatus: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/members.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["list_id"] = listID
        if ownerID {
            parameters["owner_id"] = ownerID!
        }
        if cursor {
            parameters["cursor"] = cursor!
        }
        if includeEntities {
            parameters["include_entities"] = includeEntities!
        }
        if skipStatus {
            parameters["skip_status"] = skipStatus!
        }

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getListMembersWithSlug(slug: String, ownerScreenName: String?, cursor: Int?, includeEntities: Bool?, skipStatus: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/members.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["slug"] = slug
        if ownerScreenName {
            parameters["owner_screen_name"] = ownerScreenName!
        }
        if cursor {
            parameters["cursor"] = cursor!
        }
        if includeEntities {
            parameters["include_entities"] = includeEntities!
        }
        if skipStatus {
            parameters["skip_status"] = skipStatus!
        }

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getListMembersWithSlug(slug: String, ownerID: Int?, cursor: Int?, includeEntities: Bool?, skipStatus: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/members.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["slug"] = slug
        if ownerID {
            parameters["owner_id"] = ownerID!
        }
        if cursor {
            parameters["cursor"] = cursor!
        }
        if includeEntities {
            parameters["include_entities"] = includeEntities!
        }
        if skipStatus {
            parameters["skip_status"] = skipStatus!
        }

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postCreateListsMembersWithListID(listID: Int, ownerScreenName: String, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/subscribers/create.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["owner_screen_name"] = ownerScreenName
        parameters["list_id"] = listID

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postCreateListsMembersWithListID(listID: Int, ownerID: Int, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/subscribers/create.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["owner_id"] = ownerID
        parameters["list_id"] = listID

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postCreateListsMembersWithSlug(slug: String, ownerScreenName: String, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/subscribers/create.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["owner_screen_name"] = ownerScreenName
        parameters["slug"] = slug

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postCreateListsMembersWithSlug(slug: String, ownerID: Int, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/subscribers/create.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["owner_id"] = ownerID
        parameters["slug"] = slug

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postDestroyListsWithListID(listID: Int, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/destroy.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["list_id"] = listID

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postDestroyListsWithSlug(slug: String, ownerID: Int, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/destroy.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["slug"] = slug
        parameters["owner_id"] = ownerID

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postDestroyListsWithSlug(slug: String, ownerScreenName: String, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/destroy.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["slug"] = slug
        parameters["owner_screen_name"] = ownerScreenName

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postUpdateListsWithListID(listID: Int, name: String?, public: Bool?, description: String?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/update.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["list_id"] = listID

        if name {
            parameters["name"] = name!
        }
        if public {
            if public! {
                parameters["mode"] = "public"
            }
            else {
                parameters["mode"] = "private"
            }
        }
        if description {
            parameters["description"] = description!
        }

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postUpdateListsWithSlug(slug: String, ownerID: Int, name: String?, public: Bool?, description: String?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/update.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["slug"] = slug
        parameters["owner_id"] = ownerID

        if name {
            parameters["name"] = name!
        }
        if public {
            if public! {
                parameters["mode"] = "public"
            }
            else {
                parameters["mode"] = "private"
            }
        }
        if description {
            parameters["description"] = description!
        }

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postUpdateListsWithSlug(slug: String, ownerScreenName: String, name: String?, public: Bool?, description: String?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/update.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["slug"] = slug
        parameters["owner_screen_name"] = ownerScreenName

        if name {
            parameters["name"] = name!
        }
        if public {
            if public! {
                parameters["mode"] = "public"
            }
            else {
                parameters["mode"] = "private"
            }
        }
        if description {
            parameters["description"] = description!
        }

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postCreateListsWithName(name: String, public: Bool?, description: String?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/create.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["name"] = name

        if public {
            if public! {
                parameters["mode"] = "public"
            }
            else {
                parameters["mode"] = "private"
            }
        }
        if description {
            parameters["description"] = description!
        }

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getListsShowWithID(listID: Int, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/show.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["list_id"] = listID

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getListsShowWithSlug(slug: String, ownerID: Int, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/show.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["slug"] = slug
        parameters["owner_id"] = ownerID

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getListsShowWithSlug(slug: String, ownerScreenName: String, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/show.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["slug"] = slug
        parameters["owner_screen_name"] = ownerScreenName

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getListsSubscribersWithUserID(userID: Int, count: Int?, cursor: Int?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/subscriptions.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["user_id"] = userID

        if count {
            parameters["count"] = count!
        }
        if cursor {
            parameters["cursor"] = cursor!
        }

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getListsSubscribersWithScreenName(screenName: String, count: Int?, cursor: Int?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/subscriptions.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["screen_name"] = screenName

        if count {
            parameters["count"] = count!
        }
        if cursor {
            parameters["cursor"] = cursor!
        }

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postDestroyAllListMembersWithListID(listID: Int, userID: Int, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/members/destroy_all.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["list_id"] = listID
        parameters["user_id"] = userID

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postDestroyAllListMembersWithListID(listID: Int, screenName: String, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/members/destroy_all.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["list_id"] = listID
        parameters["screen_name"] = screenName

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postDestroyAllListMembersWithSlug(slug: String, userID: Int, ownerScreenName: String, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/members/destroy_all.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["slug"] = slug
        parameters["userID"] = userID
        parameters["owner_screen_name"] = ownerScreenName

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postDestroyAllListMemberWithSlug(slug: String, screenName: String, ownerScreenName: String, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/members/destroy_all.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["slug"] = slug
        parameters["screen_name"] = screenName
        parameters["owner_screen_name"] = ownerScreenName

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postDestroyAllListMembersWithSlug(slug: String, userID: Int, ownerID: Int, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/members/destroy_all.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["slug"] = slug
        parameters["userID"] = userID
        parameters["owner_id"] = ownerID

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postDestroyAllListMembersWithSlug(slug: String, screenName: String, ownerID: Int, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/members/destroy_all.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["slug"] = slug
        parameters["screen_name"] = screenName
        parameters["owner_id"] = ownerID

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getListsOwnershipsWithUserID(userID: Int, count: Int?, cursor: Int?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "lists/ownerships.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["user_id"] = userID

        if count {
            parameters["count"] = count!
        }
        if cursor {
            parameters["cursor"] = cursor!
        }

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

}
