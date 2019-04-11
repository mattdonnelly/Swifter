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
    func getSubscribedLists(for userTag: UserTag? = nil,
                            reverse: Bool? = nil,
                            success: SuccessHandler? = nil,
                            failure: FailureHandler? = nil) {
        let path = "lists/list.json"
        
        var parameters = [String: Any]()
        parameters["reverse"] ??= reverse
        if let userTag = userTag {
            parameters[userTag.key] = userTag.value
        }
        
        self.getJSON(path: path, baseURL: .api, parameters: parameters, success: { json, _ in
            success?(json)
        }, failure: failure)
    }
    
    /**
     GET	lists/statuses
     
     Returns a timeline of tweets authored by members of the specified list. Retweets are included by default. Use the include_rts=false parameter to omit retweets. Embedded Timelines is a great way to embed list timelines on your website.
     */
    func listTweets(for listTag: ListTag,
                    sinceID: String? = nil,
                    maxID: String? = nil,
                    count: Int? = nil,
                    includeEntities: Bool? = nil,
                    includeRTs: Bool? = nil,
                    tweetMode: TweetMode = .default,
                    success: SuccessHandler? = nil,
                    failure: FailureHandler? = nil) {
        let path = "lists/statuses.json"
        
        var parameters = [String: Any]()
        parameters[listTag.key] = listTag.value
        if case .slug(_, let owner) = listTag {
            parameters[owner.ownerKey] = owner.value
        }
        parameters["since_id"] ??= sinceID
        parameters["max_id"] ??= maxID
        parameters["count"] ??= count
        parameters["include_entities"] ??= includeEntities
        parameters["include_rts"] ??= includeRTs
        parameters["tweet_mode"] ??= tweetMode.stringValue
        
        self.getJSON(path: path, baseURL: .api, parameters: parameters, success: { json, _ in
            success?(json)
        }, failure: failure)
    }
    
    /**
     POST	lists/members/destroy
     
     Removes the specified member from the list. The authenticated user must be the list's owner to remove members from the list.
     */
    func removeMemberFromList(for listTag: ListTag,
                              user userTag: UserTag,
                              success: SuccessHandler? = nil,
                              failure: FailureHandler? = nil) {
        let path = "lists/members/destroy.json"
        
        var parameters = [String: Any]()
        parameters[listTag.key] = listTag.value
        if case .slug(_, let owner) = listTag {
            parameters[owner.ownerKey] = owner.value
        }
        parameters[userTag.key] = userTag.value
        
        self.postJSON(path: path, baseURL: .api, parameters: parameters, success: { json, _ in
            success?(json)
        }, failure: failure)
    }
    
    /**
     GET    lists/memberships
     
     Returns the lists the specified user has been added to. If user_id or screen_name are not provided the memberships for the authenticating user are returned.
     */
    func getListMemberships(for userTag: UserTag,
                            count: Int? = nil,
                            cursor: String? = nil,
                            filterToOwnedLists: Bool? = nil,
                            success: CursorSuccessHandler? = nil,
                            failure: FailureHandler? = nil) {
        let path = "lists/memberships.json"
        
        var parameters = [String: Any]()
        parameters[userTag.key] = userTag.value
        parameters["count"] ??= count
        parameters["cursor"] ??= cursor
        parameters["filter_to_owned_lists"] ??= filterToOwnedLists
        
        self.getJSON(path: path, baseURL: .api, parameters: parameters, success: { json, _ in
            success?(json["lists"], json["previous_cursor_str"].string, json["next_cursor_str"].string)
        }, failure: failure)
    }
    
    /**
     GET	lists/subscribers
     
     Returns the subscribers of the specified list. Private list subscribers will only be shown if the authenticated user owns the specified list.
     */
    func getListSubscribers(for listTag: ListTag,
                            cursor: String? = nil,
                            includeEntities: Bool? = nil,
                            skipStatus: Bool? = nil,
                            success: CursorSuccessHandler? = nil,
                            failure: FailureHandler? = nil) {
        let path = "lists/subscribers.json"
        
        var parameters = [String: Any]()
        parameters[listTag.key] = listTag.value
        if case .slug(_, let owner) = listTag {
            parameters[owner.ownerKey] = owner.value
        }
        parameters["cursor"] ??= cursor
        parameters["include_entities"] ??= includeEntities
        parameters["skip_status"] ??= skipStatus
        
        self.getJSON(path: path, baseURL: .api, parameters: parameters, success: { json, _ in            
            success?(json["users"], json["previous_cursor_str"].string, json["next_cursor_str"].string)
        }, failure: failure)
    }
    
    /**
     POST	lists/subscribers/create
     
     Subscribes the authenticated user to the specified list.
     */
    func subscribeToList(for listTag: ListTag,
                         owner ownerTag: UserTag,
                         success: SuccessHandler? = nil,
                         failure: FailureHandler? = nil) {
        let path = "lists/subscribers/create.json"
        
        var parameters = [String: Any]()
        parameters[listTag.key] = listTag.value
        if case .slug(_, let owner) = listTag {
            parameters[owner.ownerKey] = owner.value
        }
        
        self.postJSON(path: path, baseURL: .api, parameters: parameters, success: { json, _ in
            success?(json)
        }, failure: failure)
    }
    
    /**
     GET	lists/subscribers/show
     
     Check if the specified user is a subscriber of the specified list. Returns the user if they are subscriber.
     */
    func checkListSubcription(of userTag: UserTag,
                              for listTag: ListTag,
                              includeEntities: Bool? = nil,
                              skipStatus: Bool? = nil,
                              success: SuccessHandler? = nil,
                              failure: FailureHandler? = nil) {
        let path = "lists/subscribers/show.json"
        
        var parameters = [String: Any]()
        parameters[listTag.key] = listTag.value
        if case .slug(_, let owner) = listTag {
            parameters[owner.ownerKey] = owner.value
        }
        
        parameters["include_entities"] ??= includeEntities
        parameters["skip_status"] ??= skipStatus
        
        self.getJSON(path: path, baseURL: .api, parameters: parameters, success: { json, _ in success?(json) }, failure: failure)
    }
    
    /**
     POST	lists/subscribers/destroy
     
     Unsubscribes the authenticated user from the specified list.
     */
    func unsubscribeFromList(for listTag: ListTag,
                             success: SuccessHandler? = nil,
                             failure: FailureHandler? = nil) {
        let path = "lists/subscribers/destroy.json"
        
        var parameters = [String: Any]()
        parameters[listTag.key] = listTag.value
        if case .slug(_, let owner) = listTag {
            parameters[owner.ownerKey] = owner.value
        }
        
        self.postJSON(path: path, baseURL: .api, parameters: parameters, success: { json, _ in
            success?(json)
        }, failure: failure)
    }
    
    /**
     POST	lists/members/create_all
     
     Adds multiple members to a list, by specifying a comma-separated list of member ids or screen names. The authenticated user must own the list to be able to add members to it. Note that lists can't have more than 5,000 members, and you are limited to adding up to 100 members to a list at a time with this method.
     
     Please note that there can be issues with lists that rapidly remove and add memberships. Take care when using these methods such that you are not too rapidly switching between removals and adds on the same list.
     */
    func subscribeUsersToList(for listTag: ListTag,
                              users usersTag: UsersTag,
                              includeEntities: Bool? = nil,
                              skipStatus: Bool? = nil,
                              success: SuccessHandler? = nil,
                              failure: FailureHandler? = nil) {
        let path = "lists/members/create_all.json"
        
        var parameters = [String: Any]()
        parameters[listTag.key] = listTag.value
        if case .slug(_, let owner) = listTag {
            parameters[owner.ownerKey] = owner.value
        }
        parameters[usersTag.key] = usersTag.value
        
        parameters["include_entities"] ??= includeEntities
        parameters["skip_status"] ??= skipStatus
        
        self.postJSON(path: path, baseURL: .api, parameters: parameters, success: { json, _ in
            success?(json)
        }, failure: failure)
    }
    
    /**
     GET	lists/members/show
     
     Check if the specified user is a member of the specified list.
     */
    func checkListMembership(of userTag: UserTag,
                             for listTag: ListTag,
                             includeEntities: Bool? = nil,
                             skipStatus: Bool? = nil,
                             success: SuccessHandler? = nil,
                             failure: FailureHandler? = nil) {
        let path = "lists/members/show.json"
        
        var parameters = [String: Any]()
        parameters[listTag.key] = listTag.value
        if case .slug(_, let owner) = listTag {
            parameters[owner.ownerKey] = owner.value
        }
        parameters[userTag.key] = userTag.value
        parameters["include_entities"] ??= includeEntities
        parameters["skip_status"] ??= skipStatus
        
        self.getJSON(path: path, baseURL: .api, parameters: parameters, success: { json, _ in
            success?(json)
        }, failure: failure)
    }
    
    /**
     GET    lists/members
     
     Returns the members of the specified list. Private list members will only be shown if the authenticated user owns the specified list.
     */
    
    func getListMembers(for listTag: ListTag,
                        cursor: String? = nil,
                        includeEntities: Bool? = nil,
                        skipStatus: Bool? = nil,
                        success: CursorSuccessHandler? = nil,
                        failure: FailureHandler? = nil) {
        let path = "lists/members.json"
        
        var parameters = [String: Any]()
        parameters[listTag.key] = listTag.value
        if case .slug(_, let owner) = listTag {
            parameters[owner.ownerKey] = owner.value
        }
        parameters["cursor"] ??= cursor
        parameters["include_entities"] ??= includeEntities
        parameters["skip_status"] ??= skipStatus
        
        self.getJSON(path: path, baseURL: .api, parameters: parameters, success: { json, _ in
            success?(json["users"], json["previous_cursor_str"].string, json["next_cursor_str"].string)
        }, failure: failure)
    }
    
    /**
     POST	lists/members/create
     
     Add a member to a list. The authenticated user must own the list to be able to add members to it. Note that lists cannot have more than 5,000 members.
     */
    func addListMember(_ userTag: UserTag,
                       to listTag: ListTag,
                       success: SuccessHandler? = nil,
                       failure: FailureHandler? = nil) {
        let path = "lists/members/create.json"
        
        var parameters = [String: Any]()
        parameters[listTag.key] = listTag.value
        if case .slug(_, let owner) = listTag {
            parameters[owner.ownerKey] = owner.value
        }
        parameters[userTag.key] = userTag.value
        
        self.postJSON(path: path, baseURL: .api, parameters: parameters, success: { json, _ in success?(json) }, failure: failure)
    }
    
    /**
     POST	lists/destroy
     
     Deletes the specified list. The authenticated user must own the list to be able to destroy it.
     */
    func deleteList(for listTag: ListTag,
                    success: SuccessHandler? = nil,
                    failure: FailureHandler? = nil) {
        let path = "lists/destroy.json"
        
        var parameters = [String: Any]()
        parameters[listTag.key] = listTag.value
        if case .slug(_, let owner) = listTag {
            parameters[owner.ownerKey] = owner.value
        }
        
        self.postJSON(path: path, baseURL: .api, parameters: parameters, success: { json, _ in
            success?(json)
        }, failure: failure)
    }
    
    /**
     POST	lists/update
     
     Updates the specified list. The authenticated user must own the list to be able to update it.
     */
    func updateList(for listTag: ListTag,
                    name: String? = nil,
                    isPublic: Bool = true,
                    description: String? = nil,
                    success: SuccessHandler? = nil,
                    failure: FailureHandler? = nil) {
        let path = "lists/update.json"
        
        var parameters = [String: Any]()
        parameters[listTag.key] = listTag.value
        if case .slug(_, let owner) = listTag {
            parameters[owner.ownerKey] = owner.value
        }
        parameters["name"] ??= name
        parameters["mode"] = isPublic ? "public" : "private"
        parameters["description"] ??= description
        
        self.postJSON(path: path, baseURL: .api, parameters: parameters, success: { json, _ in success?(json) }, failure: failure)
    }
    
    /**
     POST	lists/create
     
     Creates a new list for the authenticated user. Note that you can't create more than 20 lists per account.
     */
    func createList(named name: String,
                    asPublicList: Bool = true,
                    description: String? = nil,
                    success: SuccessHandler? = nil,
                    failure: FailureHandler? = nil) {
        let path = "lists/create.json"
        
        var parameters = [String: Any]()
        parameters["name"] = name
        parameters["mode"] = asPublicList ? "public" : "private"
        parameters["description"] ??= description
        
        self.postJSON(path: path, baseURL: .api, parameters: parameters, success: { json, _ in
            success?(json)
        }, failure: failure)
    }
    
    /**
     GET	lists/show
     
     Returns the specified list. Private lists will only be shown if the authenticated user owns the specified list.
     */
    func showList(for listTag: ListTag,
                  success: SuccessHandler? = nil,
                  failure: FailureHandler? = nil) {
        let path = "lists/show.json"
        
        var parameters = [String: Any]()
        parameters[listTag.key] = listTag.value
        if case .slug(_, let owner) = listTag {
            parameters[owner.ownerKey] = owner.value
        }
        
        self.getJSON(path: path, baseURL: .api, parameters: parameters, success: { json, _ in
            success?(json)
        }, failure: failure)
    }
    
    /**
     GET	lists/subscriptions
     
     Obtain a collection of the lists the specified user is subscribed to, 20 lists per page by default. Does not include the user's own lists.
     */
    func getSubscribedList(of userTag: UserTag,
                           count: String? = nil,
                           cursor: String? = nil,
                           success: CursorSuccessHandler? = nil,
                           failure: FailureHandler? = nil) {
        let path = "lists/subscriptions.json"
        
        var parameters = [String: Any]()
        parameters[userTag.key] = userTag.value
        parameters["count"] ??= count
        parameters["cursor"] ??= cursor
        
        self.getJSON(path: path, baseURL: .api, parameters: parameters, success: { json, _ in
            success?(json["lists"], json["previous_cursor_str"].string, json["next_cursor_str"].string)
        }, failure: failure)
    }
    
    /**
     POST	lists/members/destroy_all
     
     Removes multiple members from a list, by specifying a comma-separated list of member ids or screen names. The authenticated user must own the list to be able to remove members from it. Note that lists can't have more than 500 members, and you are limited to removing up to 100 members to a list at a time with this method.
     
     Please note that there can be issues with lists that rapidly remove and add memberships. Take care when using these methods such that you are not too rapidly switching between removals and adds on the same list.
     */
    func removeListMembers(_ usersTag: UsersTag,
                           from listTag: ListTag,
                           success: SuccessHandler? = nil,
                           failure: FailureHandler? = nil) {
        let path = "lists/members/destroy_all.json"
        
        var parameters = [String: Any]()
        parameters[listTag.key] = listTag.value
        if case .slug(_, let owner) = listTag {
            parameters[owner.ownerKey] = owner.value
        }
        parameters[usersTag.key] = usersTag.value
        
        self.postJSON(path: path, baseURL: .api, parameters: parameters, success: { json, _ in
            success?(json)
        }, failure: failure)
    }
    
    /**
     GET    lists/ownerships
     
     Returns the lists owned by the specified Twitter user. Private lists will only be shown if the authenticated user is also the owner of the lists.
     */
    func getOwnedLists(for userTag: UserTag,
                       count: String? = nil,
                       cursor: String? = nil,
                       success: CursorSuccessHandler? = nil,
                       failure: FailureHandler? = nil) {
        let path = "lists/ownerships.json"
        
        var parameters = [String: Any]()
        parameters[userTag.key] = userTag.value
        parameters["count"] ??= count
        parameters["cursor"] ??= cursor
        
        self.getJSON(path: path, baseURL: .api, parameters: parameters, success: { json, _ in            
            success?(json["lists"], json["previous_cursor_str"].string, json["next_cursor_str"].string)
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
