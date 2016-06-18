//
//  HTTPRequest.swift
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

public class HTTPRequest: NSObject, URLSessionDataDelegate {

    public typealias UploadProgressHandler = (bytesWritten: Int, totalBytesWritten: Int, totalBytesExpectedToWrite: Int) -> Void
    public typealias DownloadProgressHandler = (data: Data, totalBytesReceived: Int, totalBytesExpectedToReceive: Int, response: HTTPURLResponse) -> Void
    public typealias SuccessHandler = (data: Data, response: HTTPURLResponse) -> Void
    public typealias FailureHandler = (error: NSError) -> Void

    internal struct DataUpload {
        var data: Data
        var parameterName: String
        var mimeType: String?
        var fileName: String?
    }

    let url: URL
    let HTTPMethod: HTTPMethodType

    var request: URLRequest?
    var dataTask: URLSessionDataTask!

    var headers: Dictionary<String, String>
    var parameters: Dictionary<String, Any>
    var encodeParameters: Bool

    var uploadData: [DataUpload]

    var dataEncoding: String.Encoding

    var timeoutInterval: TimeInterval

    var HTTPShouldHandleCookies: Bool

    var response: HTTPURLResponse!
    var responseData: NSMutableData

    var uploadProgressHandler: UploadProgressHandler?
    var downloadProgressHandler: DownloadProgressHandler?
    var successHandler: SuccessHandler?
    var failureHandler: FailureHandler?

    public init(url: URL, method: HTTPMethodType = .GET, parameters: Dictionary<String, Any> = [:]) {
        self.url = url
        self.HTTPMethod = method
        self.headers = [:]
        self.parameters = parameters
        self.encodeParameters = false
        self.uploadData = []
        self.dataEncoding = String.Encoding.utf8
        self.timeoutInterval = 60
        self.HTTPShouldHandleCookies = false
        self.responseData = NSMutableData()
    }

    public init(request: URLRequest) {
        self.request = request
        self.url = request.url!
        self.HTTPMethod = HTTPMethodType(rawValue: request.httpMethod!)!
        self.headers = [:]
        self.parameters = [:]
        self.encodeParameters = true
        self.uploadData = []
        self.dataEncoding = String.Encoding.utf8
        self.timeoutInterval = 60
        self.HTTPShouldHandleCookies = false
        self.responseData = NSMutableData()
    }

    public func start() {
        if request == nil {
            self.request = URLRequest(url: self.url)
            self.request!.httpMethod = self.HTTPMethod.rawValue
            self.request!.timeoutInterval = self.timeoutInterval
            self.request!.httpShouldHandleCookies = self.HTTPShouldHandleCookies

            for (key, value) in headers {
                self.request!.setValue(value, forHTTPHeaderField: key)
            }

            let charset = CFStringConvertEncodingToIANACharSetName(CFStringConvertNSStringEncodingToEncoding(self.dataEncoding.rawValue))

            let nonOAuthParameters = self.parameters.filter { key, _ in !key.hasPrefix("oauth_") }

            if self.uploadData.count > 0 {
                let boundary = "----------HTTPRequestBoUnDaRy"

                let contentType = "multipart/form-data; boundary=\(boundary)"
                self.request!.setValue(contentType, forHTTPHeaderField:"Content-Type")

                let body = NSMutableData();

                for dataUpload: DataUpload in self.uploadData {
                    let multipartData = HTTPRequest.mulipartContentWithBounday(boundary, data: dataUpload.data, fileName: dataUpload.fileName, parameterName: dataUpload.parameterName, mimeType: dataUpload.mimeType)

                    body.append(multipartData)
                }

                for (key, value): (String, Any) in nonOAuthParameters {
                    body.append("\r\n--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
                    body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: String.Encoding.utf8)!)
                    body.append("\(value)".data(using: String.Encoding.utf8)!)
                }

                body.append("\r\n--\(boundary)--\r\n".data(using: String.Encoding.utf8)!)

                self.request!.setValue("\(body.length)", forHTTPHeaderField: "Content-Length")
                self.request!.httpBody = body as Data
            }
            else if nonOAuthParameters.count > 0 {
                if self.HTTPMethod == .GET || self.HTTPMethod == .HEAD || self.HTTPMethod == .DELETE {
                    let queryString = nonOAuthParameters.urlEncodedQueryStringWithEncoding(self.dataEncoding)
                    self.request!.url = self.url.appendQueryString(queryString)
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

                    if let data = queryString.data(using: self.dataEncoding) {
                        self.request!.setValue(String(data.count), forHTTPHeaderField: "Content-Length")
                        self.request!.httpBody = data
                    }
                }
            }
        }

        DispatchQueue.main.async {
            let session = URLSession(configuration: .default(), delegate: self, delegateQueue: .main())
            self.dataTask = session.dataTask(with: self.request!)
            self.dataTask.resume()
            
            
            #if os(iOS)
                UIApplication.shared().isNetworkActivityIndicatorVisible = true
            #endif
        }
    }

    public func stop() {
        self.dataTask.cancel()
    }

    public func addMultipartData(_ data: Data, parameterName: String, mimeType: String?, fileName: String?) -> Void {
        let dataUpload = DataUpload(data: data, parameterName: parameterName, mimeType: mimeType, fileName: fileName)
        self.uploadData.append(dataUpload)
    }

    private class func mulipartContentWithBounday(_ boundary: String, data: Data, fileName: String?, parameterName: String,  mimeType mimeTypeOrNil: String?) -> Data {
        let mimeType = mimeTypeOrNil ?? "application/octet-stream"

        let tempData = NSMutableData()

        tempData.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)

        let fileNameContentDisposition = fileName != nil ? "filename=\"\(fileName)\"" : ""
        let contentDisposition = "Content-Disposition: form-data; name=\"\(parameterName)\"; \(fileNameContentDisposition)\r\n"

        tempData.append(contentDisposition.data(using: String.Encoding.utf8)!)
        tempData.append("Content-Type: \(mimeType)\r\n\r\n".data(using: String.Encoding.utf8)!)
        tempData.append(data)
        tempData.append("\r\n".data(using: String.Encoding.utf8)!)

        return tempData as Data
    }

    public func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: NSError?) {
        #if os(iOS)
            UIApplication.shared().isNetworkActivityIndicatorVisible = false
        #endif

        if let error = error {
            self.failureHandler?(error: error)
            return
        }
        
        if self.response.statusCode >= 400 {
            let responseString = NSString(data: self.responseData as Data, encoding: self.dataEncoding.rawValue)
            let responseErrorCode = HTTPRequest.responseErrorCode(self.responseData as Data) ?? 0
            let localizedDescription = HTTPRequest.descriptionForHTTPStatus(self.response.statusCode, responseString: responseString! as String)
            let userInfo = [
                NSLocalizedDescriptionKey: localizedDescription,
                "Response-Headers": self.response.allHeaderFields,
                "Response-ErrorCode": responseErrorCode]
            let error = NSError(domain: NSURLErrorDomain, code: self.response.statusCode, userInfo: userInfo as [NSObject : AnyObject])
            self.failureHandler?(error: error)
            return
        }
        
        self.successHandler?(data: self.responseData as Data, response: self.response)
    }
    
    public func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        self.responseData.append(data)
        
        let expectedContentLength = Int(self.response!.expectedContentLength)
        let totalBytesReceived = self.responseData.length
        
        guard data.count > 0 else { return }
        self.downloadProgressHandler?(data: data, totalBytesReceived: totalBytesReceived, totalBytesExpectedToReceive: expectedContentLength, response: self.response)
    }
    
    public func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: (URLSession.ResponseDisposition) -> Void) {
        self.response = response as? HTTPURLResponse
        self.responseData.length = 0
        completionHandler(.allow)
    }
    
    public func urlSession(_ session: URLSession, task: URLSessionTask, didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) {
        self.uploadProgressHandler?(bytesWritten: Int(bytesSent), totalBytesWritten: Int(totalBytesSent), totalBytesExpectedToWrite: Int(totalBytesExpectedToSend))
    }

    class func responseErrorCode(_ data: Data) -> Int? {
        if let json = try? JSONSerialization.jsonObject(with: data, options: []),
            dictionary = json as? NSDictionary,
            errors = dictionary["errors"] as? [NSDictionary],
            code = errors.first?["code"] as? Int {
            return code
        }
        return nil
    }

    class func descriptionForHTTPStatus(_ status: Int, responseString: String) -> String {
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
