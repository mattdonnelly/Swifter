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

extension Swifter {

    func getAccountSettingsWithSuccess(success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "account/settings.json"

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: [:], progress: nil, success: success, failure: failure)
    }

    func getAccountVerifyCredentials(includeEntities: Bool?, skipStatus: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "account/verify_credentials.json"

        var parameters = Dictionary<String, AnyObject>()
        if includeEntities {
            parameters["include_entities"] = includeEntities!.bridgeToObjectiveC()
        }
        if skipStatus {
            parameters["skip_status"] = skipStatus!.bridgeToObjectiveC()
        }

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postAccountSettings(trendLocationWOEID: Int?, sleepTimeEnabled: Bool?, startSleepTime: Int?, endSleepTime: Int?, timeZone: String?, lang: String?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        assert(trendLocationWOEID || sleepTimeEnabled || startSleepTime || endSleepTime || timeZone || lang, "At least one or more should be provided when executing this request")

        let path = "account/settings.json"

        var parameters = Dictionary<String, AnyObject>()
        if trendLocationWOEID {
            parameters["trend_location_woeid"] = trendLocationWOEID!.bridgeToObjectiveC()
        }
        if sleepTimeEnabled {
            parameters["sleep_time_enabled"] = sleepTimeEnabled!.bridgeToObjectiveC()
        }
        if startSleepTime {
            parameters["start_sleep_time"] = startSleepTime!.bridgeToObjectiveC()
        }
        if endSleepTime {
            parameters["end_sleep_time"] = endSleepTime!.bridgeToObjectiveC()
        }
        if timeZone {
            parameters["time_zone"] = timeZone!.bridgeToObjectiveC()
        }
        if lang {
            parameters["lang"] = lang!.bridgeToObjectiveC()
        }

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postAccountUpdateDeliveryDeviceSMS(device: Bool, includeEntities: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "account/update_delivery_device.json"

        var parameters = Dictionary<String, AnyObject>()
        if device {
            parameters["device"] = "sms".bridgeToObjectiveC()
        }
        else {
            parameters["device"] = "none".bridgeToObjectiveC()
        }
        if includeEntities {
            parameters["include_entities"] = includeEntities!.bridgeToObjectiveC()
        }

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postAccountUpdateProfileWithName(name: String?, url: String?, location: String?, description: String?, includeEntities: Bool?, skipStatus: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        assert(name || url || location || description || includeEntities || skipStatus)

        let path = "account/update_profile.json"

        var parameters = Dictionary<String, AnyObject>()
        if name {
            parameters["name"] = name!.bridgeToObjectiveC()
        }
        if url {
            parameters["url"] = url!.bridgeToObjectiveC()
        }
        if location {
            parameters["location"] = location!.bridgeToObjectiveC()
        }
        if description {
            parameters["description"] = description!.bridgeToObjectiveC()
        }
        if includeEntities {
            parameters["include_entities"] = includeEntities!.bridgeToObjectiveC()
        }
        if skipStatus {
            parameters["skip_status"] = skipStatus!.bridgeToObjectiveC()
        }

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postAccountUpdateProfileBackgroundImage(imageData: NSData?, title: String?, includeEntities: Bool?, use: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        assert(imageData || title || use, "At least one of image, tile or use must be provided when making this request")

        let path = "account/update_profile_background_image.json"

        var parameters = Dictionary<String, AnyObject>()
        if imageData {
            parameters["image"] = imageData!.base64EncodedStringWithOptions(nil).bridgeToObjectiveC()
        }
        if title {
            parameters["title"] = title!.bridgeToObjectiveC()
        }
        if includeEntities {
            parameters["include_entities"] = includeEntities!.bridgeToObjectiveC()
        }
        if use {
            parameters["use"] = use!.bridgeToObjectiveC()
        }

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postUpdateAccountProfileColors(profileBackgroundColor: String?, profileLinkColor: String?, profileSidebarBorderColor: String?, profileSidebarFillColor: String?, profileTextColor: String?, includeEntities: Bool?, skipStatus: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler) {
        let path = "account/update_profile_colors.json"

        var parameters = Dictionary<String, AnyObject>()

        if profileBackgroundColor {
            parameters["profile_background_color"] = profileBackgroundColor!.bridgeToObjectiveC()
        }
        if profileLinkColor {
            parameters["profile_link_color"] = profileLinkColor!.bridgeToObjectiveC()
        }
        if profileSidebarBorderColor {
            parameters["profile_sidebar_link_color"] = profileSidebarBorderColor!.bridgeToObjectiveC()
        }
        if profileSidebarFillColor {
            parameters["profile_sidebar_fill_color"] = profileSidebarFillColor!.bridgeToObjectiveC()
        }
        if profileTextColor {
            parameters["profile_text_color"] = profileTextColor!.bridgeToObjectiveC()
        }
        if includeEntities {
            parameters["include_entities"] = includeEntities!.bridgeToObjectiveC()
        }
        if skipStatus {
            parameters["skip_status"] = skipStatus!.bridgeToObjectiveC()
        }

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postAccountUpdateProfileImage(imageData: NSData?, includeEntities: Bool?, skipStatus: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "account/update_profile_image.json"

        var parameters = Dictionary<String, AnyObject>()
        if imageData {
            parameters["image"] = imageData!.base64EncodedStringWithOptions(nil).bridgeToObjectiveC()
        }
        if includeEntities {
            parameters["include_entities"] = includeEntities!.bridgeToObjectiveC()
        }
        if skipStatus {
            parameters["skip_status"] = skipStatus!.bridgeToObjectiveC()
        }

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getBlockListWithIncludeEntities(includeEntities: Bool?, skipStatus: Bool?, cursor: Int?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "blocks/list.json"

        var parameters = Dictionary<String, AnyObject>()
        if includeEntities {
            parameters["include_entities"] = includeEntities!.bridgeToObjectiveC()
        }
        if skipStatus {
            parameters["skip_status"] = skipStatus!.bridgeToObjectiveC()
        }
        if cursor {
            parameters["cursor"] = cursor!.bridgeToObjectiveC()
        }

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getBlockIDsWithStingifyIDs(stringifyIDs: String?, cursor: Int?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler) {
        let path = "blocks/ids.json"

        var parameters = Dictionary<String, AnyObject>()
        if stringifyIDs {
            parameters["stringify_ids"] = stringifyIDs!.bridgeToObjectiveC()
        }
        if cursor {
            parameters["cursor"] = cursor!.bridgeToObjectiveC()
        }

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postBlocksCreateWithScreenName(screenName: String, includeEntities: Bool?, skipStatus: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler) {
        let path = "blocks/create.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["screen_name"] = screenName.bridgeToObjectiveC()

        if includeEntities {
            parameters["include_entities"] = includeEntities!.bridgeToObjectiveC()
        }
        if skipStatus {
            parameters["skip_status"] = skipStatus!.bridgeToObjectiveC()
        }

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postBlocksCreateWithUserID(userID: Int, includeEntities: Bool?, skipStatus: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler) {
        let path = "blocks/create.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["user_id"] = userID.bridgeToObjectiveC()

        if includeEntities {
            parameters["include_entities"] = includeEntities!.bridgeToObjectiveC()
        }
        if skipStatus {
            parameters["skip_status"] = skipStatus!.bridgeToObjectiveC()
        }

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postDestroyBlocksWithUserID(userID: Int, includeEntities: Bool?, skipStatus: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler) {
        let path = "blocks/destroy.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["user_id"] = userID.bridgeToObjectiveC()

        if includeEntities {
            parameters["include_entities"] = includeEntities!.bridgeToObjectiveC()
        }
        if skipStatus {
            parameters["skip_status"] = skipStatus!.bridgeToObjectiveC()
        }

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postDestroyBlocksWithScreenName(screenName: String, includeEntities: Bool?, skipStatus: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler) {
        let path = "blocks/destroy.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["screen_name"] = screenName.bridgeToObjectiveC()

        if includeEntities {
            parameters["include_entities"] = includeEntities!.bridgeToObjectiveC()
        }
        if skipStatus {
            parameters["skip_status"] = skipStatus!.bridgeToObjectiveC()
        }

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getUsersLookupWithScreenName(screenName: String, includeEntities: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler) {
        let path = "users/lookup.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["screen_name"] = screenName.bridgeToObjectiveC()

        if includeEntities {
            parameters["include_entities"] = includeEntities!.bridgeToObjectiveC()
        }

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getUsersLookupWithUserID(userID: Int, includeEntities: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler) {
        let path = "users/lookup.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["user_id"] = userID.bridgeToObjectiveC()

        if includeEntities {
            parameters["include_entities"] = includeEntities!.bridgeToObjectiveC()
        }

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getUsersShowWithScreenName(screenName: String, includeEntities: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler) {
        let path = "users/show.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["screen_name"] = screenName.bridgeToObjectiveC()

        if includeEntities {
            parameters["include_entities"] = includeEntities!.bridgeToObjectiveC()
        }

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getUsersShowWithUserID(userID: Int, includeEntities: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler) {
        let path = "users/show.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["user_id"] = userID.bridgeToObjectiveC()

        if includeEntities {
            parameters["include_entities"] = includeEntities!.bridgeToObjectiveC()
        }

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getUsersSearchWithQuery(q: String, page: Int?, count: Int?, includeEntities: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler) {
        let path = "users/search/json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["q"] = q

        if page {
            parameters["page"] = page!.bridgeToObjectiveC()
        }
        if count {
            parameters["count"] = count!.bridgeToObjectiveC()
        }
        if includeEntities {
            parameters["include_entities"] = includeEntities!.bridgeToObjectiveC()
        }

        self.oauthClient.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

}
