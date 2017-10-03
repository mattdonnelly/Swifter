//
//  SwifterUsers.swift
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
    GET    account/settings

    Returns settings (including current trend, geo and sleep time information) for the authenticating user.
    */
    public func getAccountSettings(success: SuccessHandler? = nil, failure: FailureHandler? = nil) {
        let path = "account/settings.json"

        self.getJSON(path: path, baseURL: .api, parameters: [:], success: { json, _ in success?(json) }, failure: failure)
    }

    /**
    GET	account/verify_credentials

    Returns an HTTP 200 OK response code and a representation of the requesting user if authentication was successful; returns a 401 status code and an error message if not. Use this method to test if supplied user credentials are valid.
    */
    public func verifyAccountCredentials(includeEntities: Bool? = nil, skipStatus: Bool? = nil, success: SuccessHandler? = nil, failure: FailureHandler? = nil) {
        let path = "account/verify_credentials.json"

        var parameters = Dictionary<String, Any>()
        parameters["include_entities"] ??= includeEntities
        parameters["skip_status"] ??= skipStatus

        self.getJSON(path: path, baseURL: .api, parameters: parameters, success: { json, _ in success?(json) }, failure: failure)
    }

    /**
    POST	account/settings

    Updates the authenticating user's settings.
    */
    public func updateAccountSettings(trendLocationWOEID: String? = nil, sleepTimeEnabled: Bool? = nil, startSleepTime: Int? = nil, endSleepTime: Int? = nil, timeZone: String? = nil, lang: String? = nil, success: SuccessHandler? = nil, failure: FailureHandler? = nil) {
        assert(trendLocationWOEID != nil || sleepTimeEnabled != nil || startSleepTime != nil || endSleepTime != nil || timeZone != nil || lang != nil, "At least one or more should be provided when executing this request")

        let path = "account/settings.json"

        var parameters = Dictionary<String, Any>()
        parameters["trend_location_woeid"] ??= trendLocationWOEID
        parameters["sleep_time_enabled"] ??= sleepTimeEnabled
        parameters["start_sleep_time"] ??= startSleepTime
        parameters["end_sleep_time"] ??= endSleepTime
        parameters["time_zone"] ??= timeZone
        parameters["lang"] ??= lang

        self.postJSON(path: path, baseURL: .api, parameters: parameters, success: { json, _ in success?(json) }, failure: failure)
    }

    /**
    POST	account/update_profile

    Sets values that users are able to set under the "Account" tab of their settings page. Only the parameters specified will be updated.
    */
    public func updateUserProfile(name: String? = nil, url: String? = nil, location: String? = nil, description: String? = nil, includeEntities: Bool? = nil, skipStatus: Bool? = nil, success: SuccessHandler? = nil, failure: FailureHandler? = nil) {
        assert(name != nil || url != nil || location != nil || description != nil || includeEntities != nil || skipStatus != nil)

        let path = "account/update_profile.json"

        var parameters = Dictionary<String, Any>()
        parameters["name"] ??= name
        parameters["url"] ??= url
        parameters["location"] ??= location
        parameters["description"] ??= description
        parameters["include_entities"] ??= includeEntities
        parameters["skip_status"] ??= skipStatus
        
        self.postJSON(path: path, baseURL: .api, parameters: parameters, success: { json, _ in success?(json) }, failure: failure)
    }

    /**
    POST	account/update_profile_background_image

    Updates the authenticating user's profile background image. This method can also be used to enable or disable the profile background image. Although each parameter is marked as optional, at least one of image, tile or use must be provided when making this request.
    */
    public func updateProfileBackground(using imageData: Data, title: String? = nil, includeEntities: Bool? = nil, use: Bool? = nil, success: SuccessHandler? = nil, failure: FailureHandler? = nil) {
        assert(title != nil || use != nil, "At least one of image, tile or use must be provided when making this request")

        let path = "account/update_profile_background_image.json"

        var parameters = Dictionary<String, Any>()
        parameters["image"] = imageData.base64EncodedString(options: [])
        parameters["title"] ??= title
        parameters["include_entities"] ??= includeEntities
        parameters["use"] ??= use

        self.postJSON(path: path, baseURL: .api, parameters: parameters, success: { json, _ in success?(json) }, failure: failure)
    }

    /**
    POST	account/update_profile_colors

    Sets one or more hex values that control the color scheme of the authenticating user's profile page on twitter.com. Each parameter's value must be a valid hexidecimal value, and may be either three or six characters (ex: #fff or #ffffff).
    */
    public func updateProfileColors(backgroundColor: String? = nil, linkColor: String? = nil, sidebarBorderColor: String? = nil, sidebarFillColor: String? = nil, textColor: String? = nil, includeEntities: Bool? = nil, skipStatus: Bool? = nil, success: SuccessHandler? = nil, failure: @escaping FailureHandler) {
        let path = "account/update_profile_colors.json"

        var parameters = Dictionary<String, Any>()
        parameters["profile_background_color"] ??= backgroundColor
        parameters["profile_link_color"] ??= linkColor
        parameters["profile_sidebar_link_color"] ??= sidebarBorderColor
        parameters["profile_sidebar_fill_color"] ??= sidebarFillColor
        parameters["profile_text_color"] ??= textColor
        parameters["include_entities"] ??= includeEntities
        parameters["skip_status"] ??= skipStatus

        self.postJSON(path: path, baseURL: .api, parameters: parameters, success: { json, _ in success?(json) }, failure: failure)
    }

    /**
    POST	account/update_profile_image

    Updates the authenticating user's profile image. Note that this method expects raw multipart data, not a URL to an image.

    This method asynchronously processes the uploaded file before updating the user's profile image URL. You can either update your local cache the next time you request the user's information, or, at least 5 seconds after uploading the image, ask for the updated URL using GET users/show.
    */
    public func updateProfileImage(using imageData: Data, includeEntities: Bool? = nil, skipStatus: Bool? = nil, success: SuccessHandler? = nil, failure: FailureHandler? = nil) {
        let path = "account/update_profile_image.json"

        var parameters = Dictionary<String, Any>()
        parameters["image"] = imageData.base64EncodedString(options: [])
        parameters["include_entities"] ??= includeEntities
        parameters["skip_status"] ??= skipStatus

        self.postJSON(path: path, baseURL: .api, parameters: parameters, success: { json, _ in success?(json) }, failure: failure)
    }

    /**
    GET    blocks/list

    Returns a collection of user objects that the authenticating user is blocking.
    */
    public func getBlockedUsers(includeEntities: Bool? = nil, skipStatus: Bool? = nil, cursor: String? = nil, success: CursorSuccessHandler? = nil, failure: FailureHandler? = nil) {
        let path = "blocks/list.json"

        var parameters = Dictionary<String, Any>()
        parameters["include_entities"] ??= includeEntities
        parameters["skip_status"] ??= skipStatus
        parameters["cursor"] ??= cursor

        self.getJSON(path: path, baseURL: .api, parameters: parameters, success: { json, _ in
            success?(json["users"], json["previous_cursor_str"].string, json["next_cursor_str"].string)
            }, failure: failure)
    }

    /**
    GET    blocks/ids

    Returns an array of numeric user ids the authenticating user is blocking.
    */
    public func getBlockedUsersIDs(stringifyIDs: String? = nil, cursor: String? = nil, success: CursorSuccessHandler? = nil, failure: @escaping FailureHandler) {
        let path = "blocks/ids.json"

        var parameters = Dictionary<String, Any>()
        parameters["stringify_ids"] ??= stringifyIDs
        parameters["cursor"] ??= cursor

        self.getJSON(path: path, baseURL: .api, parameters: parameters, success: { json, _ in
            success?(json["ids"], json["previous_cursor_str"].string, json["next_cursor_str"].string)
            }, failure: failure)
    }

    /**
    POST	blocks/create

    Blocks the specified user from following the authenticating user. In addition the blocked user will not show in the authenticating users mentions or timeline (unless retweeted by another user). If a follow or friend relationship exists it is destroyed.
    */
    public func blockUser(for userTag: UserTag, includeEntities: Bool? = nil, skipStatus: Bool? = nil, success: SuccessHandler? = nil, failure: @escaping FailureHandler) {
        let path = "blocks/create.json"

        var parameters = Dictionary<String, Any>()
        parameters[userTag.key] = userTag.value
        parameters["include_entities"] ??= includeEntities
        parameters["skip_status"] ??= skipStatus

        self.postJSON(path: path, baseURL: .api, parameters: parameters, success: { json, _ in success?(json) }, failure: failure)
    }

    /**
    POST	blocks/destroy

    Un-blocks the user specified in the ID parameter for the authenticating user. Returns the un-blocked user in the requested format when successful. If relationships existed before the block was instated, they will not be restored.
    */
    public func unblockUser(for userTag: UserTag, includeEntities: Bool? = nil, skipStatus: Bool? = nil, success: SuccessHandler? = nil, failure: @escaping FailureHandler) {
        let path = "blocks/destroy.json"

        var parameters = Dictionary<String, Any>()
        parameters[userTag.key] = userTag.value
        parameters["include_entities"] ??= includeEntities
        parameters["skip_status"] ??= skipStatus

        self.postJSON(path: path, baseURL: .api, parameters: parameters, success: { json, _ in success?(json) }, failure: failure)
    }

    /**
    GET    users/lookup

    Returns fully-hydrated user objects for up to 100 users per request, as specified by comma-separated values passed to the user_id and/or screen_name parameters.

    This method is especially useful when used in conjunction with collections of user IDs returned from GET friends/ids and GET followers/ids.

    GET users/show is used to retrieve a single user object.

    There are a few things to note when using this method.

    - You must be following a protected user to be able to see their most recent status update. If you don't follow a protected user their status will be removed.
    - The order of user IDs or screen names may not match the order of users in the returned array.
    - If a requested user is unknown, suspended, or deleted, then that user will not be returned in the results list.
    - If none of your lookup criteria can be satisfied by returning a user object, a HTTP 404 will be thrown.
    - You are strongly encouraged to use a POST for larger requests.
    */
    public func lookupUsers(for usersTag: UsersTag, includeEntities: Bool? = nil, success: SuccessHandler? = nil, failure: @escaping FailureHandler) {
        let path = "users/lookup.json"

        var parameters = Dictionary<String, Any>()
        parameters[usersTag.key] = usersTag.value
        parameters["include_entities"] ??= includeEntities

        self.getJSON(path: path, baseURL: .api, parameters: parameters, success: { json, _ in success?(json) }, failure: failure)
    }

    /**
    GET    users/show

    Returns a variety of information about the user specified by the required user_id or screen_name parameter. The author's most recent Tweet will be returned inline when possible. GET users/lookup is used to retrieve a bulk collection of user objects.

    You must be following a protected user to be able to see their most recent Tweet. If you don't follow a protected user, the users Tweet will be removed. A Tweet will not always be returned in the current_status field.
    */
    public func showUser(for userTag: UserTag, includeEntities: Bool? = nil, success: SuccessHandler? = nil, failure: @escaping FailureHandler) {
        let path = "users/show.json"

        var parameters = Dictionary<String, Any>()
        parameters[userTag.key] = userTag.value
        parameters["include_entities"] ??= includeEntities

        self.getJSON(path: path, baseURL: .api, parameters: parameters, success: { json, _ in success?(json) }, failure: failure)
    }

    /**
    GET    users/search

    Provides a simple, relevance-based search interface to public user accounts on Twitter. Try querying by topical interest, full name, company name, location, or other criteria. Exact match searches are not supported.

    Only the first 1,000 matching results are available.
    */
    public func searchUsers(using query: String, page: Int?, count: Int?, includeEntities: Bool?, success: SuccessHandler? = nil, failure: @escaping FailureHandler) {
        let path = "users/search.json"

        var parameters = Dictionary<String, Any>()
        parameters["q"] = query
        parameters["page"] ??= page
        parameters["count"] ??= count
        parameters["include_entities"] ??= includeEntities

        self.getJSON(path: path, baseURL: .api, parameters: parameters, success: { json, _ in success?(json) }, failure: failure)
    }

    /**
    POST   account/remove_profile_banner

    Removes the uploaded profile banner for the authenticating user. Returns HTTP 200 upon success.
    */
    public func removeProfileBanner(success: SuccessHandler? = nil, failure: FailureHandler? = nil) {
        let path = "account/remove_profile_banner.json"

        self.postJSON(path: path, baseURL: .api, parameters: [:], success: { json, _ in success?(json) }, failure: failure)
    }

    /**
    POST    account/update_profile_banner

    Uploads a profile banner on behalf of the authenticating user. For best results, upload an <5MB image that is exactly 1252px by 626px. Images will be resized for a number of display options. Users with an uploaded profile banner will have a profile_banner_url node in their Users objects. More information about sizing variations can be found in User Profile Images and Banners and GET users/profile_banner.

    Profile banner images are processed asynchronously. The profile_banner_url and its variant sizes will not necessary be available directly after upload.

    If providing any one of the height, width, offset_left, or offset_top parameters, you must provide all of the sizing parameters.

    HTTP Response Codes
    200, 201, 202	Profile banner image succesfully uploaded
    400	Either an image was not provided or the image data could not be processed
    422	The image could not be resized or is too large.
    */
    public func updateProfileBanner(using imageData: Data, width: Int? = nil, height: Int? = nil, offsetLeft: Int? = nil, offsetTop: Int? = nil, success: SuccessHandler? = nil, failure: FailureHandler? = nil) {
        let path = "account/update_profile_banner.json"

        var parameters = Dictionary<String, Any>()
        parameters["banner"] = imageData.base64EncodedString
        parameters["width"] ??= width
        parameters["height"] ??= height
        parameters["offset_left"] ??= offsetLeft
        parameters["offset_top"] ??= offsetTop

        self.postJSON(path: path, baseURL: .api, parameters: parameters, success: { json, _ in success?(json) }, failure: failure)
    }

    /**
    GET    users/profile_banner

    Returns a map of the available size variations of the specified user's profile banner. If the user has not uploaded a profile banner, a HTTP 404 will be served instead. This method can be used instead of string manipulation on the profile_banner_url returned in user objects as described in User Profile Images and Banners.
    */
    public func getProfileBanner(for userTag: UserTag, success: SuccessHandler? = nil, failure: FailureHandler? = nil) {
        let path = "users/profile_banner.json"
        let parameters: [String: Any] = [userTag.key: userTag.value]

        self.postJSON(path: path, baseURL: .api, parameters: parameters, success: { json, _ in success?(json) }, failure: failure)
    }

    /**
    POST   mutes/users/create

    Mutes the user specified in the ID parameter for the authenticating user.

    Returns the muted user in the requested format when successful. Returns a string describing the failure condition when unsuccessful.

    Actions taken in this method are asynchronous and changes will be eventually consistent.
    */
    public func muteUser(for userTag: UserTag, success: SuccessHandler? = nil, failure: FailureHandler? = nil) {
        let path = "mutes/users/create.json"
        let parameters: [String: Any] = [userTag.key: userTag.value]

        self.postJSON(path: path, baseURL: .api, parameters: parameters, success: { json, _ in success?(json) }, failure: failure)
    }

    /**
    POST   mutes/users/destroy

    Un-mutes the user specified in the ID parameter for the authenticating user.

    Returns the unmuted user in the requested format when successful. Returns a string describing the failure condition when unsuccessful.

    Actions taken in this method are asynchronous and changes will be eventually consistent.
    */
    public func unmuteUser(for userTag: UserTag, success: SuccessHandler? = nil, failure: FailureHandler? = nil) {
        let path = "mutes/users/destroy.json"

        var parameters = Dictionary<String, Any>()
        parameters[userTag.key] = userTag.value

        self.postJSON(path: path, baseURL: .api, parameters: parameters, success: { json, _ in
            success?(json)
            }, failure: failure)
    }

    /**
    GET    mutes/users/ids

    Returns an array of numeric user ids the authenticating user has muted.
    */
    public func getMuteUsersIDs(cursor: String? = nil, success: CursorSuccessHandler? = nil, failure: FailureHandler? = nil) {
        let path = "mutes/users/ids.json"

        var parameters = Dictionary<String, Any>()
        parameters["cursor"] ??= cursor

        self.getJSON(path: path, baseURL: .api, parameters: parameters, success: { json, _ in
            success?(json["ids"], json["previous_cursor_str"].string, json["next_cursor_str"].string)
            }, failure: failure)
    }
    
    /**
    GET    mutes/users/list
    
    Returns an array of user objects the authenticating user has muted.
    */
    public func getMuteUsers(cursor: String? = nil, includeEntities: Bool? = nil, skipStatus: Bool? = nil, success: CursorSuccessHandler? = nil, failure: FailureHandler? = nil) {
        let path = "mutes/users/list.json"
        
        var parameters = Dictionary<String, Any>()
        parameters["include_entities"] ??= includeEntities
        parameters["skip_status"] ??= skipStatus
        parameters["cursor"] ??= cursor
        
        self.getJSON(path: path, baseURL: .api, parameters: parameters, success: { json, _ in
            success?(json["users"], json["previous_cursor_str"].string, json["next_cursor_str"].string)
            }, failure: failure)
    }
    
}
