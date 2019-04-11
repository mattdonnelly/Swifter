//
//  SwifterGIF.swift
//  Swifter
//
//  Created by Justin Greenfield on 6/30/17.
//  Copyright © 2017 Matt Donnelly. All rights reserved.
//

import Foundation

public extension Swifter {
    
    internal func prepareUpload(data: Data, success: JSONSuccessHandler? = nil, failure: FailureHandler? = nil) {
        let path = "media/upload.json"
        let parameters: [String : Any] = [ "command": "INIT", "total_bytes": data.count,
                                           "media_type": "image/gif", "media_category": "tweet_gif"]
        self.postJSON(path: path, baseURL: .upload, parameters: parameters, success: success, failure: failure)
    }
    
    internal func finalizeUpload(mediaId: String, success: JSONSuccessHandler? = nil, failure: FailureHandler? = nil) {
        let path = "media/upload.json"
        let parameters = ["command": "FINALIZE", "media_id" : mediaId]
        self.postJSON(path: path, baseURL: .upload, parameters: parameters, success: success, failure: failure)
    }
    
    internal func uploadGIF(_ mediaId: String, data: Data, name: String? = nil, success: JSONSuccessHandler? = nil, failure: FailureHandler? = nil) {
        let path = "media/upload.json"
        let parameters : [String:Any] = ["command": "APPEND", "media_id": mediaId, "segment_index": "0",
                                         Swifter.DataParameters.dataKey : "media",
                                         Swifter.DataParameters.fileNameKey: name ?? "GIFter.gif",
                                         "media": data]
        self.jsonRequest(path: path, baseURL: .upload, method: .POST, parameters: parameters, success: success, failure: failure)
    }
    
}
