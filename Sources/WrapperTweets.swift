//
//  WrapperTweets.swift
//  Swifter
//
//  Created by Zach Wolfe on 2017-07-23.
//  Copyright © 2017 Matt Donnelly. All rights reserved.
//

extension SwifterWrapper {
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
    public func getTweet(forID id: String, count: Int? = nil, trimUser: Bool? = nil, includeMyRetweet: Bool? = nil, includeEntities: Bool? = nil, success: SuccessHandler<Tweet>? = nil, failure: FailureHandler? = nil) {
        let path = "statuses/show.json"
        
        var parameters = Dictionary<String, Any>()
        parameters["id"] = id
        parameters["count"] ??= count
        parameters["trim_user"] ??= trimUser
        parameters["include_my_retweet"] ??= includeMyRetweet
        parameters["include_entities"] ??= includeEntities
        
        self.getWrapper(path: path, baseURL: .api, parameters: parameters, success: { tweet, _ in success?(tweet) }, failure: failure)
    }
}

