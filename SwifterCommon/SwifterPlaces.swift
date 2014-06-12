//
//  SwifterPlaces.swift
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

    /*
        GET    geo/id/:place_id

        Returns all the information about a known place.
    */
    func getGeoIDWithPlaceID(placeID: String, success: JSONSuccessHandler?, failure: SwifterHTTPRequest.FailureHandler?) {
        let path = "geo/id/\(placeID).json"

        self.getJSONWithPath(path, baseURL: self.apiURL, parameters: [:], progress: nil, success: success, failure: failure)
    }

    /*
        GET    geo/reverse_geocode

        Given a latitude and a longitude, searches for up to 20 places that can be used as a place_id when updating a status.

        This request is an informative call and will deliver generalized results about geography.
    */
    func getGeoReverseGeocodeWithLat(lat: Double, long: Double, accuracy: String?, granularity: String?, maxResults: Int?, callback: String?, success: JSONSuccessHandler?, failure: SwifterHTTPRequest.FailureHandler?) {
        let path = "geo/reverse_geocode.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["lat"] = lat
        parameters["long"] = long

        if accuracy {
            parameters["accuracy"] = accuracy!
        }
        if granularity {
            parameters["granularity"] = granularity!
        }
        if maxResults {
            parameters["max_results"] = maxResults!
        }
        if callback {
            parameters["callback"] = callback!
        }

        self.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    /*
        GET    geo/search

        Search for places that can be attached to a statuses/update. Given a latitude and a longitude pair, an IP address, or a name, this request will return a list of all the valid places that can be used as the place_id when updating a status.

        Conceptually, a query can be made from the user's location, retrieve a list of places, have the user validate the location he or she is at, and then send the ID of this location with a call to POST statuses/update.

        This is the recommended method to use find places that can be attached to statuses/update. Unlike GET geo/reverse_geocode which provides raw data access, this endpoint can potentially re-order places with regards to the user who is authenticated. This approach is also preferred for interactive place matching with the user.
    */
    func getGeoSearchWithLat(lat: Double?, long: Double?, query: String?, ipAddress: String?, accuracy: String?, granularity: String?, maxResults: Int?, containedWithin: String?, attributeStreetAddress: String?, callback: String?, success: JSONSuccessHandler?, failure: SwifterHTTPRequest.FailureHandler?) {
        assert(lat || long || query || ipAddress, "At least one of the following parameters must be provided to this resource: lat, long, ipAddress, or query")

        let path = "geo/search.json"

        var parameters = Dictionary<String, AnyObject>()

        if lat {
            parameters["lat"] = lat!
        }
        if long {
            parameters["long"] = long!
        }
        if query {
            parameters["query"] = query!
        }
        if ipAddress {
            parameters["ipAddress"] = ipAddress!
        }
        if accuracy {
            parameters["accuracy"] = accuracy!
        }
        if granularity {
            parameters["granularity"] = granularity!
        }
        if maxResults {
            parameters["max_results"] = maxResults!
        }
        if containedWithin {
            parameters["contained_within"] = containedWithin!
        }
        if attributeStreetAddress {
            parameters["attribute:street_address"] = attributeStreetAddress
        }
        if callback {
            parameters["callback"] = callback!
        }

        self.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    /*
        GET    geo/similar_places

        Locates places near the given coordinates which are similar in name.

        Conceptually you would use this method to get a list of known places to choose from first. Then, if the desired place doesn't exist, make a request to POST geo/place to create a new one.

        The token contained in the response is the token needed to be able to create a new place.
    */
    func getGeoSimilarPlacesWithLat(lat: Double, long: Double, name: String, containedWithin: String?, attributeStreetAddress: String?, callback: String?, success: JSONSuccessHandler?, failure: SwifterHTTPRequest.FailureHandler?) {
        let path = "geo/similar_places.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["lat"] = lat
        parameters["long"] = long
        parameters["name"] = name

        if containedWithin {
            parameters["contained_within"] = containedWithin!
        }
        if attributeStreetAddress {
            parameters["attribute:street_address"] = attributeStreetAddress
        }
        if callback {
            parameters["callback"] = callback!
        }

        self.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    /*
        GET    trends/place

        Returns the top 10 trending topics for a specific WOEID, if trending information is available for it.

        The response is an array of "trend" objects that encode the name of the trending topic, the query parameter that can be used to search for the topic on Twitter Search, and the Twitter Search URL.

        This information is cached for 5 minutes. Requesting more frequently than that will not return any more data, and will count against your rate limit usage.
    */
    func getTrendsPlaceWithWOEID(id: Int, excludeHashtags: Bool?, success: JSONSuccessHandler?, failure: SwifterHTTPRequest.FailureHandler?) {
        let path = "trends/place.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["id"] = id

        if excludeHashtags {
            if excludeHashtags! {
                parameters["exclude"] = "hashtags"
            }
        }

        self.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    /*
        GET    trends/available

        Returns the locations that Twitter has trending topic information for.

        The response is an array of "locations" that encode the location's WOEID and some other human-readable information such as a canonical name and country the location belongs in.

        A WOEID is a Yahoo! Where On Earth ID.
    */
    func getTrendsAvailableWithSuccess(success: JSONSuccessHandler?, failure: SwifterHTTPRequest.FailureHandler?) {
        let path = "trends/available.json"

        self.getJSONWithPath(path, baseURL: self.apiURL, parameters: [:], progress: nil, success: success, failure: failure)
    }

    /*
        GET    trends/closest

        Returns the locations that Twitter has trending topic information for, closest to a specified location.

        The response is an array of "locations" that encode the location's WOEID and some other human-readable information such as a canonical name and country the location belongs in.

        A WOEID is a Yahoo! Where On Earth ID.
    */
    func getTrendsClosestWithLat(lat: Int, long: Int, success: JSONSuccessHandler?, failure: SwifterHTTPRequest.FailureHandler?) {
        let path = "trends/closest.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["lat"] = lat
        parameters["long"] = long

        self.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

}
