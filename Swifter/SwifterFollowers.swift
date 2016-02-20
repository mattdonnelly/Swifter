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

public extension Swifter {

    /*
    GET    friendships/no_retweets/ids

    Returns a collection of user_ids that the currently authenticated user does not want to receive retweets from. Use POST friendships/update to set the "no retweets" status for a given user account on behalf of the current user.
    */
    public func getFriendshipsNoRetweetsIDsWithStringifyIDs(stringifyIDs: Bool = true, success: ((ids: [JSONValue]?) -> Void)? = nil, failure: FailureHandler? = nil) {
        let path = "friendships/no_retweets/ids.json"

        var parameters = Dictionary<String, Any>()
        parameters["stringify_ids"] = stringifyIDs

        self.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(ids: json.array)
            }, failure: failure)
    }

    /*
    GET    friends/ids
    Returns Users (*: user IDs for followees)

    Returns a cursored collection of user IDs for every user the specified user is following (otherwise known as their "friends").

    At this time, results are ordered with the most recent following first — however, this ordering is subject to unannounced change and eventual consistency issues. Results are given in groups of 5,000 user IDs and multiple "pages" of results can be navigated through using the next_cursor value in subsequent requests. See Using cursors to navigate collections for more information.

    This method is especially powerful when used in conjunction with GET users/lookup, a method that allows you to convert user IDs into full user objects in bulk.
    */
    public func getFriendsIDsWithID(id: String, cursor: String? = nil, stringifyIDs: Bool? = nil, count: Int? = nil, success: ((ids: [JSONValue]?, previousCursor: String?, nextCursor: String?) -> Void)? = nil, failure: FailureHandler? = nil) {
        let path = "friends/ids.json"
        
        var parameters = Dictionary<String, Any>()
        parameters["id"] = id
        parameters["cursor"] ??= cursor
        parameters["stringify_ids"] ??= stringifyIDs
        parameters["count"] ??= count
        
        self.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(ids: json["ids"].array, previousCursor: json["previous_cursor_str"].string, nextCursor: json["next_cursor_str"].string)
            }, failure: failure)
    }
    
    public func getFriendsIDsWithScreenName(screenName: String, cursor: String? = nil, stringifyIDs: Bool? = nil, count: Int? = nil, success: ((ids: [JSONValue]?, previousCursor: String?, nextCursor: String?) -> Void)? = nil, failure: FailureHandler? = nil) {
        let path = "friends/ids.json"
        
        var parameters = Dictionary<String, Any>()
        parameters["screen_name"] = screenName
        parameters["cursor"] ??= cursor
        parameters["stringify_ids"] ??= stringifyIDs
        parameters["count"] ??= count
        
        self.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(ids: json["ids"].array, previousCursor: json["previous_cursor_str"].string, nextCursor: json["next_cursor_str"].string)
            }, failure: failure)
    }
    
    /*
    GET    followers/ids
    
    Returns a cursored collection of user IDs for every user following the specified user.
    
    At this time, results are ordered with the most recent following first — however, this ordering is subject to unannounced change and eventual consistency issues. Results are given in groups of 5,000 user IDs and multiple "pages" of results can be navigated through using the next_cursor value in subsequent requests. See Using cursors to navigate collections for more information.
    
    This method is especially powerful when used in conjunction with GET users/lookup, a method that allows you to convert user IDs into full user objects in bulk.
    */
    public func getFollowersIDsWithID(id: String, cursor: String? = nil, stringifyIDs: Bool? = nil, count: Int? = nil, success: ((ids: [JSONValue]?, previousCursor: String?, nextCursor: String?) -> Void)? = nil, failure: FailureHandler? = nil) {
        let path = "followers/ids.json"
        
        var parameters = Dictionary<String, Any>()
        parameters["id"] = id
        parameters["cursor"] ??= cursor
        parameters["stringify_ids"] ??= stringifyIDs
        parameters["count"] ??= count
        
        self.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in            
            success?(ids: json["ids"].array, previousCursor: json["previous_cursor_str"].string, nextCursor: json["next_cursor_str"].string)
            }, failure: failure)
    }
    
    public func getFollowersIDsWithScreenName(screenName: String, cursor: String? = nil, stringifyIDs: Bool? = nil, count: Int? = nil, success: ((ids: [JSONValue]?, previousCursor: String?, nextCursor: String?) -> Void)? = nil, failure: FailureHandler? = nil) {
        let path = "followers/ids.json"
        
        var parameters = Dictionary<String, Any>()
        parameters["screen_name"] = screenName
        parameters["cursor"] ??= cursor
        parameters["stringify_ids"] ??= stringifyIDs
        parameters["count"] ??= count
        
        self.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in            
            success?(ids: json["ids"].array, previousCursor: json["previous_cursor_str"].string, nextCursor: json["next_cursor_str"].string)
            }, failure: failure)
    }
    
    /*
    GET    friendships/incoming
    
    Returns a collection of numeric IDs for every user who has a pending request to follow the authenticating user.
    */
    public func getFriendshipsIncomingWithCursor(cursor: String? = nil, stringifyIDs: String? = nil, success: ((ids: [JSONValue]?, previousCursor: String?, nextCursor: String?) -> Void)? = nil, failure: FailureHandler? = nil) {
        let path = "friendships/incoming.json"
        
        var parameters = Dictionary<String, Any>()
        parameters["cursor"] ??= cursor
        parameters["stringify_ids"] ??= stringifyIDs
        
        self.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in            
            success?(ids: json["ids"].array, previousCursor: json["previous_cursor_str"].string, nextCursor: json["next_cursor_str"].string)
            }, failure: failure)
    }
    
    /*
    GET    friendships/outgoing
    
    Returns a collection of numeric IDs for every protected user for whom the authenticating user has a pending follow request.
    */
    public func getFriendshipsOutgoingWithCursor(cursor: String? = nil, stringifyIDs: String? = nil, success: ((ids: [JSONValue]?, previousCursor: String?, nextCursor: String?) -> Void)? = nil, failure: FailureHandler? = nil) {
        let path = "friendships/outgoing.json"
        
        var parameters = Dictionary<String, Any>()
        parameters["cursor"] ??= cursor
        parameters["stringify_ids"] ??= stringifyIDs
        
        self.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in            
            success?(ids: json["ids"].array, previousCursor: json["previous_cursor_str"].string, nextCursor: json["next_cursor_str"].string)
            }, failure: failure)
    }

    /*
    POST   friendships/create

    Allows the authenticating users to follow the user specified in the ID parameter.

    Returns the befriended user in the requested format when successful. Returns a string describing the failure condition when unsuccessful. If you are already friends with the user a HTTP 403 may be returned, though for performance reasons you may get a 200 OK message even if the friendship already exists.

    Actions taken in this method are asynchronous and changes will be eventually consistent.
    */
    public func postCreateFriendshipWithID(id: String, follow: Bool? = nil, success: ((user: Dictionary<String, JSONValue>?) -> Void)? = nil, failure: FailureHandler? = nil) {
        let path = "friendships/create.json"

        var parameters = Dictionary<String, Any>()
        parameters["id"] = id
        parameters["follow"] ??= follow

        self.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(user: json.object)
            }, failure: failure)
    }

    public func postCreateFriendshipWithScreenName(screenName: String, follow: Bool? = nil, success: ((user: Dictionary<String, JSONValue>?) -> Void)? = nil, failure: FailureHandler? = nil) {
        let path = "friendships/create.json"

        var parameters = Dictionary<String, Any>()
        parameters["screen_name"] = screenName
        parameters["follow"] ??= follow

        self.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(user: json.object)
            }, failure: failure)
    }

    /*
    POST	friendships/destroy

    Allows the authenticating user to unfollow the user specified in the ID parameter.

    Returns the unfollowed user in the requested format when successful. Returns a string describing the failure condition when unsuccessful.

    Actions taken in this method are asynchronous and changes will be eventually consistent.
    */
    public func postDestroyFriendshipWithID(id: String, success: ((user: Dictionary<String, JSONValue>?) -> Void)? = nil, failure: FailureHandler? = nil) {
        let path = "friendships/destroy.json"

        var parameters = Dictionary<String, Any>()
        parameters["id"] = id

        self.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(user: json.object)
            }, failure: failure)
    }

    public func postDestroyFriendshipWithScreenName(screenName: String, success: ((user: Dictionary<String, JSONValue>?) -> Void)? = nil, failure: FailureHandler? = nil) {
        let path = "friendships/destroy.json"

        var parameters = Dictionary<String, Any>()
        parameters["screen_name"] = screenName

        self.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(user: json.object)
            }, failure: failure)
    }

    /*
    POST	friendships/update

    Allows one to enable or disable retweets and device notifications from the specified user.
    */
    public func postUpdateFriendshipWithID(id: String, device: Bool? = nil, retweets: Bool? = nil, success: ((user: Dictionary<String, JSONValue>?) -> Void)? = nil, failure: FailureHandler? = nil) {
        let path = "friendships/update.json"

        var parameters = Dictionary<String, Any>()
        parameters["id"] = id
        parameters["device"] ??= device
        parameters["retweets"] ??= retweets

        self.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(user: json.object)
            }, failure: failure)
    }

    public func postUpdateFriendshipWithScreenName(screenName: String, device: Bool? = nil, retweets: Bool? = nil, success: ((user: Dictionary<String, JSONValue>?) -> Void)? = nil, failure: FailureHandler? = nil) {
        let path = "friendships/update.json"

        var parameters = Dictionary<String, Any>()
        parameters["screen_name"] = screenName
        parameters["device"] ??= device
        parameters["retweets"] ??= retweets

        self.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(user: json.object)
            }, failure: failure)
    }

    /*
    GET    friendships/show

    Returns detailed information about the relationship between two arbitrary users.
    */
    public func getFriendshipsShowWithSourceID(sourceID: String, targetID: String? = nil, orTargetScreenName targetScreenName: String? = nil, success: ((user: Dictionary<String, JSONValue>?) -> Void)? = nil, failure: FailureHandler? = nil) {
        let path = "friendships/show.json"

        var parameters = Dictionary<String, Any>()
        parameters["source_id"] = sourceID
        parameters["target_id"] ??= targetID
        parameters["targetScreenName"] ??= targetScreenName

        self.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(user: json.object)
            }, failure: failure)
    }

    public func getFriendshipsShowWithSourceScreenName(sourceScreenName: String, targetID: String? = nil, orTargetScreenName targetScreenName: String? = nil, success: ((user: Dictionary<String, JSONValue>?) -> Void)? = nil, failure: FailureHandler? = nil) {
        let path = "friendships/show.json"

        var parameters = Dictionary<String, Any>()
        parameters["source_screen_name"] = sourceScreenName
        parameters["target_id"] ??= targetID
        parameters["targetScreenName"] ??= targetScreenName

        self.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(user: json.object)
            }, failure: failure)
    }

    /*
    GET    friends/list

    Returns a cursored collection of user objects for every user the specified user is following (otherwise known as their "friends").

    At this time, results are ordered with the most recent following first — however, this ordering is subject to unannounced change and eventual consistency issues. Results are given in groups of 20 users and multiple "pages" of results can be navigated through using the next_cursor value in subsequent requests. See Using cursors to navigate collections for more information.
    */
    public func getFriendsListWithID(id: String, cursor: String? = nil, count: Int? = nil, skipStatus: Bool? = nil, includeUserEntities: Bool? = nil, success: ((users: [JSONValue]?, previousCursor: String?, nextCursor: String?) -> Void)? = nil, failure: FailureHandler? = nil) {
        let path = "friends/list.json"

        var parameters = Dictionary<String, Any>()
        parameters["id"] = id
        parameters["cursor"] ??= cursor
        parameters["count"] ??= count
        parameters["skip_status"] ??= skipStatus
        parameters["include_user_entities"] ??= includeUserEntities

        self.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(users: json["users"].array, previousCursor: json["previous_cursor_str"].string, nextCursor: json["next_cursor_str"].string)
            }, failure: failure)
    }

    public func getFriendsListWithScreenName(screenName: String, cursor: String? = nil, count: Int? = nil, skipStatus: Bool? = nil, includeUserEntities: Bool? = nil, success: ((users: [JSONValue]?, previousCursor: String?, nextCursor: String?) -> Void)? = nil, failure: FailureHandler? = nil) {
        let path = "friends/list.json"

        var parameters = Dictionary<String, Any>()
        parameters["screen_name"] = screenName
        parameters["cursor"] ??= cursor
        parameters["count"] ??= count
        parameters["skip_status"] ??= skipStatus
        parameters["include_user_entities"] ??= includeUserEntities

        self.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(users: json["users"].array, previousCursor: json["previous_cursor_str"].string, nextCursor: json["next_cursor_str"].string)

            }, failure: failure)
    }

    /*
    GET    followers/list

    Returns a cursored collection of user objects for users following the specified user.

    At this time, results are ordered with the most recent following first — however, this ordering is subject to unannounced change and eventual consistency issues. Results are given in groups of 20 users and multiple "pages" of results can be navigated through using the next_cursor value in subsequent requests. See Using cursors to navigate collections for more information.
    */
    public func getFollowersListWithID(id: String, cursor: String? = nil, count: Int? = nil, skipStatus: Bool? = nil, includeUserEntities: Bool? = nil, success: ((users: [JSONValue]?, previousCursor: String?, nextCursor: String?) -> Void)? = nil, failure: FailureHandler? = nil) {
        let path = "followers/list.json"

        var parameters = Dictionary<String, Any>()
        parameters["id"] = id
        parameters["cursor"] ??= cursor
        parameters["count"] ??= count
        parameters["skip_status"] ??= skipStatus
        parameters["include_user_entities"] ??= includeUserEntities

        self.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(users: json["users"].array, previousCursor: json["previous_cursor_str"].string, nextCursor: json["next_cursor_str"].string)
            }, failure: failure)
    }

    public func getFollowersListWithScreenName(screenName: String, cursor: String? = nil, count: Int? = nil, skipStatus: Bool? = nil, includeUserEntities: Bool? = nil, success: ((users: [JSONValue]?, previousCursor: String?, nextCursor: String?) -> Void)? = nil, failure: FailureHandler? = nil) {
        let path = "followers/list.json"

        var parameters = Dictionary<String, Any>()
        parameters["screen_name"] = screenName
        parameters["cursor"] ??= cursor
        parameters["count"] ??= count
        parameters["skip_status"] ??= skipStatus
        parameters["include_user_entities"] ??= includeUserEntities

        self.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(users: json["users"].array, previousCursor: json["previous_cursor_str"].string, nextCursor: json["next_cursor_str"].string)
            }, failure: failure)
    }

    /*
    GET    friendships/lookup

    Returns the relationships of the authenticating user to the comma-separated list of up to 100 screen_names or user_ids provided. Values for connections can be: following, following_requested, followed_by, none.
    */
    public func getFriendshipsLookupWithScreenNames(screenNames: [String], success: ((friendships: [JSONValue]?) -> Void)? = nil, failure: FailureHandler?) {
        let path = "friendships/lookup.json"

        var parameters = Dictionary<String, Any>()
        parameters["screen_name"] = screenNames.joinWithSeparator(",")

        self.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in            
            success?(friendships: json.array)
            }, failure: failure)
    }
    
    public func getFriendshipsLookupWithIDs(ids: [String], success: ((friendships: [JSONValue]?) -> Void)? = nil, failure: FailureHandler? = nil) {
        let path = "friendships/lookup.json"
        
        var parameters = Dictionary<String, Any>()
        parameters["user_id"] = ids.joinWithSeparator(",")
        
        self.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in            
            success?(friendships: json.array)
            }, failure: failure)
    }
    
}
