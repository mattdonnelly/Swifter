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
import CoreFoundation
import Dispatch

#if os(iOS)
    import UIKit
#elseif os(macOS)
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

    public typealias UploadProgressHandler = (_ bytesWritten: Int, _ totalBytesWritten: Int, _ totalBytesExpectedToWrite: Int) -> Void
    public typealias DownloadProgressHandler = (Data, _ totalBytesReceived: Int, _ totalBytesExpectedToReceive: Int, HTTPURLResponse) -> Void
    public typealias SuccessHandler = (Data, HTTPURLResponse) -> Void
    public typealias FailureHandler = (Error) -> Void

    internal struct DataUpload {
        var data: Data
        var parameterName: String
        var mimeType: String?
        var fileName: String?
    }

    let url: URL
    let HTTPMethod: HTTPMethodType

    var request: URLRequest?
    var dataTask: URLSessionDataTask?

    var headers: Dictionary<String, String> = [:]
    var parameters: Dictionary<String, Any>
    var encodeParameters: Bool

    var uploadData: [DataUpload] = []

    var dataEncoding: String.Encoding = .utf8

    var timeoutInterval: TimeInterval = 60

    var HTTPShouldHandleCookies: Bool = false

    var response: HTTPURLResponse!
    var responseData: Data = Data()

    var uploadProgressHandler: UploadProgressHandler?
    var downloadProgressHandler: DownloadProgressHandler?
    var successHandler: SuccessHandler?
    var failureHandler: FailureHandler?

    public init(url: URL, method: HTTPMethodType = .GET, parameters: Dictionary<String, Any> = [:]) {
        self.url = url
        self.HTTPMethod = method
        self.parameters = parameters
        self.encodeParameters = false
    }

    public init(request: URLRequest) {
        self.request = request
        self.url = request.url!
        self.HTTPMethod = HTTPMethodType(rawValue: request.httpMethod!)!
        self.parameters = [:]
        self.encodeParameters = true
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
			
            let nonOAuthParameters = self.parameters.filter { key, _ in !key.hasPrefix("oauth_") }

            if !self.uploadData.isEmpty {
                let boundary = "--" + UUID().uuidString

                let contentType = "multipart/form-data; boundary=\(boundary)"
                self.request!.setValue(contentType, forHTTPHeaderField:"Content-Type")

                var body = Data()

                for dataUpload: DataUpload in self.uploadData {
                    let multipartData = HTTPRequest.mulipartContent(with: boundary, data: dataUpload.data, fileName: dataUpload.fileName, parameterName: dataUpload.parameterName, mimeType: dataUpload.mimeType)
                    body.append(multipartData)
                }

                for (key, value): (String, Any) in nonOAuthParameters {
                    body.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
                    body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
                    body.append("\(value)".data(using: .utf8)!)
                }

                body.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)

                self.request!.setValue("\(body.count)", forHTTPHeaderField: "Content-Length")
                self.request!.httpBody = body
            } else if !nonOAuthParameters.isEmpty {
				let charset = CFStringConvertEncodingToIANACharSetName(CFStringConvertNSStringEncodingToEncoding(self.dataEncoding.rawValue))!
                if self.HTTPMethod == .GET || self.HTTPMethod == .HEAD || self.HTTPMethod == .DELETE {
                    let queryString = nonOAuthParameters.urlEncodedQueryString(using: self.dataEncoding)
                    self.request!.url = self.url.append(queryString: queryString)
                    self.request!.setValue("application/x-www-form-urlencoded; charset=\(charset)", forHTTPHeaderField: "Content-Type")
                } else {
                    var queryString = ""
                    if self.encodeParameters {
                        queryString = nonOAuthParameters.urlEncodedQueryString(using: self.dataEncoding)
                        self.request!.setValue("application/x-www-form-urlencoded; charset=\(charset)", forHTTPHeaderField: "Content-Type")
                    } else {
                        queryString = nonOAuthParameters.queryString
                    }

                    if let data = queryString.data(using: self.dataEncoding) {
                        self.request!.setValue(String(data.count), forHTTPHeaderField: "Content-Length")
                        self.request!.httpBody = data
                    }
                }
            }
        }

        DispatchQueue.main.async {
            let session = URLSession(configuration: .default, delegate: self, delegateQueue: .main)
            self.dataTask = session.dataTask(with: self.request!)
            self.dataTask?.resume()
            
            #if os(iOS)
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
            #endif
        }
    }

    public func stop() {
        self.dataTask?.cancel()
    }

    public func add(multipartData data: Data, parameterName: String, mimeType: String?, fileName: String?) -> Void {
        let dataUpload = DataUpload(data: data, parameterName: parameterName, mimeType: mimeType, fileName: fileName)
        self.uploadData.append(dataUpload)
    }

    private class func mulipartContent(with boundary: String, data: Data, fileName: String?, parameterName: String,  mimeType mimeTypeOrNil: String?) -> Data {
        let mimeType = mimeTypeOrNil ?? "application/octet-stream"
        let fileNameContentDisposition = fileName != nil ? "filename=\"\(fileName!)\"" : ""
        let contentDisposition = "Content-Disposition: form-data; name=\"\(parameterName)\"; \(fileNameContentDisposition)\r\n"
        
        var tempData = Data()
        tempData.append("--\(boundary)\r\n".data(using: .utf8)!)
        tempData.append(contentDisposition.data(using: .utf8)!)
        tempData.append("Content-Type: \(mimeType)\r\n\r\n".data(using: .utf8)!)
        tempData.append(data)
        return tempData
    }

    // MARK: - URLSessionDataDelegate
    
    public func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        #if os(iOS)
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        #endif

        defer {
          session.finishTasksAndInvalidate()
        }

        if let error = error {
            self.failureHandler?(error)
            return
        }
        
        guard self.response.statusCode >= 400 else {
            self.successHandler?(self.responseData, self.response)
            return
        }
        let responseString = String(data: responseData, encoding: dataEncoding)!
        let errorCode = HTTPRequest.responseErrorCode(for: responseData) ?? 0
        let localizedDescription = HTTPRequest.description(for: response.statusCode, response: responseString)
        
        let error = SwifterError(message: localizedDescription, kind: .urlResponseError(status: response.statusCode, headers: response.allHeaderFields, errorCode: errorCode))
        self.failureHandler?(error)
    }
    
    public func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        self.responseData.append(data)
        
        let expectedContentLength = Int(self.response!.expectedContentLength)
        let totalBytesReceived = self.responseData.count
        
        guard !data.isEmpty else { return }
        self.downloadProgressHandler?(data, totalBytesReceived, expectedContentLength, self.response)
    }
    
    public func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        self.response = response as? HTTPURLResponse
        self.responseData.count = 0
        completionHandler(.allow)
    }
    
    public func urlSession(_ session: URLSession, task: URLSessionTask, didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) {
        self.uploadProgressHandler?(Int(bytesSent), Int(totalBytesSent), Int(totalBytesExpectedToSend))
    }
    
    // MARK: - Error Responses

    class func responseErrorCode(for data: Data) -> Int? {
        guard let code = JSON(data)["errors"].array?.first?["code"].integer else {
            return nil
        }
        return code
    }

    class func description(for status: Int, response string: String) -> String {
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
            s = s + ": " + description + ", Response: " + string
        }
        
        return s
    }
}
