//
//  SwifterFavorites.swift
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

    func getFavoritesListWithUserID(userID: Int, count: Int?, sinceID: Int?, maxID: Int?, success: JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "favorites/list.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["user_id"] = userID

        if count {
            parameters["count"] = count!
        }
        if sinceID {
            parameters["since_id"] = sinceID!
        }
        if maxID {
            parameters["max_id"] = maxID!
        }

        self.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func getFavoritesListWithScreenName(screenName: String, count: Int?, sinceID: Int?, maxID: Int?, success: JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "favorites/list.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["screen_name"] = screenName

        if count {
            parameters["count"] = count!
        }
        if sinceID {
            parameters["since_id"] = sinceID!
        }
        if maxID {
            parameters["max_id"] = maxID!
        }

        self.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postDestroyFavoriteWithID(id: Int, includeEntities: Bool?, success: JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "favorites/destroy.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["id"] = id

        if includeEntities {
            parameters["include_entities"] = includeEntities!
        }

        self.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

    func postCreateFavoriteWithID(id: Int, includeEntities: Bool?, success: JSONRequestSuccessHandler?, failure: SwifterHTTPRequest.RequestFailureHandler?) {
        let path = "favorites/create.json"

        var parameters = Dictionary<String, AnyObject>()
        parameters["id"] = id

        if includeEntities {
            parameters["include_entities"] = includeEntities!
        }

        self.postJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, progress: nil, success: success, failure: failure)
    }

}
