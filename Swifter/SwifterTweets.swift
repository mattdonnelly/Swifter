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

public extension Swifter {

    /**
    GET    statuses/retweets/:id

    Returns up to 100 of the first retweets of a given tweet.
    */
    public func getStatusesRetweetsWithID(id: String, count: Int? = nil, trimUser: Bool? = nil, success: ((statuses: [JSONValue]?) -> Void)? = nil, failure: FailureHandler? = nil) {
        let path = "statuses/retweets/\(id).json"

        var parameters = Dictionary<String, Any>()
        parameters["count"] ??= count
        parameters["trim_user"] ??= trimUser

        self.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(statuses: json.array)
            }, failure: failure)
    }

    /**
    GET    statuses/show/:id

    Returns a single Tweet, specified by the id parameter. The Tweet's author will also be embedded within the tweet.

    See Embeddable Timelines, Embeddable Tweets, and GET statuses/oembed for tools to render Tweets according to Display Requirements.

    # About Geo

    If there is no geotag for a status, then there will be an empty <geo/> or "geo" : {}. This can only be populated if the user has used the Geotagging API to send a statuses/update.

    The JSON response mostly uses conventions laid out in GeoJSON. Unfortunately, the coordinates that Twitter renders are reversed from the GeoJSON specification (GeoJSON specifies a longitude then a latitude, whereas we are currently representing it as a latitude then a longitude). Our JSON renders as: "geo": { "type":"Point", "coordinates":[37.78029, -122.39697] }

    # Contributors

    If there are no contributors for a Tweet, then there will be an empty or "contributors" : {}. This field will only be populated if the user has contributors enabled on his or her account -- this is a beta feature that is not yet generally available to all.

    This object contains an array of user IDs for users who have contributed to this status (an example of a status that has been contributed to is this one). In practice, there is usually only one ID in this array. The JSON renders as such "contributors":[8285392].
    */
    public func getStatusesShowWithID(id: String, count: Int? = nil, trimUser: Bool? = nil, includeMyRetweet: Bool? = nil, includeEntities: Bool? = nil, success: ((status: Dictionary<String, JSONValue>?) -> Void)? = nil, failure: FailureHandler? = nil) {
        let path = "statuses/show.json"

        var parameters = Dictionary<String, Any>()
        parameters["id"] = id
        parameters["count"] ??= count
        parameters["trim_user"] ??= trimUser
        parameters["include_my_retweet"] ??= includeMyRetweet
        parameters["include_entities"] ??= includeEntities

        self.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(status: json.object)
            }, failure: failure)
    }

    /**
    POST	statuses/destroy/:id

    Destroys the status specified by the required ID parameter. The authenticating user must be the author of the specified status. Returns the destroyed status if successful.
    */
    public func postStatusesDestroyWithID(id: String, trimUser: Bool? = nil, success: ((status: Dictionary<String, JSONValue>?) -> Void)? = nil, failure: FailureHandler? = nil) {
        let path = "statuses/destroy/\(id).json"

        var parameters = Dictionary<String, Any>()
        parameters["trim_user"] ??= trimUser

        self.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(status: json.object)
            }, failure: failure)
    }

    /**
    POST	statuses/update

    Updates the authenticating user's current status, also known as tweeting. To upload an image to accompany the tweet, use POST media/upload.

    For each update attempt, the update text is compared with the authenticating user's recent tweets. Any attempt that would result in duplication will be blocked, resulting in a 403 error. Therefore, a user cannot submit the same status twice in a row.

    While not rate limited by the API a user is limited in the number of tweets they can create at a time. If the number of updates posted by the user reaches the current allowed limit this method will return an HTTP 403 error.

    - Any geo-tagging parameters in the update will be ignored if geo_enabled for the user is false (this is the default setting for all users unless the user has enabled geolocation in their settings)
    - The number of digits passed the decimal separator passed to lat, up to 8, will be tracked so that the lat is returned in a status object it will have the same number of digits after the decimal separator.
    - Please make sure to use to use a decimal point as the separator (and not the decimal comma) for the latitude and the longitude - usage of the decimal comma will cause the geo-tagged portion of the status update to be dropped.
    - For JSON, the response mostly uses conventions described in GeoJSON. Unfortunately, the geo object has coordinates that Twitter renderers are reversed from the GeoJSON specification (GeoJSON specifies a longitude then a latitude, whereas we are currently representing it as a latitude then a longitude. Our JSON renders as: "geo": { "type":"Point", "coordinates":[37.78217, -122.40062] }
    - The coordinates object is replacing the geo object (no deprecation date has been set for the geo object yet) -- the difference is that the coordinates object, in JSON, is now rendered correctly in GeoJSON.
    - If a place_id is passed into the status update, then that place will be attached to the status. If no place_id was explicitly provided, but latitude and longitude are, we attempt to implicitly provide a place by calling geo/reverse_geocode.
    - Users will have the ability, from their settings page, to remove all the geotags from all their tweets en masse. Currently we are not doing any automatic scrubbing nor providing a method to remove geotags from individual tweets.

    See:

    - https://dev.twitter.com/notifications/multiple-media-entities-in-tweets
    - https://dev.twitter.com/docs/api/multiple-media-extended-entities
    */
    public func postStatusUpdate(status: String, inReplyToStatusID: String? = nil, lat: Double? = nil, long: Double? = nil, placeID: Double? = nil, displayCoordinates: Bool? = nil, trimUser: Bool? = nil, media_ids: [String] = [], success: ((status: Dictionary<String, JSONValue>?) -> Void)? = nil, failure: FailureHandler? = nil) {
        let path: String = "statuses/update.json"

        var parameters = Dictionary<String, Any>()
        parameters["status"] = status
        parameters["in_reply_to_status_id"] ??= inReplyToStatusID
        parameters["trim_user"] ??= trimUser
        
        if placeID != nil {
            parameters["place_id"] = placeID!
            parameters["display_coordinates"] = true
        } else if lat != nil && long != nil {
            parameters["lat"] = lat!
            parameters["long"] = long!
            parameters["display_coordinates"] = true
        }
        
        if !media_ids.isEmpty {
            parameters["media_ids"] = media_ids.joinWithSeparator(",")
        }

        self.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(status: json.object)
            }, failure: failure)
    }

    public func postStatusUpdate(status: String, media: NSData, inReplyToStatusID: String? = nil, lat: Double? = nil, long: Double? = nil, placeID: Double? = nil, displayCoordinates: Bool? = nil, trimUser: Bool? = nil, success: ((status: Dictionary<String, JSONValue>?) -> Void)? = nil, failure: FailureHandler? = nil) {
        let path: String = "statuses/update_with_media.json"

        var parameters = Dictionary<String, Any>()
        parameters["status"] = status
        parameters["media[]"] = media
        parameters[Swifter.DataParameters.dataKey] = "media[]"
        parameters["in_reply_to_status_id"] ??= inReplyToStatusID
        parameters["trim_user"] ??= trimUser
        
        if placeID != nil {
            parameters["place_id"] = placeID!
            parameters["display_coordinates"] = true
        } else if lat != nil && long != nil {
            parameters["lat"] = lat!
            parameters["long"] = long!
            parameters["display_coordinates"] = true
        }

        self.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(status: json.object)
            }, failure: failure)
    }

    /**
    POST	media/upload

    Upload media (images) to Twitter for use in a Tweet or Twitter-hosted Card. For uploading videos or for chunked image uploads (useful for lower bandwidth connections), see our chunked POST media/upload endpoint.

    See:

    - https://dev.twitter.com/rest/public/uploading-media
    - https://dev.twitter.com/rest/reference/post/media/upload
    */
    public func postMedia(media: NSData, success: ((status: Dictionary<String, JSONValue>?) -> Void)? = nil, failure: FailureHandler? = nil) {
        let path: String = "media/upload.json"
        var parameters = Dictionary<String, Any>()
        parameters["media"] = media
        parameters[Swifter.DataParameters.dataKey] = "media"

        self.postJSONWithPath(path, baseURL: self.uploadURL, parameters: parameters, success: { json, _ in
            success?(status: json.object)
            }, failure: failure)
    }

    /**
    POST	statuses/retweet/:id

    Retweets a tweet. Returns the original tweet with retweet details embedded.

    - This method is subject to update limits. A HTTP 403 will be returned if this limit as been hit.
    - Twitter will ignore attempts to perform duplicate retweets.
    - The retweet_count will be current as of when the payload is generated and may not reflect the exact count. It is intended as an approximation.

    Returns Tweets (1: the new tweet)
    */
    public func postStatusRetweetWithID(id: String, trimUser: Bool? = nil, success: ((status: Dictionary<String, JSONValue>?) -> Void)? = nil, failure: FailureHandler? = nil) {
        let path = "statuses/retweet/\(id).json"

        var parameters = Dictionary<String, Any>()
        parameters["trim_user"] ??= trimUser

        self.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(status: json.object)
            }, failure: failure)
    }
    
    /**
     POST	statuses/unretweet/:id
     
     Untweets a retweeted status. Returns the original Tweet with retweet details embedded.
     
     - This method is subject to update limits. A HTTP 429 will be returned if this limit has been hit.
     - The untweeted retweet status ID must be authored by the user backing the authentication token.
     - An application must have write privileges to POST. A HTTP 401 will be returned for read-only applications.
     - When passing a source status ID instead of the retweet status ID a HTTP 200 response will be returned with the same Tweet object but no action.
     
     Returns Tweets (1: the original tweet)
     */
    public func postStatusUnretweetWithID(id: String, trimUser: Bool? = nil, success: ((status: Dictionary<String, JSONValue>?) -> Void)? = nil, failure: FailureHandler? = nil) {
        let path = "statuses/unretweet/\(id).json"
        
        var parameters = Dictionary<String, Any>()
        parameters["trim_user"] ??= trimUser
        
        self.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(status: json.object)
            }, failure: failure)
    }

    /**
    GET    statuses/oembed

    Returns information allowing the creation of an embedded representation of a Tweet on third party sites. See the oEmbed specification for information about the response format.

    While this endpoint allows a bit of customization for the final appearance of the embedded Tweet, be aware that the appearance of the rendered Tweet may change over time to be consistent with Twitter's Display Requirements. Do not rely on any class or id parameters to stay constant in the returned markup.
    */
    public func getStatusesOEmbedWithID(id: String, maxWidth: Int? = nil, hideMedia: Bool? = nil, hideThread: Bool? = nil, omitScript: Bool? = nil, align: String? = nil, related: String? = nil, lang: String? = nil, success: ((status: Dictionary<String, JSONValue>?) -> Void)? = nil, failure: FailureHandler? = nil) {
        let path = "statuses/oembed.json"

        var parameters = Dictionary<String, Any>()
        parameters["id"] = id
        parameters["max_width"] ??= maxWidth
        parameters["hide_media"] ??= hideMedia
        parameters["hide_thread"] ??= hideThread
        parameters["omit_scipt"] ??= omitScript
        parameters["align"] ??= align
        parameters["related"] ??= related
        parameters["lang"] ??= lang

        self.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(status: json.object)
            }, failure: failure)
    }

    public func getStatusesOEmbedWithURL(url: NSURL, maxWidth: Int? = nil, hideMedia: Bool? = nil, hideThread: Bool? = nil, omitScript: Bool? = nil, align: String? = nil, related: String? = nil, lang: String? = nil, success: ((status: Dictionary<String, JSONValue>?) -> Void)? = nil, failure: FailureHandler? = nil) {
        let path = "statuses/oembed.json"

        var parameters = Dictionary<String, Any>()
        parameters["url"] = url.absoluteString
        parameters["max_width"] ??= maxWidth
        parameters["hide_media"] ??= hideMedia
        parameters["hide_thread"] ??= hideThread
        parameters["omit_scipt"] ??= omitScript
        parameters["align"] ??= align
        parameters["related"] ??= related
        parameters["lang"] ??= lang

        self.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(status: json.object)
            }, failure: failure)
    }

    /**
    GET    statuses/retweeters/ids

    Returns a collection of up to 100 user IDs belonging to users who have retweeted the tweet specified by the id parameter.

    This method offers similar data to GET statuses/retweets/:id and replaces API v1's GET statuses/:id/retweeted_by/ids method.
    */
    public func getStatusesRetweetersWithID(id: String, cursor: String? = nil, stringifyIDs: Bool? = nil, success: ((ids: [JSONValue]?, previousCursor: String?, nextCursor: String?) -> Void)? = nil, failure: FailureHandler? = nil) {
        let path = "statuses/retweeters/ids.json"

        var parameters = Dictionary<String, Any>()
        parameters["id"] = id
        parameters["cursor"] ??= cursor
        parameters["stringify_ids"] ??= stringifyIDs

        self.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(ids: json["ids"].array, previousCursor: json["previous_cursor_str"].string, nextCursor: json["next_cursor_str"].string)
            }, failure: failure)
    }

    /**
    GET statuses/lookup

    Returns fully-hydrated tweet objects for up to 100 tweets per request, as specified by comma-separated values passed to the id parameter. This method is especially useful to get the details (hydrate) a collection of Tweet IDs. GET statuses/show/:id is used to retrieve a single tweet object.
    */
    public func getStatusesLookupTweetIDs(tweetIDs: [String], includeEntities: Bool? = nil, map: Bool? = nil, success: ((statuses: [JSONValue]?) -> Void)? = nil, failure: FailureHandler? = nil) {
        let path = "statuses/lookup.json"

        var parameters = Dictionary<String, Any>()
        parameters["id"] = tweetIDs.joinWithSeparator(",")
        parameters["include_entities"] ??= includeEntities
        parameters["map"] ??= map
        
        self.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(statuses: json.array)
            }, failure: failure)
    }
    
}
