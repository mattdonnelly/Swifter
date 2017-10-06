//
//  SwifterGIF.swift
//  Swifter
//
//  Created by Justin Greenfield on 6/30/17.
//  Copyright © 2017 Matt Donnelly. All rights reserved.
//

import Foundation


public enum GIFterError: Error {
	case invalidData, invalidResponse
}


public extension Swifter {
	
	func tweetGIF(_ text: String, attachment: URL, success: SuccessHandler? = nil, failure: FailureHandler? = nil) {
		guard let data = try? Data(contentsOf: attachment) else { failure?(GIFterError.invalidData); return }
		prepareUpload(data: data, success: { json, response in
			if let media_id = json["media_id_string"].string {
				self.uploadGIF(media_id, data: data, name: attachment.lastPathComponent, success: { json, response in
					self.finalizeUpload(mediaId: media_id, success: { json, resoponse in
						self.postTweet(status: text, mediaIDs: [media_id], success: success, failure: failure)
					}, failure: failure)
				}, failure: failure)
			}
			else {
				failure?(GIFterError.invalidResponse)
			}
		}, failure: failure)
	}
	
	private func prepareUpload(data: Data, success: JSONSuccessHandler? = nil, failure: FailureHandler? = nil) {
		let path = "media/upload.json"
		let parameters : [String:Any] = ["command": "INIT", "total_bytes": data.count,
		                  "media_type": "image/gif", "media_category": "tweet_gif"]
		self.postJSON(path: path, baseURL: .upload, parameters: parameters, success: success, failure: failure)
	}
	
	private func finalizeUpload(mediaId: String, success: JSONSuccessHandler? = nil, failure: FailureHandler? = nil) {
		let path = "media/upload.json"
		let parameters = ["command": "FINALIZE", "media_id" : mediaId]
		self.postJSON(path: path, baseURL: .upload, parameters: parameters, success: success, failure: failure)
	}
	
	private func uploadGIF(_ mediaId: String, data: Data, name: String? = nil, success: JSONSuccessHandler? = nil, failure: FailureHandler? = nil) {
		let path = "media/upload.json"
		let parameters : [String:Any] = ["command": "APPEND", "media_id": mediaId, "segment_index": "0",
		                  Swifter.DataParameters.dataKey : "media",
		                  Swifter.DataParameters.fileNameKey: name ?? "GIFter.gif",
		                  "media": data]
		self.jsonRequest(path: path, baseURL: .upload, method: .POST, parameters: parameters, success: success, failure: failure)
	}
	
}
