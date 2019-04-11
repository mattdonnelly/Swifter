//
//  SwifterHelp.swift
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
     GET    help/configuration
     
     Returns the current configuration used by Twitter including twitter.com slugs which are not usernames, maximum photo resolutions, and t.co URL lengths.
     
     It is recommended applications request this endpoint when they are loaded, but no more than once a day.
     */
    func getHelpConfiguration(success: SuccessHandler? = nil,
                              failure: FailureHandler? = nil) {
        let path = "help/configuration.json"
        self.getJSON(path: path, baseURL: .api, parameters: [:], success: { json, _ in
            success?(json)
        }, failure: failure)
    }
    
    /**
     GET    help/languages
     
     Returns the list of languages supported by Twitter along with their ISO 639-1 code. The ISO 639-1 code is the two letter value to use if you include lang with any of your requests.
     */
    func getHelpLanguages(success: SuccessHandler? = nil,
                          failure: FailureHandler? = nil) {
        let path = "help/languages.json"
        self.getJSON(path: path, baseURL: .api, parameters: [:], success: { json, _ in
            success?(json)
        },failure: failure)
    }
    
    /**
     GET    help/privacy
     
     Returns Twitter's Privacy Policy.
     */
    func getHelpPrivacy(success: SuccessHandler? = nil,
                        failure: FailureHandler? = nil) {
        let path = "help/privacy.json"
        self.getJSON(path: path, baseURL: .api, parameters: [:], success: { json, _ in
            success?(json["privacy"])
        }, failure: failure)
    }
    
    /**
     GET    help/tos
     
     Returns the Twitter Terms of Service in the requested format. These are not the same as the Developer Rules of the Road.
     */
    func getHelpTermsOfService(success: SuccessHandler? = nil,
                               failure: FailureHandler? = nil) {
        let path = "help/tos.json"
        self.getJSON(path: path, baseURL: .api, parameters: [:], success: { json, _ in
            success?(json["tos"])
        }, failure: failure)
    }
    
    /**
     GET    application/rate_limit_status
     
     Returns the current rate limits for methods belonging to the specified resource families.
     
     Each 1.1 API resource belongs to a "resource family" which is indicated in its method documentation. You can typically determine a method's resource family from the first component of the path after the resource version.
     
     This method responds with a map of methods belonging to the families specified by the resources parameter, the current remaining uses for each of those resources within the current rate limiting window, and its expiration time in epoch time. It also includes a rate_limit_context field that indicates the current access token or application-only authentication context.
     
     You may also issue requests to this method without any parameters to receive a map of all rate limited GET methods. If your application only uses a few of methods, please explicitly provide a resources parameter with the specified resource families you work with.
     
     When using app-only auth, this method's response indicates the app-only auth rate limiting context.
     
     Read more about REST API Rate Limiting in v1.1 and review the limits.
     */
    func getRateLimits(for resources: [String],
                       success: SuccessHandler? = nil,
                       failure: FailureHandler? = nil) {
        let path = "application/rate_limit_status.json"
        let parameters = ["resources": resources.joined(separator: ",")]
        self.getJSON(path: path, baseURL: .api, parameters: parameters, success: { json, _ in
            success?(json)
        }, failure: failure)
    }
    
}
