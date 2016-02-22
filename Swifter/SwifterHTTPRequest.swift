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

public enum HTTPMethodType: String {
    case OPTIONS
    case GET
    case HEAD
    case POST
    case PUT
    case DELETE
    case TRACE
    case CONNECT
}

public class SwifterHTTPRequest: NSObject, NSURLSessionDataDelegate {

    public typealias UploadProgressHandler = (bytesWritten: Int, totalBytesWritten: Int, totalBytesExpectedToWrite: Int) -> Void
    public typealias DownloadProgressHandler = (data: NSData, totalBytesReceived: Int, totalBytesExpectedToReceive: Int, response: NSHTTPURLResponse) -> Void
    public typealias SuccessHandler = (data: NSData, response: NSHTTPURLResponse) -> Void
    public typealias FailureHandler = (error: NSError) -> Void

    internal struct DataUpload {
        var data: NSData
        var parameterName: String
        var mimeType: String?
        var fileName: String?
    }

    let URL: NSURL
    let HTTPMethod: HTTPMethodType

    var request: NSMutableURLRequest?
    var dataTask: NSURLSessionDataTask!

    var headers: Dictionary<String, String>
    var parameters: Dictionary<String, Any>
    var encodeParameters: Bool

    var uploadData: [DataUpload]

    var dataEncoding: NSStringEncoding

    var timeoutInterval: NSTimeInterval

    var HTTPShouldHandleCookies: Bool

    var response: NSHTTPURLResponse!
    var responseData: NSMutableData

    var uploadProgressHandler: UploadProgressHandler?
    var downloadProgressHandler: DownloadProgressHandler?
    var successHandler: SuccessHandler?
    var failureHandler: FailureHandler?

    public init(URL: NSURL, method: HTTPMethodType = .GET, parameters: Dictionary<String, Any> = [:]) {
        self.URL = URL
        self.HTTPMethod = method
        self.headers = [:]
        self.parameters = parameters
        self.encodeParameters = false
        self.uploadData = []
        self.dataEncoding = NSUTF8StringEncoding
        self.timeoutInterval = 60
        self.HTTPShouldHandleCookies = false
        self.responseData = NSMutableData()
    }

    public init(request: NSURLRequest) {
        self.request = request as? NSMutableURLRequest
        self.URL = request.URL!
        self.HTTPMethod = HTTPMethodType(rawValue: request.HTTPMethod!)!
        self.headers = [:]
        self.parameters = [:]
        self.encodeParameters = true
        self.uploadData = []
        self.dataEncoding = NSUTF8StringEncoding
        self.timeoutInterval = 60
        self.HTTPShouldHandleCookies = false
        self.responseData = NSMutableData()
    }

    public func start() {
        if request == nil {
            self.request = NSMutableURLRequest(URL: self.URL)
            self.request!.HTTPMethod = self.HTTPMethod.rawValue
            self.request!.timeoutInterval = self.timeoutInterval
            self.request!.HTTPShouldHandleCookies = self.HTTPShouldHandleCookies

            for (key, value) in headers {
                self.request!.setValue(value, forHTTPHeaderField: key)
            }

            let charset = CFStringConvertEncodingToIANACharSetName(CFStringConvertNSStringEncodingToEncoding(self.dataEncoding))

            let nonOAuthParameters = self.parameters.filter { key, _ in !key.hasPrefix("oauth_") }

            if self.uploadData.count > 0 {
                let boundary = "----------SwIfTeRhTtPrEqUeStBoUnDaRy"

                let contentType = "multipart/form-data; boundary=\(boundary)"
                self.request!.setValue(contentType, forHTTPHeaderField:"Content-Type")

                let body = NSMutableData();

                for dataUpload: DataUpload in self.uploadData {
                    let multipartData = SwifterHTTPRequest.mulipartContentWithBounday(boundary, data: dataUpload.data, fileName: dataUpload.fileName, parameterName: dataUpload.parameterName, mimeType: dataUpload.mimeType)

                    body.appendData(multipartData)
                }

                for (key, value): (String, Any) in nonOAuthParameters {
                    body.appendData("\r\n--\(boundary)\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
                    body.appendData("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
                    body.appendData("\(value)".dataUsingEncoding(NSUTF8StringEncoding)!)
                }

                body.appendData("\r\n--\(boundary)--\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)

                self.request!.setValue("\(body.length)", forHTTPHeaderField: "Content-Length")
                self.request!.HTTPBody = body
            }
            else if nonOAuthParameters.count > 0 {
                if self.HTTPMethod == .GET || self.HTTPMethod == .HEAD || self.HTTPMethod == .DELETE {
                    let queryString = nonOAuthParameters.urlEncodedQueryStringWithEncoding(self.dataEncoding)
                    self.request!.URL = self.URL.appendQueryString(queryString)
                    self.request!.setValue("application/x-www-form-urlencoded; charset=\(charset)", forHTTPHeaderField: "Content-Type")
                }
                else {
                    var queryString = String()
                    if self.encodeParameters {
                        queryString = nonOAuthParameters.urlEncodedQueryStringWithEncoding(self.dataEncoding)
                        self.request!.setValue("application/x-www-form-urlencoded; charset=\(charset)", forHTTPHeaderField: "Content-Type")
                    }
                    else {
                        queryString = nonOAuthParameters.queryStringWithEncoding()
                    }

                    if let data = queryString.dataUsingEncoding(self.dataEncoding) {
                        self.request!.setValue(String(data.length), forHTTPHeaderField: "Content-Length")
                        self.request!.HTTPBody = data
                    }
                }
            }
        }

        dispatch_async(dispatch_get_main_queue()) {
            let session = NSURLSession(configuration: .defaultSessionConfiguration(), delegate: self, delegateQueue: .mainQueue())
            self.dataTask = session.dataTaskWithRequest(self.request!)
            self.dataTask.resume()
            
            #if os(iOS)
                UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            #endif
        }
    }

    public func stop() {
        self.dataTask.cancel()
    }

    public func addMultipartData(data: NSData, parameterName: String, mimeType: String?, fileName: String?) -> Void {
        let dataUpload = DataUpload(data: data, parameterName: parameterName, mimeType: mimeType, fileName: fileName)
        self.uploadData.append(dataUpload)
    }

    private class func mulipartContentWithBounday(boundary: String, data: NSData, fileName: String?, parameterName: String,  mimeType mimeTypeOrNil: String?) -> NSData {
        let mimeType = mimeTypeOrNil ?? "application/octet-stream"

        let tempData = NSMutableData()

        tempData.appendData("--\(boundary)\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)

        let fileNameContentDisposition = fileName != nil ? "filename=\"\(fileName)\"" : ""
        let contentDisposition = "Content-Disposition: form-data; name=\"\(parameterName)\"; \(fileNameContentDisposition)\r\n"

        tempData.appendData(contentDisposition.dataUsingEncoding(NSUTF8StringEncoding)!)
        tempData.appendData("Content-Type: \(mimeType)\r\n\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        tempData.appendData(data)
        tempData.appendData("\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)

        return tempData
    }

    public func URLSession(session: NSURLSession, task: NSURLSessionTask, didCompleteWithError error: NSError?) {
        #if os(iOS)
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        #endif

        if let error = error {
            self.failureHandler?(error: error)
            return
        }
        
        if self.response.statusCode >= 400 {
            let responseString = NSString(data: self.responseData, encoding: self.dataEncoding)
            let responseErrorCode = SwifterHTTPRequest.responseErrorCode(self.responseData) ?? 0
            let localizedDescription = SwifterHTTPRequest.descriptionForHTTPStatus(self.response.statusCode, responseString: responseString! as String)
            let userInfo = [
                NSLocalizedDescriptionKey: localizedDescription,
                "Response-Headers": self.response.allHeaderFields,
                "Response-ErrorCode": responseErrorCode]
            let error = NSError(domain: NSURLErrorDomain, code: self.response.statusCode, userInfo: userInfo as [NSObject : AnyObject])
            self.failureHandler?(error: error)
            return
        }
        
        self.successHandler?(data: self.responseData, response: self.response)
    }
    
    public func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, didReceiveData data: NSData) {
        self.responseData.appendData(data)
        
        let expectedContentLength = Int(self.response!.expectedContentLength)
        let totalBytesReceived = self.responseData.length
        
        guard data.length > 0 else { return }
        self.downloadProgressHandler?(data: data, totalBytesReceived: totalBytesReceived, totalBytesExpectedToReceive: expectedContentLength, response: self.response)
    }
    
    public func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, didReceiveResponse response: NSURLResponse, completionHandler: (NSURLSessionResponseDisposition) -> Void) {
        self.response = response as? NSHTTPURLResponse
        self.responseData.length = 0
        completionHandler(.Allow)
    }
    
    public func URLSession(session: NSURLSession, task: NSURLSessionTask, didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) {
        self.uploadProgressHandler?(bytesWritten: Int(bytesSent), totalBytesWritten: Int(totalBytesSent), totalBytesExpectedToWrite: Int(totalBytesExpectedToSend))
    }

    class func stringWithData(data: NSData, encodingName: String?) -> String {
        var encoding: UInt = NSUTF8StringEncoding

        if let encodingName = encodingName {
            let encodingNameString = encodingName as NSString as CFStringRef
            encoding = CFStringConvertEncodingToNSStringEncoding(CFStringConvertIANACharSetNameToEncoding(encodingNameString))

            if encoding == UInt(kCFStringEncodingInvalidId) {
                encoding = NSUTF8StringEncoding; // by default
            }
        }

        return NSString(data: data, encoding: encoding)! as String
    }

    class func responseErrorCode(data: NSData) -> Int? {
        if let json = try? NSJSONSerialization.JSONObjectWithData(data, options: []),
            dictionary = json as? NSDictionary,
            errors = dictionary["errors"] as? [NSDictionary],
            code = errors.first?["code"] as? Int {
            return code
        }
        return nil
    }

    class func descriptionForHTTPStatus(status: Int, responseString: String) -> String {
        var s = "HTTP Status \(status)"
        
        let description: String
        
        // http://www.iana.org/assignments/http-status-codes/http-status-codes.xhtml
        // https://dev.twitter.com/overview/api/response-codes
        switch(status) {
        case 400:	description = "Bad Request"
        case 401:	description = "Unauthorized"
        case 402:	description = "Payment Required"
        case 403:	description = "Forbidden"
        case 404:	description = "Not Found"
        case 405:	description = "Method Not Allowed"
        case 406:	description = "Not Acceptable"
        case 407:	description = "Proxy Authentication Required"
        case 408:	description = "Request Timeout"
        case 409:	description = "Conflict"
        case 410:	description = "Gone"
        case 411:	description = "Length Required"
        case 412:	description = "Precondition Failed"
        case 413:	description = "Payload Too Large"
        case 414:	description = "URI Too Long"
        case 415:	description = "Unsupported Media Type"
        case 416:	description = "Requested Range Not Satisfiable"
        case 417:	description = "Expectation Failed"
        case 420:	description = "Enhance Your Calm"
        case 422:	description = "Unprocessable Entity"
        case 423:	description = "Locked"
        case 424:	description = "Failed Dependency"
        case 425:	description = "Unassigned"
        case 426:	description = "Upgrade Required"
        case 427:	description = "Unassigned"
        case 428:	description = "Precondition Required"
        case 429:	description = "Too Many Requests"
        case 430:	description = "Unassigned"
        case 431:	description = "Request Header Fields Too Large"
        case 432:	description = "Unassigned"
        case 500:	description = "Internal Server Error"
        case 501:	description = "Not Implemented"
        case 502:	description = "Bad Gateway"
        case 503:	description = "Service Unavailable"
        case 504:	description = "Gateway Timeout"
        case 505:	description = "HTTP Version Not Supported"
        case 506:	description = "Variant Also Negotiates"
        case 507:	description = "Insufficient Storage"
        case 508:	description = "Loop Detected"
        case 509:	description = "Unassigned"
        case 510:	description = "Not Extended"
        case 511:	description = "Network Authentication Required"
        default:    description = ""
        }
        
        if !description.isEmpty {
            s = s + ": " + description + ", Response: " + responseString
        }
        
        return s
    }
}
