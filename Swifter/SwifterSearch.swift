//
//  SwifterSearch.swift
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

    //	GET		search/tweets
    public func getSearchTweetsWithQuery(q: String, geocode: String?, lang: String?, locale: String?, resultType: String?, count: Int?, until: String?, sinceID: Int?, maxID: Int?, includeEntities: Bool?, callback: String?, success: ((statuses: [JSONValue]?, searchMetadata: Dictionary<String, JSONValue>?) -> Void)?, failure: FailureHandler) {
        let path = "search/tweets.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["q"] = q

        if geocode {
            parameters["geocode"] = geocode!
        }
        if lang {
            parameters["lang"] = lang!
        }
        if locale {
            parameters["locale"] = locale!
        }
        if resultType {
            parameters["result_type"] = resultType!
        }
        if count {
            parameters["count"] = count!
        }
        if until {
            parameters["until"] = until!
        }
        if sinceID {
            parameters["since_id"] = sinceID!
        }
        if maxID {
            parameters["max_id"] = maxID!
        }
        if includeEntities {
            parameters["include_entities"] = includeEntities!
        }
        if callback {
            parameters["callback"] = callback!
        }

        self.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, uploadProgress: nil, downloadProgress: nil, success: {
            json, response in

            switch (json["statuses"].array, json["search_metadata"].object) {
            case (let statuses, let searchMetadata):
                success?(statuses: statuses, searchMetadata: searchMetadata)
            default:
                success?(statuses: nil, searchMetadata: nil)
            }

            }, failure: failure)
    }
    
}
