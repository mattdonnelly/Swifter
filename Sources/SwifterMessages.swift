//
//  SwifterMessages.swift
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
     GET direct_messages/events/show
     
     Returns a single Direct Message event by the given id.
     */
    func getDirectMessage(for messageId: String,
                          success: SuccessHandler? = nil,
                          failure: FailureHandler? = nil) {
        let path = "direct_messages/events/show.json"
        let parameters = ["id": messageId]
        self.getJSON(path: path, baseURL: .api, parameters: parameters, success: { json, _ in
            success?(json)
        }, failure: failure)
    }
    
    /**
     GET direct_messages/events/list
     
     Returns all Direct Message events (both sent and received) within the last 30 days. Sorted in reverse-chronological order.
     */
    func getDirectMessages(count: Int? = nil,
                           cursor: String? = nil,
                           success: SuccessHandler? = nil,
                           failure: FailureHandler? = nil) {
        let path = "direct_messages/events/list.json"
        var parameters: [String: Any] = [:]
        parameters["count"] ??= count
        parameters["cursor"] ??= cursor
        self.getJSON(path: path, baseURL: .api, parameters: parameters, success: { json, _ in
            success?(json)
        }, failure: failure)
    }
    
    /**
     DELETE direct_messages/events/destroy
     
     Returns all Direct Message events (both sent and received) within the last 30 days. Sorted in reverse-chronological order.
     */
    func destroyDirectMessage(for messageId: String,
                              success: SuccessHandler? = nil,
                              failure: FailureHandler? = nil) {
        let path = "direct_messages/events/destroy.json"
        let parameters = ["id": messageId]
        self.deleteJSON(path: path, baseURL: .api, parameters: parameters, success: { json, _ in
            success?(json)
        }, failure: failure)
    }
    
    /**
     POST direct_messages/events/new
     
     Publishes a new message_create event resulting in a Direct Message sent to a specified user from the authenticating user. Returns an event if successful. Supports publishing Direct Messages with optional Quick Reply and media attachment. Replaces behavior currently provided by POST direct_messages/new.
     Requires a JSON POST body and Content-Type header to be set to application/json. Setting Content-Length may also be required if it is not automatically.
     
     # Direct Message Rate Limiting
     When a message is received from a user you may send up to 5 messages in response within a 24 hour window. Each message received resets the 24 hour window and the 5 allotted messages. Sending a 6th message within a 24 hour window or sending a message outside of a 24 hour window will count towards rate-limiting. This behavior only applies when using the POST direct_messages/events/new endpoint.
     
     */
    func postDirectMessage(to recipientUserId: String,
                           message: String,
                           success: SuccessHandler? = nil,
                           failure: FailureHandler? = nil) {
        let path = "direct_messages/events/new.json"
        
        var parameters: [String: Any] = [:]
        parameters[Swifter.DataParameters.jsonDataKey] = "json-body"
        parameters["json-body"] = [
            "event": [
                "type": "message_create",
                "message_create": [
                    "target": [ "recipient_id": recipientUserId ],
                    "message_data": ["text": message ]
                ]
            ]
        ]
        
        self.postJSON(path: path, baseURL: .api, parameters: parameters, success: { json, _ in
            success?(json)
        }, failure: failure)
    }
    
}
