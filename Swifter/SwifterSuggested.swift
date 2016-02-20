//
//  SwifterSuggested.swift
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
    GET    users/suggestions/:slug

    Access the users in a given category of the Twitter suggested user list.

    It is recommended that applications cache this data for no more than one hour.
    */
    public func getUsersSuggestionsWithSlug(slug: String, lang: String? = nil, success: ((users: [JSONValue]?) -> Void)? = nil, failure: FailureHandler? = nil) {
        let path = "users/suggestions/\(slug).json"

        var parameters = Dictionary<String, Any>()
        parameters["lang"] ??= lang

        self.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(users: json.array)
            }, failure: failure)
    }

    /*
    GET    users/suggestions

    Access to Twitter's suggested user list. This returns the list of suggested user categories. The category can be used in GET users/suggestions/:slug to get the users in that category.
    */
    public func getUsersSuggestionsWithLang(lang: String? = nil, success: ((users: [JSONValue]?) -> Void)? = nil, failure: FailureHandler? = nil) {
        let path = "users/suggestions.json"

        var parameters = Dictionary<String, Any>()
        parameters["lang"] ??= lang

        self.getJSONWithPath(path, baseURL: self.apiURL, parameters: parameters, success: { json, _ in
            success?(users: json.array)
            }, failure: failure)
    }

    /*
    GET    users/suggestions/:slug/members

    Access the users in a given category of the Twitter suggested user list and return their most recent status if they are not a protected user.
    */
    public func getUsersSuggestionsForSlugMembers(slug: String, success: ((users: [JSONValue]?) -> Void)? = nil, failure: FailureHandler? = nil) {
        let path = "users/suggestions/\(slug)/members.json"

        self.getJSONWithPath(path, baseURL: self.apiURL, parameters: [:], success: { json, _ in
            success?(users: json.array)
            }, failure: failure)
    }
    
}
