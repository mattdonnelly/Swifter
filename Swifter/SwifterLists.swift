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

    /**
    GET    lists/list

    Returns all lists the authenticating or specified user subscribes to, including their own. The user is specified using the user_id or screen_name parameters. If no user is given, the authenticating user is used.

    This method used to be GET lists in version 1.0 of the API and has been renamed for consistency with other call.

    A maximum of 100 results will be returned by this call. Subscribed lists are returned first, followed by owned lists. This means that if a user subscribes to 90 lists and owns 20 lists, this method returns 90 subscriptions and 10 owned lists. The reverse method returns owned lists first, so with reverse=true, 20 owned lists and 80 subscriptions would be returned. If your goal is to obtain every list a user owns or subscribes to, use GET lists/ownerships and/or GET lists/subscriptions instead.
    */
    public func getListsSubscribedByUserW(reverse: Bool?, success: ((lists: [JSON]?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/list.json"

        var parameters = Dictionary<String, Any>()
        parameters["reverse"] ??= reverse

        self.getJSON(path: path, baseURL: .api, parameters: parameters, success: { json, _ in
            success?(lists: json.array)
            }, failure: failure)
    }

    public func getListsSubscribedByUser(for userTag: UserTag, reverse: Bool?, success: ((lists: [JSON]?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/list.json"

        var parameters = Dictionary<String, Any>()
        parameters[userTag.key] = userTag.value
        parameters["reverse"] ??= reverse

        self.getJSON(path: path, baseURL: .api, parameters: parameters, success: { json, _ in
            success?(lists: json.array)
            }, failure: failure)
    }

    /**
    GET	lists/statuses

    Returns a timeline of tweets authored by members of the specified list. Retweets are included by default. Use the include_rts=false parameter to omit retweets. Embedded Timelines is a great way to embed list timelines on your website.
    */
    public func getListsStatuses(forId listID: String, owner ownerTag: UserTag, sinceID: String?, maxID: String?, count: Int?, includeEntities: Bool?, includeRTs: Bool?, success: ((statuses: [JSON]?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/statuses.json"

        var parameters = Dictionary<String, Any>()
        parameters["list_id"] = listID
        parameters[ownerTag.ownerKey] = ownerTag.value
        parameters["since_id"] ??= sinceID
        parameters["max_id"] ??= maxID
        parameters["count"] ??= count
        parameters["include_entities"] ??= includeEntities
        parameters["include_rts"] ??= includeRTs

        self.getJSON(path: path, baseURL: .api, parameters: parameters, success: { json, _ in
            success?(statuses: json.array)
            }, failure: failure)
    }

    public func getListsStatuses(forSlug slug: String, owner ownerTag: UserTag, sinceID: String?, maxID: String?, count: Int?, includeEntities: Bool?, includeRTs: Bool?, success: ((statuses: [JSON]?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/statuses.json"

        var parameters = Dictionary<String, Any>()
        parameters["slug"] = slug
        parameters[ownerTag.ownerKey] = ownerTag.value
        parameters["since_id"] ??= sinceID
        parameters["max_id"] ??= maxID
        parameters["count"] ??= count
        parameters["include_entities"] ??= includeEntities
        parameters["include_rts"] ??= includeRTs

        self.getJSON(path: path, baseURL: .api, parameters: parameters, success: { json, _ in
            success?(statuses: json.array)
            }, failure: failure)
    }

    /**
    POST	lists/members/destroy

    Removes the specified member from the list. The authenticated user must be the list's owner to remove members from the list.
    */
    public func postListsMembersDestroy(forId listID: String, user userTag: UserTag, success: ((response: JSON?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/members/destroy.json"

        var parameters = Dictionary<String, Any>()
        parameters["list_id"] = listID
        parameters[userTag.key] = userTag.value

        self.postJSON(path: path, baseURL: .api, parameters: parameters, success: { json, _ in
            success?(response: json)
            }, failure: failure)
    }

    public func postListsMembersDestroy(forSlug slug: String, user userTag: UserTag, owner ownerTag: UserTag, success: ((response: JSON?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/members/destroy.json"

        var parameters = Dictionary<String, Any>()
        parameters["slug"] = slug
        parameters[userTag.key] = userTag.value
        parameters[ownerTag.ownerKey] = ownerTag.value

        self.postJSON(path: path, baseURL: .api, parameters: parameters, success: { json, _ in
            success?(response: json)
            }, failure: failure)
    }

    /**
    GET    lists/memberships

    Returns the lists the specified user has been added to. If user_id or screen_name are not provided the memberships for the authenticating user are returned.
    */
    public func getListsMemberships(for userTag: UserTag, cursor: String?, filterToOwnedLists: Bool?, success: ((lists: [JSON]?, previousCursor: String?, nextCursor: String?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/memberships.json"

        var parameters = Dictionary<String, Any>()
        parameters[userTag.key] = userTag.value
        parameters["cursor"] ??= cursor
        parameters["filter_to_owned_lists"] ??= filterToOwnedLists

        self.getJSON(path: path, baseURL: .api, parameters: parameters, success: { json, _ in
            success?(lists: json["lists"].array, previousCursor: json["previous_cursor_str"].string, nextCursor: json["next_cursor_str"].string)

            }, failure: failure)
    }

    /**
    GET	lists/subscribers

    Returns the subscribers of the specified list. Private list subscribers will only be shown if the authenticated user owns the specified list.
    */
    public func getListsSubscribers(forId listID: String, owner ownerTag: UserTag, cursor: String?, includeEntities: Bool?, skipStatus: Bool?, success: ((users: [JSON]?, previousCursor: String?, nextCursor: String?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/subscribers.json"

        var parameters = Dictionary<String, Any>()
        parameters["list_id"] = listID
        parameters[ownerTag.ownerKey] = ownerTag.value
        parameters["cursor"] ??= cursor
        parameters["include_entities"] ??= includeEntities
        parameters["skip_status"] ??= skipStatus

        self.getJSON(path: path, baseURL: .api, parameters: parameters, success: { json, _ in            
            success?(users: json["users"].array, previousCursor: json["previous_cursor_str"].string, nextCursor: json["next_cursor_str"].string)

            }, failure: failure)
    }

    public func getListsSubscribers(forSlug slug: String, owner ownerTag: UserTag, cursor: String?, includeEntities: Bool?, skipStatus: Bool?, success: ((users: [JSON]?, previousCursor: String?, nextCursor: String?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/subscribers.json"

        var parameters = Dictionary<String, Any>()
        parameters["slug"] = slug
        parameters[ownerTag.ownerKey] = ownerTag.value
        parameters["cursor"] ??= cursor
        parameters["include_entities"] ??= includeEntities
        parameters["skip_status"] ??= skipStatus

        self.getJSON(path: path, baseURL: .api, parameters: parameters, success: { json, _ in
            success?(users: json["users"].array, previousCursor: json["previous_cursor_str"].string, nextCursor: json["next_cursor_str"].string)

            }, failure: failure)
    }

    /**
    POST	lists/subscribers/create

    Subscribes the authenticated user to the specified list.
    */
    public func postListsSubscribersCreate(forId listID: String, owner ownerTag: UserTag, success: ((user: Dictionary<String, JSON>?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/subscribers/create.json"

        var parameters = Dictionary<String, Any>()
        parameters["list_id"] = listID
        parameters[ownerTag.ownerKey] = ownerTag.value

        self.postJSON(path: path, baseURL: .api, parameters: parameters, success: { json, _ in
            success?(user: json.object)
            }, failure: failure)
    }

    public func postListsSubscribersCreate(forSlug slug: String, owner ownerTag: UserTag, success: ((user: Dictionary<String, JSON>?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/subscribers/create.json"

        var parameters = Dictionary<String, Any>()
        parameters["slug"] = slug
        parameters[ownerTag.ownerKey] = ownerTag.value

        self.postJSON(path: path, baseURL: .api, parameters: parameters, success: { json, _ in
            success?(user: json.object)
            }, failure: failure)
    }

    /**
    GET	lists/subscribers/show

    Check if the specified user is a subscriber of the specified list. Returns the user if they are subscriber.
    */
    public func getListsSubscribersShow(forId listID: String, user userTag: UserTag, includeEntities: Bool?, skipStatus: Bool?, success: ((user: Dictionary<String, JSON>?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/subscribers/show.json"

        var parameters = Dictionary<String, Any>()
        parameters["list_id"] = listID
        parameters[userTag.key] = userTag.value

        parameters["include_entities"] ??= includeEntities
        parameters["skip_status"] ??= skipStatus

        self.getJSON(path: path, baseURL: .api, parameters: parameters, success: { json, _ in
            success?(user: json.object)
            }, failure: failure)
    }

    public func getListsSubscribersShow(forSlug slug: String, owner ownerTag: UserTag, user userTag: UserTag, includeEntities: Bool?, skipStatus: Bool?, success: ((user: Dictionary<String, JSON>?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/subscribers/show.json"

        var parameters = Dictionary<String, Any>()
        parameters["slug"] = slug
        parameters[userTag.key] = userTag.value
        parameters[ownerTag.ownerKey] = ownerTag.value

        parameters["include_entities"] ??= includeEntities
        parameters["skip_status"] ??= skipStatus

        self.getJSON(path: path, baseURL: .api, parameters: parameters, success: { json, _ in
            success?(user: json.object)
            }, failure: failure)
    }

    /**
    POST	lists/subscribers/destroy

    Unsubscribes the authenticated user from the specified list.
    */
    public func postListsSubscribersDestroy(forId listID: String, success: ((user: Dictionary<String, JSON>?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/subscribers/destroy.json"

        var parameters = Dictionary<String, Any>()
        parameters["list_id"] = listID

        self.postJSON(path: path, baseURL: .api, parameters: parameters, success: { json, _ in
            success?(user: json.object)
            }, failure: failure)
    }

    public func postListsSubscribersDestroy(forSlug slug: String, owner ownerTag: UserTag, success: ((user: Dictionary<String, JSON>?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/subscribers/destroy.json"

        var parameters = Dictionary<String, Any>()
        parameters["slug"] = slug
        parameters[ownerTag.ownerKey] = ownerTag.value

        self.postJSON(path: path, baseURL: .api, parameters: parameters, success: { json, _ in
            success?(user: json.object)
            }, failure: failure)
    }

    /**
    POST	lists/members/create_all

    Adds multiple members to a list, by specifying a comma-separated list of member ids or screen names. The authenticated user must own the list to be able to add members to it. Note that lists can't have more than 5,000 members, and you are limited to adding up to 100 members to a list at a time with this method.

    Please note that there can be issues with lists that rapidly remove and add memberships. Take care when using these methods such that you are not too rapidly switching between removals and adds on the same list.
    */
    public func postListsMembersCreate(forId listID: String, users usersTag: UsersTag, includeEntities: Bool?, skipStatus: Bool?, success: ((response: JSON?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/members/create_all.json"

        var parameters = Dictionary<String, Any>()
        parameters["list_id"] = listID
        parameters[usersTag.key] = usersTag.value

        parameters["include_entities"] ??= includeEntities
        parameters["skip_status"] ??= skipStatus

        self.postJSON(path: path, baseURL: .api, parameters: parameters, success: { json, _ in
            success?(response: json)
            }, failure: failure)
    }

    public func postListsMembersCreate(forSlug slug: String, owner ownerTag: UserTag, users usersTag: UsersTag, includeEntities: Bool?, skipStatus: Bool?, success: ((response: JSON?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/members/create_all.json"

        var parameters = Dictionary<String, Any>()
        parameters["slug"] = slug
        parameters[ownerTag.ownerKey] = ownerTag.value
        parameters[usersTag.key] = usersTag.value
        
        parameters["include_entities"] ??= includeEntities
        parameters["skip_status"] ??= skipStatus

        self.postJSON(path: path, baseURL: .api, parameters: parameters, success: { json, _ in
            success?(response: json)
            }, failure: failure)
    }

    /**
    GET	lists/members/show

    Check if the specified user is a member of the specified list.
    */
    public func getListsMembersShow(forId listID: String, user userTag: UserTag, includeEntities: Bool?, skipStatus: Bool?, success: ((user: Dictionary<String, JSON>?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/members/show.json"

        var parameters = Dictionary<String, Any>()
        parameters["list_id"] = listID
        parameters[userTag.key] = userTag.value
        parameters["include_entities"] ??= includeEntities
        parameters["skip_status"] ??= skipStatus

        self.getJSON(path: path, baseURL: .api, parameters: parameters, success: { json, _ in
            success?(user: json.object)
            }, failure: failure)
    }

    public func getListsMembersShow(forSlug slug: String, owner ownerTag: UserTag, user userTag: UserTag, includeEntities: Bool?, skipStatus: Bool?, success: ((user: Dictionary<String, JSON>?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/members/show.json"

        var parameters = Dictionary<String, Any>()
        parameters["slug"] = slug
        parameters[ownerTag.ownerKey] = ownerTag.value
        parameters[userTag.key] = userTag.value
        parameters["include_entities"] ??= includeEntities
        parameters["skip_status"] ??= skipStatus

        self.getJSON(path: path, baseURL: .api, parameters: parameters, success: { json, _ in
            success?(user: json.object)
            }, failure: failure)
    }

    /**
    GET    lists/members

    Returns the members of the specified list. Private list members will only be shown if the authenticated user owns the specified list.
    */

    public func getListsMembers(forId listID: String, cursor: String?, includeEntities: Bool?, skipStatus: Bool?, success: ((users: [JSON]?, previousCursor: String?, nextCursor: String?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/members.json"

        var parameters = Dictionary<String, Any>()
        parameters["list_id"] = listID
        parameters["cursor"] ??= cursor
        parameters["include_entities"] ??= includeEntities
        parameters["skip_status"] ??= skipStatus

        self.getJSON(path: path, baseURL: .api, parameters: parameters, success: { json, _ in
            success?(users: json["users"].array, previousCursor: json["previous_cursor_str"].string, nextCursor: json["next_cursor_str"].string)

            }, failure: failure)
    }
    
    public func getListsMembers(forSlug slug: String, owner ownerTag: UserTag, cursor: String?, includeEntities: Bool?, skipStatus: Bool?, success: ((users: [JSON]?, previousCursor: String?, nextCursor: String?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/members.json"

        var parameters = Dictionary<String, Any>()
        parameters["slug"] = slug
        parameters[ownerTag.ownerKey] = ownerTag.value
        parameters["cursor"] ??= cursor
        parameters["include_entities"] ??= includeEntities
        parameters["skip_status"] ??= skipStatus

        self.getJSON(path: path, baseURL: .api, parameters: parameters, success: { json, _ in
            success?(users: json["users"].array, previousCursor: json["previous_cursor_str"].string, nextCursor: json["next_cursor_str"].string)

            }, failure: failure)
    }

    /**
    POST	lists/members/create

    Creates a new list for the authenticated user. Note that you can't create more than 20 lists per account.
    */
    public func postListsMembersCreate(forId listID: String, user userTag: UserTag, success: ((user: Dictionary<String, JSON>?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/members/create.json"

        var parameters = Dictionary<String, Any>()
        parameters["list_id"] = listID
        parameters[userTag.key] = userTag.value

        self.postJSON(path: path, baseURL: .api, parameters: parameters, success: { json, _ in
            success?(user: json.object)
            }, failure: failure)
    }

    public func postListsMembersCreate(forSlug slug: String, owner ownerTag: UserTag, user userTag: UserTag, success: ((user: Dictionary<String, JSON>?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/members/create.json"

        var parameters = Dictionary<String, Any>()
        parameters["slug"] = slug
        parameters[ownerTag.ownerKey] = ownerTag.value
        parameters[userTag.key] = userTag.value

        self.postJSON(path: path, baseURL: .api, parameters: parameters, success: { json, _ in
            success?(user: json.object)
            }, failure: failure)
    }

    /**
    POST	lists/destroy

    Deletes the specified list. The authenticated user must own the list to be able to destroy it.
    */
    public func postListsDestroy(forId listID: String, success: ((list: Dictionary<String, JSON>?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/destroy.json"

        var parameters = Dictionary<String, Any>()
        parameters["list_id"] = listID

        self.postJSON(path: path, baseURL: .api, parameters: parameters, success: { json, _ in
            success?(list: json.object)
            }, failure: failure)
    }

    public func postListsDestroy(forSlug slug: String, owner ownerTag: UserTag, success: ((list: Dictionary<String, JSON>?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/destroy.json"

        var parameters = Dictionary<String, Any>()
        parameters["slug"] = slug
        parameters[ownerTag.ownerKey] = ownerTag.value

        self.postJSON(path: path, baseURL: .api, parameters: parameters, success: { json, _ in
            success?(list: json.object)
            }, failure: failure)
    }

    /**
    POST	lists/update

    Updates the specified list. The authenticated user must own the list to be able to update it.
    */
    public func postListsUpdate(forId listID: String, name: String?, isPublic: Bool = true, description: String?, success: ((list: Dictionary<String, JSON>?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/update.json"

        var parameters = Dictionary<String, Any>()
        parameters["list_id"] = listID
        parameters["name"] ??= name
        parameters["mode"] = isPublic ? "public" : "private"
        parameters["description"] ??= description

        self.postJSON(path: path, baseURL: .api, parameters: parameters, success: { json, _ in
            success?(list: json.object)
            }, failure: failure)
    }

    public func postListsUpdate(forSlug slug: String, owner ownerTag: UserTag, name: String?, publicMode: Bool = true, description: String?, success: ((list: Dictionary<String, JSON>?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/update.json"

        var parameters = Dictionary<String, Any>()
        parameters["slug"] = slug
        parameters[ownerTag.ownerKey] = ownerTag.value
        parameters["name"] ??= name
        parameters["mode"] = publicMode ? "public" : "private"
        parameters["description"] ??= description

        self.postJSON(path: path, baseURL: .api, parameters: parameters, success: { json, _ in
            success?(list: json.object)
            }, failure: failure)
    }
    
    /**
    POST	lists/create

    Creates a new list for the authenticated user. Note that you can't create more than 20 lists per account.
    */
    public func postListsCreate(named name: String, isPublicMode: Bool = true, description: String?, success: ((list: Dictionary<String, JSON>?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/create.json"

        var parameters = Dictionary<String, Any>()
        parameters["name"] = name
        parameters["mode"] = isPublicMode ? "public" : "private"
        parameters["description"] ??= description

        self.postJSON(path: path, baseURL: .api, parameters: parameters, success: { json, _ in
            success?(list: json.object)
            }, failure: failure)
    }

    /**
    GET	lists/show

    Returns the specified list. Private lists will only be shown if the authenticated user owns the specified list.
    */
    public func getListsShow(forId listID: String, success: ((list: Dictionary<String, JSON>?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/show.json"

        var parameters = Dictionary<String, Any>()
        parameters["list_id"] = listID

        self.getJSON(path: path, baseURL: .api, parameters: parameters, success: { json, _ in
            success?(list: json.object)
            }, failure: failure)
    }

    public func getListsShow(forSlug slug: String, owner ownerTag: UserTag, success: ((list: Dictionary<String, JSON>?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/show.json"

        var parameters = Dictionary<String, Any>()
        parameters["slug"] = slug
        parameters[ownerTag.ownerKey] = ownerTag.value

        self.getJSON(path: path, baseURL: .api, parameters: parameters, success: { json, _ in
            success?(list: json.object)
            }, failure: failure)
    }

    /**
    GET	lists/subscriptions

    Obtain a collection of the lists the specified user is subscribed to, 20 lists per page by default. Does not include the user's own lists.
    */
    public func getListsSubscriptions(for userTag: UserTag, count: String?, cursor: String?, success: ((lists: [JSON]?, previousCursor: String?, nextCursor: String?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/subscriptions.json"

        var parameters = Dictionary<String, Any>()
        parameters[userTag.key] = userTag.value
        parameters["count"] ??= count
        parameters["cursor"] ??= cursor

        self.getJSON(path: path, baseURL: .api, parameters: parameters, success: { json, _ in
            success?(lists: json["lists"].array, previousCursor: json["previous_cursor_str"].string, nextCursor: json["next_cursor_str"].string)

            }, failure: failure)
    }
    
    /**
    POST	lists/members/destroy_all

    Removes multiple members from a list, by specifying a comma-separated list of member ids or screen names. The authenticated user must own the list to be able to remove members from it. Note that lists can't have more than 500 members, and you are limited to removing up to 100 members to a list at a time with this method.

    Please note that there can be issues with lists that rapidly remove and add memberships. Take care when using these methods such that you are not too rapidly switching between removals and adds on the same list.
    */
    public func postListsMembersDestroyAll(forId listID: String, users usersTag: UsersTag, success: ((response: JSON?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/members/destroy_all.json"

        var parameters = Dictionary<String, Any>()
        parameters["list_id"] = listID
        parameters[usersTag.key] = usersTag.value

        self.postJSON(path: path, baseURL: .api, parameters: parameters, success: { json, _ in
            success?(response: json)
            }, failure: failure)
    }

    public func postListsMembersDestroyAll(forSlug slug: String, owner ownerTag: UserTag, users usersTag: UsersTag, success: ((response: JSON?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/members/destroy_all.json"

        var parameters = Dictionary<String, Any>()
        parameters["slug"] = slug
        parameters[usersTag.key] = usersTag.value
        parameters[ownerTag.ownerKey] = ownerTag.value

        self.postJSON(path: path, baseURL: .api, parameters: parameters, success: { json, _ in
            success?(response: json)
            }, failure: failure)
    }
    
    /**
    GET    lists/ownerships
    
    Returns the lists owned by the specified Twitter user. Private lists will only be shown if the authenticated user is also the owner of the lists.
    */
    public func getListsOwnerships(for userTag: UserTag, count: String?, cursor: String?, success: ((lists: [JSON]?, previousCursor: String?, nextCursor: String?) -> Void)?, failure: FailureHandler?) {
        let path = "lists/ownerships.json"
        
        var parameters = Dictionary<String, Any>()
        parameters[userTag.key] = userTag.value
        parameters["count"] ??= count
        parameters["cursor"] ??= cursor
        
        self.getJSON(path: path, baseURL: .api, parameters: parameters, success: { json, _ in            
            success?(lists: json["lists"].array, previousCursor: json["previous_cursor_str"].string, nextCursor: json["next_cursor_str"].string)

            }, failure: failure)
        
    }
    
}

private extension UserTag {
    
    var ownerKey: String {
        switch self {
        case .id:           return "owner_id"
        case .screenName:   return "owner_screen_name"
        }
    }
    
}
