//
//  SwifterMedia.swift
//  Swifter
//
//  Created by Takuto Nakamura on 2020/07/25.
//  Copyright © 2020 Matt Donnelly. All rights reserved.
//

import Foundation

public enum MediaType: String {
    case png = "image/png"
    case jpeg = "image/jpeg"
    case gif = "image/gif"
    case mov = "video/mov"
    case mp4 = "video/mp4"
}

public enum MediaCategory: String {
    case gif = "tweet_gif"
    case video = "tweet_video"
}

public extension Swifter {
    
    internal func prepareUpload(data: Data, type: MediaType, category: MediaCategory?, success: JSONSuccessHandler? = nil, failure: FailureHandler? = nil) {
        let path = "media/upload.json"
        var parameters: [String : Any] = ["command": "INIT",
                                          "total_bytes": data.count,
                                          "media_type": type.rawValue]
        if let cat = category {
            parameters["media_category"] = cat
        }
        self.postJSON(path: path, baseURL: .upload, parameters: parameters, success: success, failure: failure)
    }
    
    internal func appendUpload(_ mediaId: String, data: Data, name: String? = nil, index: Int = 0, success: JSONSuccessHandler? = nil, failure: FailureHandler? = nil) {
        let path = "media/upload.json"
        let chunkSize: Int = 2 * 1024 * 1024
        let location = index * chunkSize
        let length: Int = (data.count < chunkSize) ? data.count : min(data.count - location, chunkSize)
        let range: Range<Data.Index> = (location ..< location + length)
        let subData = data.subdata(in: range)
        let parameters : [String : Any] = ["command": "APPEND",
                                           "media_id": mediaId,
                                           "segment_index": index,
                                           Swifter.DataParameters.dataKey: "media",
                                           Swifter.DataParameters.fileNameKey: name ?? "Swifter.media",
                                           "media": subData]
        self.jsonRequest(path: path, baseURL: .upload, method: .POST, parameters: parameters, success: { (json, response) in
            let next = index + 1
            if data.count < next * chunkSize {
                success?(json, response)
            } else {
                self.appendUpload(mediaId, data: data, name: name, index: next, success: success, failure: failure)
            }
        }, failure: failure)
    }
    
    internal func finalizeUpload(mediaId: String, success: JSONSuccessHandler? = nil, failure: FailureHandler? = nil) {
        let path = "media/upload.json"
        let parameters = ["command": "FINALIZE",
                          "media_id": mediaId]
        self.postJSON(path: path, baseURL: .upload, parameters: parameters, success: { (json, response) in
            if let processingInfo = json["processing_info"].object, let state = processingInfo["state"]?.string {
                switch state {
                case "pending", "in_progress":
                    let secs = processingInfo["check_after_secs"]?.double ?? 3.0
                    DispatchQueue.global().asyncAfter(deadline: .now() + secs) {
                        self.finalizeUpload(mediaId: mediaId, success: success, failure: failure)
                    }
                case "succeeded":
                    success?(json, response)
                default: // includes failed
                    let error = SwifterError(message: "Bad Response for Multipart Media Upload",
                                             kind: .invalidMultipartMediaResponse)
                    failure?(error)
                }
            } else if json != nil && response.statusCode >= 200 && response.statusCode <= 299 {
                // success but with no state - use with caution!
                success?(json, response)
            } else {
                let error = SwifterError(message: "Cannot parse processing_info", kind: .jsonParseError)
                failure?(error)
            }
        }, failure: failure)
    }
    
}
