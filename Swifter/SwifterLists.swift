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

public extension Swifter {

    /*
    GET    lists/list

    Returns all lists the authenticating or specified user subscribes to, including their own. The user is specified using the user_id or screen_name parameters. If no user is given, the authenticating user is used.

    This method used to be GET lists in version 1.0 of the API and has been renamed for consistency with other call.

    A maximum of 100 results will be returned by this call. Subscribed lists are returned first, followed by owned lists. This means that if a user subscribes to 90 lists and owns 20 lists, this method returns 90 subscriptions and 10 owned lists. The reverse method returns owned lists first, so with reverse=true, 20 owned lists and 80 subscriptions would be returned. If your goal is to obtain every list a user owns or subscribes to, use GET lists/ownerships and/or GET lists/subscriptions instead.
    */
    public func getListsSubscribedByUserWithReverse(reverse: Bool?, success: ((lists: [JSONValue]?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/list.json"

        var parameters = Dictionary<String, Any>()
        parameters["reverse"] ??= reverse

        self.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(lists: json.array)
            }, failure: failure)
    }

    public func getListsSubscribedByUserWithID(userID: String, reverse: Bool?, success: ((lists: [JSONValue]?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/list.json"

        var parameters = Dictionary<String, Any>()
        parameters["userID"] = userID
        parameters["reverse"] ??= reverse

        self.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(lists: json.array)
            }, failure: failure)
    }

    public func getListsSubscribedByUserWithScreenName(screenName: String, reverse: Bool?, success: ((lists: [JSONValue]?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/list.json"

        var parameters = Dictionary<String, Any>()
        parameters["screen_name"] = screenName
        parameters["reverse"] ??= reverse

        self.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(lists: json.array)
            }, failure: failure)
    }

    /*
    GET	lists/statuses

    Returns a timeline of tweets authored by members of the specified list. Retweets are included by default. Use the include_rts=false parameter to omit retweets. Embedded Timelines is a great way to embed list timelines on your website.
    */
    public func getListsStatusesWithListID(listID: String, ownerScreenName: String, sinceID: String?, maxID: String?, count: Int?, includeEntities: Bool?, includeRTs: Bool?, success: ((statuses: [JSONValue]?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/statuses.json"

        var parameters = Dictionary<String, Any>()
        parameters["list_id"] = listID
        parameters["owner_screen_name"] = ownerScreenName
        parameters["since_id"] ??= sinceID
        parameters["max_id"] ??= maxID
        parameters["count"] ??= count
        parameters["include_entities"] ??= includeEntities
        parameters["include_rts"] ??= includeRTs

        self.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(statuses: json.array)
            }, failure: failure)
    }

    public func getListsStatusesWithListID(listID: String, ownerID: String, sinceID: String?, maxID: String?, count: Int?, includeEntities: Bool?, includeRTs: Bool?, success: ((statuses: [JSONValue]?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/statuses.json"

        var parameters = Dictionary<String, Any>()
        parameters["list_id"] = listID
        parameters["owner_id"] = ownerID
        parameters["since_id"] ??= sinceID
        parameters["max_id"] ??= maxID
        parameters["count"] ??= count
        parameters["include_entities"] ??= includeEntities
        parameters["include_rts"] ??= includeRTs

        self.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(statuses: json.array)
            }, failure: failure)
    }

    public func getListsStatusesWithSlug(slug: String, ownerScreenName: String, sinceID: String?, maxID: String?, count: Int?, includeEntities: Bool?, includeRTs: Bool?, success: ((statuses: [JSONValue]?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/statuses.json"

        var parameters = Dictionary<String, Any>()
        parameters["slug"] = slug
        parameters["owner_screen_name"] = ownerScreenName
        parameters["since_id"] ??= sinceID
        parameters["max_id"] ??= maxID
        parameters["count"] ??= count
        parameters["include_entities"] ??= includeEntities
        parameters["include_rts"] ??= includeRTs

        self.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(statuses: json.array)
            }, failure: failure)
    }

    public func getListsStatusesWithSlug(slug: String, ownerID: String, sinceID: String?, maxID: String?, count: Int?, includeEntities: Bool?, includeRTs: Bool?, success: ((statuses: [JSONValue]?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/statuses.json"

        var parameters = Dictionary<String, Any>()
        parameters["slug"] = slug
        parameters["owner_id"] = ownerID
        parameters["since_id"] ??= sinceID
        parameters["max_id"] ??= maxID
        parameters["count"] ??= count
        parameters["include_entities"] ??= includeEntities
        parameters["include_rts"] ??= includeRTs

        self.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(statuses: json.array)
            }, failure: failure)
    }

    /*
    POST	lists/members/destroy

    Removes the specified member from the list. The authenticated user must be the list's owner to remove members from the list.
    */
    public func postListsMembersDestroyWithListID(listID: String, userID: String, success: ((response: JSON?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/members/destroy.json"

        var parameters = Dictionary<String, Any>()
        parameters["list_id"] = listID
        parameters["user_id"] = userID

        self.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(response: json)
            }, failure: failure)
    }

    public func postListsMembersDestroyWithListID(listID: String, screenName: String, success: ((response: JSON?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/members/destroy.json"

        var parameters = Dictionary<String, Any>()
        parameters["list_id"] = listID
        parameters["screen_name"] = screenName

        self.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(response: json)
            }, failure: failure)
    }

    public func postListsMembersDestroyWithSlug(slug: String, userID: String, ownerScreenName: String, success: ((response: JSON?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/members/destroy.json"

        var parameters = Dictionary<String, Any>()
        parameters["slug"] = slug
        parameters["userID"] = userID
        parameters["owner_screen_name"] = ownerScreenName

        self.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(response: json)
            }, failure: failure)
    }

    public func postListsMembersDestroyWithSlug(slug: String, screenName: String, ownerScreenName: String, success: ((response: JSON?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/members/destroy.json"

        var parameters = Dictionary<String, Any>()
        parameters["slug"] = slug
        parameters["screen_name"] = screenName
        parameters["owner_screen_name"] = ownerScreenName

        self.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(response: json)
            }, failure: failure)
    }

    public func postListsMembersDestroyWithSlug(slug: String, userID: String, ownerID: String, success: ((response: JSON?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/members/destroy.json"

        var parameters = Dictionary<String, Any>()
        parameters["slug"] = slug
        parameters["userID"] = userID
        parameters["owner_id"] = ownerID

        self.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(response: json)
            }, failure: failure)
    }

    public func postListsMembersDestroyWithSlug(slug: String, screenName: String, ownerID: String, success: ((response: JSON?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/members/destroy.json"

        var parameters = Dictionary<String, Any>()
        parameters["slug"] = slug
        parameters["screen_name"] = screenName
        parameters["owner_id"] = ownerID

        self.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(response: json)
            }, failure: failure)
    }

    /*
    GET    lists/memberships

    Returns the lists the specified user has been added to. If user_id or screen_name are not provided the memberships for the authenticating user are returned.
    */
    public func getListsMembershipsWithUserID(userID: String, cursor: String?, filterToOwnedLists: Bool?, success: ((lists: [JSONValue]?, previousCursor: String?, nextCursor: String?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/memberships.json"

        var parameters = Dictionary<String, Any>()
        parameters["user_id"] = userID
        parameters["cursor"] ??= cursor
        parameters["filter_to_owned_lists"] ??= filterToOwnedLists

        self.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(lists: json["lists"].array, previousCursor: json["previous_cursor_str"].string, nextCursor: json["next_cursor_str"].string)

            }, failure: failure)
    }

    public func getListsMembershipsWithScreenName(screenName: String, cursor: String?, filterToOwnedLists: Bool?, success: ((lists: [JSONValue]?, previousCursor: String?, nextCursor: String?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/memberships.json"

        var parameters = Dictionary<String, Any>()
        parameters["screen_name"] = screenName

        parameters["cursor"] ??= cursor
        parameters["filter_to_owned_lists"] ??= filterToOwnedLists

        self.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(lists: json["lists"].array, previousCursor: json["previous_cursor_str"].string, nextCursor: json["next_cursor_str"].string)

            }, failure: failure)
    }

    /*
    GET	lists/subscribers

    Returns the subscribers of the specified list. Private list subscribers will only be shown if the authenticated user owns the specified list.
    */
    public func getListsSubscribersWithListID(listID: String, ownerScreenName: String?, cursor: String?, includeEntities: Bool?, skipStatus: Bool?, success: ((users: [JSONValue]?, previousCursor: String?, nextCursor: String?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/subscribers.json"

        var parameters = Dictionary<String, Any>()
        parameters["list_id"] = listID
        parameters["owner_screen_name"] ??= ownerScreenName
        parameters["cursor"] ??= cursor
        parameters["include_entities"] ??= includeEntities
        parameters["skip_status"] ??= skipStatus

        self.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in            
            success?(users: json["users"].array, previousCursor: json["previous_cursor_str"].string, nextCursor: json["next_cursor_str"].string)

            }, failure: failure)
    }

    public func getListsSubscribersWithListID(listID: String, ownerID: String?, cursor: String?, includeEntities: Bool?, skipStatus: Bool?, success: ((users: [JSONValue]?, previousCursor: String?, nextCursor: String?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/subscribers.json"

        var parameters = Dictionary<String, Any>()
        parameters["list_id"] = listID
        parameters["owner_id"] ??= ownerID
        parameters["cursor"] ??= cursor
        parameters["include_entities"] ??= includeEntities
        parameters["skip_status"] ??= skipStatus

        self.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(users: json["users"].array, previousCursor: json["previous_cursor_str"].string, nextCursor: json["next_cursor_str"].string)

            }, failure: failure)
    }

    public func getListsSubscribersWithSlug(slug: String, ownerScreenName: String?, cursor: String?, includeEntities: Bool?, skipStatus: Bool?, success: ((users: [JSONValue]?, previousCursor: String?, nextCursor: String?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/subscribers.json"

        var parameters = Dictionary<String, Any>()
        parameters["slug"] = slug
        parameters["owner_screen_name"] ??= ownerScreenName
        parameters["cursor"] ??= cursor
        parameters["include_entities"] ??= includeEntities
        parameters["skip_status"] ??= skipStatus

        self.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(users: json["users"].array, previousCursor: json["previous_cursor_str"].string, nextCursor: json["next_cursor_str"].string)

            }, failure: failure)
    }

    public func getListsSubscribersWithSlug(slug: String, ownerID: String?, cursor: String?, includeEntities: Bool?, skipStatus: Bool?, success: ((users: [JSONValue]?, previousCursor: String?, nextCursor: String?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/subscribers.json"

        var parameters = Dictionary<String, Any>()
        parameters["slug"] = slug
        parameters["owner_id"] ??= ownerID
        parameters["cursor"] ??= cursor
        parameters["include_entities"] ??= includeEntities
        parameters["skip_status"] ??= skipStatus

        self.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(users: json["users"].array, previousCursor: json["previous_cursor_str"].string, nextCursor: json["next_cursor_str"].string)

            }, failure: failure)
    }

    /*
    POST	lists/subscribers/create

    Subscribes the authenticated user to the specified list.
    */
    public func postListsSubscribersCreateWithListID(listID: String, ownerScreenName: String, success: ((user: Dictionary<String, JSONValue>?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/subscribers/create.json"

        var parameters = Dictionary<String, Any>()
        parameters["owner_screen_name"] = ownerScreenName
        parameters["list_id"] = listID

        self.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(user: json.object)
            }, failure: failure)
    }

    public func postListsSubscribersCreateWithListID(listID: String, ownerID: String, success: ((user: Dictionary<String, JSONValue>?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/subscribers/create.json"

        var parameters = Dictionary<String, Any>()
        parameters["owner_id"] = ownerID
        parameters["list_id"] = listID

        self.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(user: json.object)
            }, failure: failure)
    }

    public func postListsSubscribersCreateWithSlug(slug: String, ownerScreenName: String, success: ((user: Dictionary<String, JSONValue>?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/subscribers/create.json"

        var parameters = Dictionary<String, Any>()
        parameters["owner_screen_name"] = ownerScreenName
        parameters["slug"] = slug

        self.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(user: json.object)
            }, failure: failure)
    }

    public func postListsSubscribersCreateWithSlug(slug: String, ownerID: String, success: ((user: Dictionary<String, JSONValue>?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/subscribers/create.json"

        var parameters = Dictionary<String, Any>()
        parameters["owner_id"] = ownerID
        parameters["slug"] = slug

        self.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(user: json.object)
            }, failure: failure)
    }

    /*
    GET	lists/subscribers/show

    Check if the specified user is a subscriber of the specified list. Returns the user if they are subscriber.
    */
    public func getListsSubscribersShowWithListID(listID: String, userID: String, includeEntities: Bool?, skipStatus: Bool?, success: ((user: Dictionary<String, JSONValue>?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/subscribers/show.json"

        var parameters = Dictionary<String, Any>()
        parameters["list_id"] = listID
        parameters["user_id"] = userID

        parameters["include_entities"] ??= includeEntities
        parameters["skip_status"] ??= skipStatus

        self.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(user: json.object)
            }, failure: failure)
    }

    public func getListsSubscribersShowWithListID(listID: String, screenName: String, includeEntities: Bool?, skipStatus: Bool?, success: ((user: Dictionary<String, JSONValue>?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/subscribers/show.json"

        var parameters = Dictionary<String, Any>()
        parameters["list_id"] = listID
        parameters["screen_name"] = screenName

        parameters["include_entities"] ??= includeEntities
        parameters["skip_status"] ??= skipStatus

        self.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(user: json.object)
            }, failure: failure)
    }

    public func getListsSubscribersShowWithSlug(slug: String, ownerID: String, userID: String, includeEntities: Bool?, skipStatus: Bool?, success: ((user: Dictionary<String, JSONValue>?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/subscribers/show.json"

        var parameters = Dictionary<String, Any>()
        parameters["slug"] = slug
        parameters["owner_id"] = ownerID
        parameters["user_id"] = userID

        parameters["include_entities"] ??= includeEntities
        parameters["skip_status"] ??= skipStatus

        self.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(user: json.object)
            }, failure: failure)
    }

    public func getListsSubscribersShowWithSlug(slug: String, ownerID: String, screenName: String, includeEntities: Bool?, skipStatus: Bool?, success: ((user: Dictionary<String, JSONValue>?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/subscribers/show.json"

        var parameters = Dictionary<String, Any>()
        parameters["slug"] = slug
        parameters["owner_id"] = ownerID
        parameters["screen_name"] = screenName

        parameters["include_entities"] ??= includeEntities
        parameters["skip_status"] ??= skipStatus

        self.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(user: json.object)
            }, failure: failure)
    }

    public func getListsSubscribersShowWithSlug(slug: String, ownerScreenName: String, userID: String, includeEntities: Bool?, skipStatus: Bool?, success: ((user: Dictionary<String, JSONValue>?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/subscribers/show.json"

        var parameters = Dictionary<String, Any>()
        parameters["slug"] = slug
        parameters["owner_screen_name"] = ownerScreenName
        parameters["user_id"] = userID

        parameters["include_entities"] ??= includeEntities
        parameters["skip_status"] ??= skipStatus

        self.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(user: json.object)
            }, failure: failure)
    }

    public func getListsSubscribersShowWithSlug(slug: String, ownerScreenName: String, screenName: String, includeEntities: Bool?, skipStatus: Bool?, success: ((user: Dictionary<String, JSONValue>?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/subscribers/show.json"

        var parameters = Dictionary<String, Any>()
        parameters["slug"] = slug
        parameters["owner_screen_name"] = ownerScreenName
        parameters["screen_name"] = screenName

        parameters["include_entities"] ??= includeEntities
        parameters["skip_status"] ??= skipStatus

        self.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(user: json.object)
            }, failure: failure)
    }

    /*
    POST	lists/subscribers/destroy

    Unsubscribes the authenticated user from the specified list.
    */
    public func postListsSubscribersDestroyWithListID(listID: String, success: ((user: Dictionary<String, JSONValue>?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/subscribers/destroy.json"

        var parameters = Dictionary<String, Any>()
        parameters["list_id"] = listID

        self.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(user: json.object)
            }, failure: failure)
    }

    public func postListsSubscribersDestroyWithSlug(slug: String, ownerScreenName: String, success: ((user: Dictionary<String, JSONValue>?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/subscribers/destroy.json"

        var parameters = Dictionary<String, Any>()
        parameters["slug"] = slug
        parameters["owner_screen_name"] = ownerScreenName

        self.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(user: json.object)
            }, failure: failure)
    }

    public func postListsSubscribersDestroyWithSlug(slug: String, ownerID: String, success: ((user: Dictionary<String, JSONValue>?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/subscribers/destroy.json"

        var parameters = Dictionary<String, Any>()
        parameters["slug"] = slug
        parameters["owner_id"] = ownerID

        self.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(user: json.object)
            }, failure: failure)
    }

    /*
    POST	lists/members/create_all

    Adds multiple members to a list, by specifying a comma-separated list of member ids or screen names. The authenticated user must own the list to be able to add members to it. Note that lists can't have more than 5,000 members, and you are limited to adding up to 100 members to a list at a time with this method.

    Please note that there can be issues with lists that rapidly remove and add memberships. Take care when using these methods such that you are not too rapidly switching between removals and adds on the same list.
    */
    public func postListsMembersCreateWithListID(listID: String, userIDs: [String], includeEntities: Bool?, skipStatus: Bool?, success: ((response: JSON?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/members/create_all.json"

        var parameters = Dictionary<String, Any>()
        parameters["list_id"] = listID

        let userIDStrings = userIDs.map { String($0) }
        parameters["user_id"] = userIDStrings.joinWithSeparator(",")

        parameters["include_entities"] ??= includeEntities
        parameters["skip_status"] ??= skipStatus

        self.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(response: json)
            }, failure: failure)
    }

    public func postListsMembersCreateWithListID(listID: String, screenNames: [String], includeEntities: Bool?, skipStatus: Bool?, success: ((response: JSON?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/members/create_all.json"

        var parameters = Dictionary<String, Any>()
        parameters["list_id"] = listID
        parameters["screen_name"] = screenNames.joinWithSeparator(",")

        parameters["include_entities"] ??= includeEntities
        parameters["skip_status"] ??= skipStatus

        self.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(response: json)
            }, failure: failure)
    }

    public func postListsMembersCreateWithSlug(slug: String, ownerID: String, userIDs: [String], includeEntities: Bool?, skipStatus: Bool?, success: ((response: JSON?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/members/create_all.json"

        var parameters = Dictionary<String, Any>()
        parameters["slug"] = slug
        parameters["owner_id"] = ownerID

        let userIDStrings = userIDs.map { String($0) }
        parameters["user_id"] = userIDStrings.joinWithSeparator(",")

        parameters["include_entities"] ??= includeEntities
        parameters["skip_status"] ??= skipStatus

        self.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(response: json)
            }, failure: failure)
    }

    public func postListsMembersCreateWithSlug(slug: String, ownerID: String, screenNames: [String], includeEntities: Bool?, skipStatus: Bool?, success: ((response: JSON?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/members/create_all.json"

        var parameters = Dictionary<String, Any>()
        parameters["slug"] = slug
        parameters["owner_id"] = ownerID
        parameters["screen_name"] = screenNames.joinWithSeparator(",")

        parameters["include_entities"] ??= includeEntities
        parameters["skip_status"] ??= skipStatus

        self.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(response: json)
            }, failure: failure)
    }

    public func postListsMembersCreateWithSlug(slug: String, ownerScreenName: String, userIDs: [String], includeEntities: Bool?, skipStatus: Bool?, success: ((response: JSON?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/members/create_all.json"

        var parameters = Dictionary<String, Any>()
        parameters["slug"] = slug
        parameters["owner_screen_name"] = ownerScreenName

        let userIDStrings = userIDs.map { String($0) }
        parameters["user_id"] = userIDStrings.joinWithSeparator(",")

        parameters["include_entities"] ??= includeEntities
        parameters["skip_status"] ??= skipStatus

        self.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(response: json)
            }, failure: failure)
    }

    public func postListsMembersCreateWithSlug(slug: String, ownerScreenName: String, screenNames: [String], includeEntities: Bool?, skipStatus: Bool?, success: ((response: JSON?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/members/create_all.json"

        var parameters = Dictionary<String, Any>()
        parameters["slug"] = slug
        parameters["owner_screen_name"] = ownerScreenName
        parameters["screen_name"] = screenNames.joinWithSeparator(",")

        parameters["include_entities"] ??= includeEntities
        parameters["skip_status"] ??= skipStatus

        self.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(response: json)
            }, failure: failure)
    }

    /*
    GET	lists/members/show

    Check if the specified user is a member of the specified list.
    */
    public func getListsMembersShowWithListID(listID: String, userID: String, includeEntities: Bool?, skipStatus: Bool?, success: ((user: Dictionary<String, JSONValue>?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/members/show.json"

        var parameters = Dictionary<String, Any>()
        parameters["list_id"] = listID
        parameters["user_id"] = userID
        parameters["include_entities"] ??= includeEntities
        parameters["skip_status"] ??= skipStatus

        self.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(user: json.object)
            }, failure: failure)
    }

    public func getListsMembersShowWithListID(listID: String, screenName: String, includeEntities: Bool?, skipStatus: Bool?, success: ((user: Dictionary<String, JSONValue>?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/members/show.json"

        var parameters = Dictionary<String, Any>()
        parameters["list_id"] = listID
        parameters["screen_name"] = screenName
        parameters["include_entities"] ??= includeEntities
        parameters["skip_status"] ??= skipStatus

        self.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(user: json.object)
            }, failure: failure)
    }

    public func getListsMembersShowWithSlug(slug: String, ownerID: String, userID: String, includeEntities: Bool?, skipStatus: Bool?, success: ((user: Dictionary<String, JSONValue>?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/members/show.json"

        var parameters = Dictionary<String, Any>()
        parameters["slug"] = slug
        parameters["owner_id"] = ownerID
        parameters["user_id"] = userID
        parameters["include_entities"] ??= includeEntities
        parameters["skip_status"] ??= skipStatus

        self.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(user: json.object)
            }, failure: failure)
    }

    public func getListsMembersShowWithSlug(slug: String, ownerID: String, screenName: String, includeEntities: Bool?, skipStatus: Bool?, success: ((user: Dictionary<String, JSONValue>?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/members/show.json"

        var parameters = Dictionary<String, Any>()
        parameters["slug"] = slug
        parameters["owner_id"] = ownerID
        parameters["screen_name"] = screenName
        parameters["include_entities"] ??= includeEntities
        parameters["skip_status"] ??= skipStatus

        self.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(user: json.object)
            }, failure: failure)
    }

    public func getListsMembersShowWithSlug(slug: String, ownerScreenName: String, userID: String, includeEntities: Bool?, skipStatus: Bool?, success: ((user: Dictionary<String, JSONValue>?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/members/show.json"

        var parameters = Dictionary<String, Any>()
        parameters["slug"] = slug
        parameters["owner_screen_name"] = ownerScreenName
        parameters["user_id"] = userID
        parameters["include_entities"] ??= includeEntities
        parameters["skip_status"] ??= skipStatus

        self.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(user: json.object)
            }, failure: failure)
    }

    /*
    GET    lists/members

    Returns the members of the specified list. Private list members will only be shown if the authenticated user owns the specified list.
    */
    public func getListsMembersShowWithSlug(slug: String, ownerScreenName: String, screenName: String, includeEntities: Bool?, skipStatus: Bool?, success: ((user: Dictionary<String, JSONValue>?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/members/show.json"

        var parameters = Dictionary<String, Any>()
        parameters["slug"] = slug
        parameters["owner_screen_name"] = ownerScreenName
        parameters["screen_name"] = screenName
        parameters["include_entities"] ??= includeEntities
        parameters["skip_status"] ??= skipStatus

        self.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(user: json.object)
            }, failure: failure)
    }

    public func getListsMembersWithListID(listID: String, ownerScreenName: String?, cursor: String?, includeEntities: Bool?, skipStatus: Bool?, success: ((users: [JSONValue]?, previousCursor: String?, nextCursor: String?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/members.json"

        var parameters = Dictionary<String, Any>()
        parameters["list_id"] = listID
        parameters["owner_screen_name"] ??= ownerScreenName
        parameters["cursor"] ??= cursor
        parameters["include_entities"] ??= includeEntities
        parameters["skip_status"] ??= skipStatus

        self.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(users: json["users"].array, previousCursor: json["previous_cursor_str"].string, nextCursor: json["next_cursor_str"].string)

            }, failure: failure)
    }

    public func getListsMembersWithListID(listID: String, ownerID: String?, cursor: String?, includeEntities: Bool?, skipStatus: Bool?, success: ((users: [JSONValue]?, previousCursor: String?, nextCursor: String?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/members.json"

        var parameters = Dictionary<String, Any>()
        parameters["list_id"] = listID
        parameters["owner_id"] ??= ownerID
        parameters["cursor"] ??= cursor
        parameters["include_entities"] ??= includeEntities
        parameters["skip_status"] ??= skipStatus

        self.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(users: json["users"].array, previousCursor: json["previous_cursor_str"].string, nextCursor: json["next_cursor_str"].string)

            }, failure: failure)
    }

    public func getListsMembersWithSlug(slug: String, ownerScreenName: String?, cursor: String?, includeEntities: Bool?, skipStatus: Bool?, success: ((users: [JSONValue]?, previousCursor: String?, nextCursor: String?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/members.json"

        var parameters = Dictionary<String, Any>()
        parameters["slug"] = slug
        parameters["owner_screen_name"] ??= ownerScreenName
        parameters["cursor"] ??= cursor
        parameters["include_entities"] ??= includeEntities
        parameters["skip_status"] ??= skipStatus

        self.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(users: json["users"].array, previousCursor: json["previous_cursor_str"].string, nextCursor: json["next_cursor_str"].string)

            }, failure: failure)
    }

    public func getListsMembersWithSlug(slug: String, ownerID: String?, cursor: String?, includeEntities: Bool?, skipStatus: Bool?, success: ((users: [JSONValue]?, previousCursor: String?, nextCursor: String?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/members.json"

        var parameters = Dictionary<String, Any>()
        parameters["slug"] = slug
        parameters["owner_id"] ??= ownerID
        parameters["cursor"] ??= cursor
        parameters["include_entities"] ??= includeEntities
        parameters["skip_status"] ??= skipStatus

        self.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(users: json["users"].array, previousCursor: json["previous_cursor_str"].string, nextCursor: json["next_cursor_str"].string)

            }, failure: failure)
    }


    /*
    POST	lists/members/create

    Creates a new list for the authenticated user. Note that you can't create more than 20 lists per account.
    */
    public func postListsMembersCreateWithListID(listID: String, ownerScreenName: String, success: ((user: Dictionary<String, JSONValue>?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/subscribers/create.json"

        var parameters = Dictionary<String, Any>()
        parameters["owner_screen_name"] = ownerScreenName
        parameters["list_id"] = listID

        self.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(user: json.object)
            }, failure: failure)
    }

    public func postListsMembersCreateWithListID(listID: String, ownerID: String, success: ((user: Dictionary<String, JSONValue>?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/subscribers/create.json"

        var parameters = Dictionary<String, Any>()
        parameters["owner_id"] = ownerID
        parameters["list_id"] = listID

        self.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(user: json.object)
            }, failure: failure)
    }

    public func postListsMembersCreateWithSlug(slug: String, ownerScreenName: String, success: ((user: Dictionary<String, JSONValue>?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/subscribers/create.json"

        var parameters = Dictionary<String, Any>()
        parameters["owner_screen_name"] = ownerScreenName
        parameters["slug"] = slug

        self.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(user: json.object)
            }, failure: failure)
    }

    public func postListsMembersCreateWithSlug(slug: String, ownerID: String, success: ((user: Dictionary<String, JSONValue>?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/subscribers/create.json"

        var parameters = Dictionary<String, Any>()
        parameters["owner_id"] = ownerID
        parameters["slug"] = slug

        self.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(user: json.object)
            }, failure: failure)
    }

    /*
    POST	lists/destroy

    Deletes the specified list. The authenticated user must own the list to be able to destroy it.
    */
    public func postListsDestroyWithListID(listID: String, success: ((list: Dictionary<String, JSONValue>?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/destroy.json"

        var parameters = Dictionary<String, Any>()
        parameters["list_id"] = listID

        self.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(list: json.object)
            }, failure: failure)
    }

    public func postListsDestroyWithSlug(slug: String, ownerID: String, success: ((list: Dictionary<String, JSONValue>?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/destroy.json"

        var parameters = Dictionary<String, Any>()
        parameters["slug"] = slug
        parameters["owner_id"] = ownerID

        self.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(list: json.object)
            }, failure: failure)
    }

    public func postListsDestroyWithSlug(slug: String, ownerScreenName: String, success: ((list: Dictionary<String, JSONValue>?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/destroy.json"

        var parameters = Dictionary<String, Any>()
        parameters["slug"] = slug
        parameters["owner_screen_name"] = ownerScreenName

        self.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(list: json.object)
            }, failure: failure)
    }

    /*
    POST	lists/update

    Updates the specified list. The authenticated user must own the list to be able to update it.
    */
    public func postListsUpdateWithListID(listID: String, name: String?, publicMode: Bool = true, description: String?, success: ((list: Dictionary<String, JSONValue>?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/update.json"

        var parameters = Dictionary<String, Any>()
        parameters["list_id"] = listID
        parameters["name"] ??= name
        parameters["mode"] = publicMode ? "public" : "private"
        parameters["description"] ??= description

        self.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(list: json.object)
            }, failure: failure)
    }

    public func postListsUpdateWithSlug(slug: String, ownerID: String, name: String?, publicMode: Bool = true, description: String?, success: ((list: Dictionary<String, JSONValue>?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/update.json"

        var parameters = Dictionary<String, Any>()
        parameters["slug"] = slug
        parameters["owner_id"] = ownerID
        parameters["name"] ??= name
        parameters["mode"] = publicMode ? "public" : "private"
        parameters["description"] ??= description

        self.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(list: json.object)
            }, failure: failure)
    }

    public func postListsUpdateWithSlug(slug: String, ownerScreenName: String, name: String?, publicMode: Bool = true, description: String?, success: ((list: Dictionary<String, JSONValue>?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/update.json"

        var parameters = Dictionary<String, Any>()
        parameters["slug"] = slug
        parameters["owner_screen_name"] = ownerScreenName
        parameters["name"] ??= name
        parameters["mode"] = publicMode ? "public" : "private"
        parameters["description"] ??= description

        self.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(list: json.object)
            }, failure: failure)
    }

    /*
    POST	lists/create

    Creates a new list for the authenticated user. Note that you can't create more than 20 lists per account.
    */
    public func postListsCreateWithName(name: String, publicMode: Bool = true, description: String?, success: ((list: Dictionary<String, JSONValue>?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/create.json"

        var parameters = Dictionary<String, Any>()
        parameters["name"] = name
        parameters["mode"] = publicMode ? "public" : "private"
        parameters["description"] ??= description

        self.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(list: json.object)
            }, failure: failure)
    }

    /*
    GET	lists/show

    Returns the specified list. Private lists will only be shown if the authenticated user owns the specified list.
    */
    public func getListsShowWithID(listID: String, success: ((list: Dictionary<String, JSONValue>?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/show.json"

        var parameters = Dictionary<String, Any>()
        parameters["list_id"] = listID

        self.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(list: json.object)
            }, failure: failure)
    }

    public func getListsShowWithSlug(slug: String, ownerID: String, success: ((list: Dictionary<String, JSONValue>?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/show.json"

        var parameters = Dictionary<String, Any>()
        parameters["slug"] = slug
        parameters["owner_id"] = ownerID

        self.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(list: json.object)
            }, failure: failure)
    }

    public func getListsShowWithSlug(slug: String, ownerScreenName: String, success: ((list: Dictionary<String, JSONValue>?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/show.json"

        var parameters = Dictionary<String, Any>()
        parameters["slug"] = slug
        parameters["owner_screen_name"] = ownerScreenName

        self.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(list: json.object)
            }, failure: failure)
    }

    /*
    GET	lists/subscriptions

    Obtain a collection of the lists the specified user is subscribed to, 20 lists per page by default. Does not include the user's own lists.
    */
    public func getListsSubscriptionsWithUserID(userID: String, count: String?, cursor: String?, success: ((lists: [JSONValue]?, previousCursor: String?, nextCursor: String?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/subscriptions.json"

        var parameters = Dictionary<String, Any>()
        parameters["user_id"] = userID
        parameters["count"] ??= count
        parameters["cursor"] ??= cursor

        self.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(lists: json["lists"].array, previousCursor: json["previous_cursor_str"].string, nextCursor: json["next_cursor_str"].string)

            }, failure: failure)
    }

    public func getListsSubscriptionsWithScreenName(screenName: String, count: String?, cursor: String?, success: ((lists: [JSONValue]?, previousCursor: String?, nextCursor: String?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/subscriptions.json"

        var parameters = Dictionary<String, Any>()
        parameters["screen_name"] = screenName
        parameters["count"] ??= count
        parameters["cursor"] ??= cursor

        self.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(lists: json["lists"].array, previousCursor: json["previous_cursor_str"].string, nextCursor: json["next_cursor_str"].string)

            }, failure: failure)
    }

    /*
    POST	lists/members/destroy_all

    Removes multiple members from a list, by specifying a comma-separated list of member ids or screen names. The authenticated user must own the list to be able to remove members from it. Note that lists can't have more than 500 members, and you are limited to removing up to 100 members to a list at a time with this method.

    Please note that there can be issues with lists that rapidly remove and add memberships. Take care when using these methods such that you are not too rapidly switching between removals and adds on the same list.
    */
    public func postListsMembersDestroyAllWithListID(listID: String, userIDs: [String], success: ((response: JSON?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/members/destroy_all.json"

        var parameters = Dictionary<String, Any>()
        parameters["list_id"] = listID

        let userIDStrings = userIDs.map { String($0) }
        parameters["user_id"] = userIDStrings.joinWithSeparator(",")

        self.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(response: json)
            }, failure: failure)
    }

    public func postListsMembersDestroyAllWithListID(listID: String, screenNames: [String], success: ((response: JSON?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/members/destroy_all.json"

        var parameters = Dictionary<String, Any>()
        parameters["list_id"] = listID
        parameters["screen_name"] = screenNames.joinWithSeparator(",")

        self.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(response: json)
            }, failure: failure)
    }

    public func postListsMembersDestroyAllWithSlug(slug: String, userIDs: [String], ownerScreenName: String, success: ((response: JSON?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/members/destroy_all.json"

        var parameters = Dictionary<String, Any>()
        parameters["slug"] = slug
        let userIDStrings = userIDs.map { String($0) }
        parameters["user_id"] = userIDStrings.joinWithSeparator(",")
        parameters["owner_screen_name"] = ownerScreenName

        self.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(response: json)
            }, failure: failure)
    }

    public func postListsMembersDestroyAllWithSlug(slug: String, screenNames: [String], ownerScreenName: String, success: ((response: JSON?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/members/destroy_all.json"

        var parameters = Dictionary<String, Any>()
        parameters["slug"] = slug
        parameters["screen_name"] = screenNames.joinWithSeparator(",")
        parameters["owner_screen_name"] = ownerScreenName
        
        self.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in            
            success?(response: json)
            }, failure: failure)
    }
    
    public func postListsMembersDestroyAllWithSlug(slug: String, userIDs: [String], ownerID: String, success: ((response: JSON?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/members/destroy_all.json"
        
        var parameters = Dictionary<String, Any>()
        parameters["slug"] = slug

        let userIDStrings = userIDs.map { String($0) }
        parameters["user_id"] = userIDStrings.joinWithSeparator(",")
        parameters["owner_id"] = ownerID
        
        self.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in            
            success?(response: json)
            }, failure: failure)
    }
    
    public func postListsMembersDestroyAllWithSlug(slug: String, screenNames: [String], ownerID: String, success: ((response: JSON?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/members/destroy_all.json"
        
        var parameters = Dictionary<String, Any>()
        parameters["slug"] = slug
        parameters["screen_name"] = screenNames.joinWithSeparator(",")
        parameters["owner_id"] = ownerID
        
        self.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in            
            success?(response: json)
            }, failure: failure)
    }
    
    /*
    GET    lists/ownerships
    
    Returns the lists owned by the specified Twitter user. Private lists will only be shown if the authenticated user is also the owner of the lists.
    */
    public func getListsOwnershipsWithUserID(userID: String, count: String?, cursor: String?, success: ((lists: [JSONValue]?, previousCursor: String?, nextCursor: String?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/ownerships.json"
        
        var parameters = Dictionary<String, Any>()
        parameters["user_id"] = userID
        parameters["count"] ??= count
        parameters["cursor"] ??= cursor
        
        self.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in            
            success?(lists: json["lists"].array, previousCursor: json["previous_cursor_str"].string, nextCursor: json["next_cursor_str"].string)

            }, failure: failure)
        
    }
    
}
