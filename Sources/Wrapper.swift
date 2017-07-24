//
//  Wrapper.swift
//  Swifter
//
//  Created by Zach Wolfe on 2017-07-23.
//  Copyright © 2017 Matt Donnelly. All rights reserved.
//

import Foundation

extension Swifter {
    
    // MARK: - Types
    
    typealias Object = Decodable
    
    public typealias WrapperSuccessHandler<T: Object> = (T) -> Void
    public typealias WrapperCursorSuccessHandler<T: Object> = (T, _ previousCursor: String?, _ nextCursor: String?) -> Void
    public typealias WrapperJSONSuccessHandler<T: Object> = (T, _ response: HTTPURLResponse) -> Void
    
    // MARK: - Wrapper Requests
    
    //TODO: Implement download progress handlers
    @discardableResult
    internal func wrapperRequest<T: Object>(path: String, baseURL: TwitterURL, method: HTTPMethodType, parameters: Dictionary<String, Any>, uploadProgress: HTTPRequest.UploadProgressHandler? = nil, /*downloadProgress: ((DownloadProgressData<T>, HTTPURLResponse) -> Void)? = nil,*/ success: WrapperJSONSuccessHandler<T>? = nil, failure: HTTPRequest.FailureHandler? = nil) -> HTTPRequest {
        /*
         let jsonDownloadProgressHandler: HTTPRequest.DownloadProgressHandler = { data, _, _, response in
         
         guard downloadProgress != nil else { return }
         
         guard let jsonResult = try? JSON.parse(jsonData: data) else {
         let jsonString = String(data: data, encoding: .utf8)
         let jsonChunks = jsonString!.components(separatedBy: "\r\n")
         
         for chunk in jsonChunks where !chunk.utf16.isEmpty {
         guard let chunkData = chunk.data(using: .utf8), let jsonResult = try? JSON.parse(jsonData: chunkData) else { continue }
         downloadProgress?(jsonResult, response)
         }
         return
         }
         
         downloadProgress?(jsonResult, response)
         }*/
        
        let jsonSuccessHandler: HTTPRequest.SuccessHandler = { data, response in
            DispatchQueue.global(qos: .utility).async {
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(T.self, from: data)
                    DispatchQueue.main.async {
                        success?(result, response)
                    }
                } catch {
                    DispatchQueue.main.async {
                        failure?(error)
                    }
                }
            }
        }
        
        if method == .POST {
            return self.client.get(path, baseURL: baseURL, parameters: parameters, uploadProgress: uploadProgress, downloadProgress: nil, success: jsonSuccessHandler, failure: failure)
        } else {
            return self.client.post(path, baseURL: baseURL, parameters: parameters, uploadProgress: uploadProgress, downloadProgress: nil, success: jsonSuccessHandler, failure: failure)
        }
    }
    
    @discardableResult
    internal func getWrapper<T: Object>(path: String, baseURL: TwitterURL, parameters: Dictionary<String, Any>, uploadProgress: HTTPRequest.UploadProgressHandler? = nil, /*downloadProgress: JSONSuccessHandler? = nil,*/ success: WrapperJSONSuccessHandler<T>?, failure: HTTPRequest.FailureHandler?) -> HTTPRequest {
        return self.wrapperRequest(path: path, baseURL: baseURL, method: .GET, parameters: parameters, uploadProgress: uploadProgress, success: success, failure: failure)
    }
    
    @discardableResult
    internal func postWrapper<T: Object>(path: String, baseURL: TwitterURL, parameters: Dictionary<String, Any>, uploadProgress: HTTPRequest.UploadProgressHandler? = nil, /*downloadProgress: JSONSuccessHandler? = nil,*/ success: WrapperJSONSuccessHandler<T>?, failure: HTTPRequest.FailureHandler?) -> HTTPRequest {
        return self.wrapperRequest(path: path, baseURL: baseURL, method: .POST, parameters: parameters, uploadProgress: uploadProgress, success: success, failure: failure)
    }
}
