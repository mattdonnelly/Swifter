//
//  WrapperObjectPostMediaResponse.swift
//  Swifter
//
//  Created by Zach Wolfe on 2017-07-24.
//  Copyright © 2017 Matt Donnelly. All rights reserved.
//

extension Swifter {
    public struct PostMediaResponse: Object {
        public let mediaID: UInt64
        public let mediaIDString: String
        public let size: Int
        public let expiresAfterSecs: Int
        public let image: Image
        
        enum CodingKeys: String, CodingKey {
            case mediaID = "media_id"
            case mediaIDString = "media_id_string"
            case size
            case expiresAfterSecs = "expires_after_secs"
            case image
        }
        
        public struct Image: Object {
            public let imageType: String
            public let w: Int
            public let h: Int
            
            enum CodingKeys: String, CodingKey {
                case imageType = "image_type"
                case w, h
            }
        }
    }
}
