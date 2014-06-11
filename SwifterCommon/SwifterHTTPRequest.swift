//
//  SwifterHTTPRequest.swift
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

#if os(iOS)
    import UIKit
#else
    import AppKit
#endif

class SwifterHTTPRequest: NSObject, NSURLConnectionDataDelegate {

    typealias DownloadProgressHandler = (data: NSData, totalBytesReceived: Int, totalBytesExpectedToReceive: Int, response: NSHTTPURLResponse) -> Void
    typealias RequestSuccessHandler = (body: String, response: NSHTTPURLResponse) -> Void
    typealias DataRequestSuccessHandler = (data: NSData, response: NSHTTPURLResponse) -> Void
    typealias RequestFailureHandler = (error: NSError) -> Void

    var URL: NSURL
    var HTTPMethod: String

    var request: NSMutableURLRequest?
    var connection: NSURLConnection!

    var headers: Dictionary<String, String>
    var parameters: Dictionary<String, AnyObject>
    var postData: NSData?

    var dataEncoding: NSStringEncoding
    var timeoutInterval: NSTimeInterval
    var HTTPShouldHandleCookies: Bool

    var response: NSHTTPURLResponse!
    var responseData: NSMutableData

    var downloadRequestProgressHandler: DownloadProgressHandler?
    var requestSuccessHandler: RequestSuccessHandler?
    var dataRequestSuccessHandler: DataRequestSuccessHandler?
    var requestFailureHandler: RequestFailureHandler?

    convenience init(URL: NSURL) {
        self.init(URL: URL, method: "GET", parameters: [:])
    }

    init(URL: NSURL, method: String, parameters: Dictionary<String, AnyObject>) {
        self.URL = URL
        self.HTTPMethod = method
        self.headers = [:]
        self.parameters = parameters
        self.dataEncoding = NSUTF8StringEncoding
        self.timeoutInterval = 60
        self.HTTPShouldHandleCookies = false
        self.responseData = NSMutableData()
    }

    init(request: NSURLRequest) {
        self.request = request as? NSMutableURLRequest
        self.URL = request.URL
        self.HTTPMethod = request.HTTPMethod
        self.headers = [:]
        self.parameters = [:]
        self.dataEncoding = NSUTF8StringEncoding
        self.timeoutInterval = 60
        self.HTTPShouldHandleCookies = false
        self.responseData = NSMutableData()
    }

    func start() {
        if !request {
            self.request = NSMutableURLRequest(URL: self.URL)
            self.request!.HTTPMethod = self.HTTPMethod
            self.request!.timeoutInterval = self.timeoutInterval
            self.request!.HTTPShouldHandleCookies = self.HTTPShouldHandleCookies

            for (key, value) in headers {
                self.request!.setValue(value, forHTTPHeaderField: key)
            }

            let charset = CFStringConvertEncodingToIANACharSetName(CFStringConvertNSStringEncodingToEncoding(self.dataEncoding))

            var nonOAuthParameters = self.parameters.filter { key, _ in !key.hasPrefix("oauth_") }

            if nonOAuthParameters.count > 0 {
                if self.HTTPMethod == "GET" || self.HTTPMethod == "HEAD" || self.HTTPMethod == "DELETE" {
                    let queryString = nonOAuthParameters.urlEncodedQueryStringWithEncoding(self.dataEncoding)
                    self.request!.URL = self.URL.URLByAppendingQueryString(queryString)
                    self.request!.setValue("application/x-www-form-urlencoded; charset=\(charset)", forHTTPHeaderField: "Content-Type")
                }
                else {
                    var error: NSError?
                    var jsonData: NSData? = NSJSONSerialization.dataWithJSONObject(nonOAuthParameters, options: nil, error: &error)

                    if error {
                        println(error!.localizedDescription)
                    }
                    else {
                        self.request!.setValue("application/json; charset=\(charset)", forHTTPHeaderField: "Content-Type")
                        self.request!.HTTPBody = jsonData!
                    }
                }
            }
        }

        dispatch_async(dispatch_get_main_queue()) {
            self.connection = NSURLConnection(request: self.request!, delegate: self)
            self.connection.start()

            #if os(iOS)
                UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            #endif
        }
    }

    func connection(connection: NSURLConnection!, didReceiveResponse response: NSURLResponse!) {
        self.response = response as? NSHTTPURLResponse

        self.responseData.length = 0
    }

    func connection(connection: NSURLConnection!, didReceiveData data: NSData!) {
        self.responseData.appendData(data)

        let expectedContentLength = Int(self.response!.expectedContentLength)
        let totalBytesReceived = self.responseData.length

        if data {
            self.downloadRequestProgressHandler?(data: data, totalBytesReceived: totalBytesReceived, totalBytesExpectedToReceive: expectedContentLength, response: self.response)
        }
    }

    func connection(connection: NSURLConnection!, didFailWithError error: NSError!) {
        #if os(iOS)
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        #endif

        self.requestFailureHandler?(error: error)
    }

    func connectionDidFinishLoading(connection: NSURLConnection!) {
        #if os(iOS)
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        #endif

        if self.response.statusCode >= 400 {
            let responseString = NSString(data: self.responseData, encoding: self.dataEncoding)
            let localizedDescription = SwifterHTTPRequest.descriptionForHTTPStatus(self.response.statusCode, responseString: responseString)
            let userInfo = [NSLocalizedDescriptionKey: localizedDescription, "Response-Headers": self.response.allHeaderFields]
            let error = NSError(domain: NSURLErrorDomain, code: self.response.statusCode, userInfo: userInfo)
            self.requestFailureHandler?(error: error)
            return
        }

        self.dataRequestSuccessHandler?(data: self.responseData, response: self.response)

        let responseString = SwifterHTTPRequest.stringWithData(self.responseData, encodingName: self.response.textEncodingName)
        self.requestSuccessHandler?(body: responseString, response: self.response)
    }

    class func stringWithData(data: NSData, encodingName: String?) -> String {
        var encoding: UInt = NSUTF8StringEncoding

        if encodingName {
            let encodingNameString = encodingName!.bridgeToObjectiveC() as CFStringRef
            encoding = CFStringConvertEncodingToNSStringEncoding(CFStringConvertIANACharSetNameToEncoding(encodingNameString))

            if encoding == UInt(kCFStringEncodingInvalidId) {
                encoding = NSUTF8StringEncoding; // by default
            }
        }

        return NSString(data: data, encoding: encoding)
    }

    class func descriptionForHTTPStatus(status: Int, responseString: String) -> String {
        var s = "HTTP Status \(status)"

        var description: String?
        // http://www.iana.org/assignments/http-status-codes/http-status-codes.xhtml
        if status == 400 { description = "Bad Request" }
        if status == 401 { description = "Unauthorized" }
        if status == 402 { description = "Payment Required" }
        if status == 403 { description = "Forbidden" }
        if status == 404 { description = "Not Found" }
        if status == 405 { description = "Method Not Allowed" }
        if status == 406 { description = "Not Acceptable" }
        if status == 407 { description = "Proxy Authentication Required" }
        if status == 408 { description = "Request Timeout" }
        if status == 409 { description = "Conflict" }
        if status == 410 { description = "Gone" }
        if status == 411 { description = "Length Required" }
        if status == 412 { description = "Precondition Failed" }
        if status == 413 { description = "Payload Too Large" }
        if status == 414 { description = "URI Too Long" }
        if status == 415 { description = "Unsupported Media Type" }
        if status == 416 { description = "Requested Range Not Satisfiable" }
        if status == 417 { description = "Expectation Failed" }
        if status == 422 { description = "Unprocessable Entity" }
        if status == 423 { description = "Locked" }
        if status == 424 { description = "Failed Dependency" }
        if status == 425 { description = "Unassigned" }
        if status == 426 { description = "Upgrade Required" }
        if status == 427 { description = "Unassigned" }
        if status == 428 { description = "Precondition Required" }
        if status == 429 { description = "Too Many Requests" }
        if status == 430 { description = "Unassigned" }
        if status == 431 { description = "Request Header Fields Too Large" }
        if status == 432 { description = "Unassigned" }
        if status == 500 { description = "Internal Server Error" }
        if status == 501 { description = "Not Implemented" }
        if status == 502 { description = "Bad Gateway" }
        if status == 503 { description = "Service Unavailable" }
        if status == 504 { description = "Gateway Timeout" }
        if status == 505 { description = "HTTP Version Not Supported" }
        if status == 506 { description = "Variant Also Negotiates" }
        if status == 507 { description = "Insufficient Storage" }
        if status == 508 { description = "Loop Detected" }
        if status == 509 { description = "Unassigned" }
        if status == 510 { description = "Not Extended" }
        if status == 511 { description = "Network Authentication Required" }
        
        if description {
            s = s + ": " + description! + ", Response: " + responseString
        }
        
        return s
    }

}
