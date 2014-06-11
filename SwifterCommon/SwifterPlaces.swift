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

    func getGeoIDWithPlaceID(placeID: String, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "geo/id/\(placeID).json"

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: [:], progress: nil, success: success, failure: failure)
    }

    func getGeoReverseGeocodeWithLat(lat: Double, long: Double, accuracy: String?, granularity: String?, maxResults: Int?, callback: String?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
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

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getGeoSearchWithLat(lat: Double?, long: Double?, query: String?, ipAddress: String?, accuracy: String?, granularity: String?, maxResults: Int?, containedWithin: String?, attributeStreetAddress: String?, callback: String?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
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

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getGeoSimilarPlacesWithLat(lat: Double, long: Double, name: String, containedWithin: String?, attributeStreetAddress: String?, callback: String?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
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

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getTrendsPlaceWithWOEID(id: Int, excludeHashtags: Bool?, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "trends/place.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["id"] = id

        if excludeHashtags {
            if excludeHashtags! {
                parameters["exclude"] = "hashtags"
            }
        }

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getTrendsAvailableWithSuccess(success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "trends/available.json"

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: [:], progress: nil, success: success, failure: failure)
    }

    func getTrendsClosestWithLat(lat: Int, long: Int, success: SwifterOAuthClient.JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "trends/closest.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["lat"] = lat
        parameters["long"] = long

        self.oauthClient.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

}
