//
//  SwifterTrends.swift
//  Swifter
//
//  Created by Matt Donnelly on 21/06/2014.
//  Copyright (c) 2014 Matt Donnelly. All rights reserved.
//

import Foundation

public extension Swifter {

    /**
    GET    trends/place

    Returns the top 10 trending topics for a specific WOEID, if trending information is available for it.

    The response is an array of "trend" objects that encode the name of the trending topic, the query parameter that can be used to search for the topic on Twitter Search, and the Twitter Search URL.

    This information is cached for 5 minutes. Requesting more frequently than that will not return any more data, and will count against your rate limit usage.
    */
    public func getTrendsPlaceWithWOEID(_ id: String, excludeHashtags: Bool = false, success: ((trends: [JSON]?) -> Void)? = nil, failure: FailureHandler? = nil) {
        let path = "trends/place.json"

        var parameters = Dictionary<String, Any>()
        parameters["id"] = id
        parameters["exclude"] = excludeHashtags ? "hashtags" : nil
        
        self.getJSON(path: path, baseURL: TwitterURL.api, parameters: parameters, success: { json, _ in            
            success?(trends: json.array)
            }, failure: failure)
    }

    /**
    GET    trends/available

    Returns the locations that Twitter has trending topic information for.

    The response is an array of "locations" that encode the location's WOEID and some other human-readable information such as a canonical name and country the location belongs in.

    A WOEID is a Yahoo! Where On Earth ID.
    */
    public func getTrendsAvailableWithSuccess(_ success: ((trends: [JSON]?) -> Void)? = nil, failure: FailureHandler? = nil) {
        let path = "trends/available.json"

        self.getJSON(path: path, baseURL: TwitterURL.api, parameters: [:], success: { json, _ in
            success?(trends: json.array)
            }, failure: failure)
    }

    /**
    GET    trends/closest

    Returns the locations that Twitter has trending topic information for, closest to a specified location.

    The response is an array of "locations" that encode the location's WOEID and some other human-readable information such as a canonical name and country the location belongs in.

    A WOEID is a Yahoo! Where On Earth ID.
    */
    public func getTrendsClosestWithLat(_ lat: Double, long: Double, success: ((trends: [JSON]?) -> Void)? = nil, failure: FailureHandler? = nil) {
        let path = "trends/closest.json"

        var parameters = Dictionary<String, Any>()
        parameters["lat"] = lat
        parameters["long"] = long

        self.getJSON(path: path, baseURL: TwitterURL.api, parameters: parameters, success: { json, _ in
            success?(trends: json.array)
            }, failure: failure)
    }

}
