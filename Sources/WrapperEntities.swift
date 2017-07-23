//
//  WrapperEntities.swift
//  Swifter
//
//  Created by Zach Wolfe on 2017-05-18.
//  Copyright © 2017 Matt Donnelly. All rights reserved.
//

import Foundation

public struct SwifterEntities: SwifterObject {
    public let hashtags: [SwifterHashtagEntity]
    public let media: [SwifterMediaEntity]
    //let urls: [SwifterURLSEntity]
    //let userMentions: [SwifterUserMentionEntity]
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.hashtags = try
            container.decodeIfPresent([SwifterHashtagEntity].self,
                                      forKey: .hashtags)
                                     ?? []
        self.media = try container.decodeIfPresent([SwifterMediaEntity].self, forKey: .media) ?? []
    }
    
    enum CodingKeys: String, CodingKey {
        case hashtags, media
    }
}

public struct SwifterEntityIndices: SwifterObject {
    public let leading: Int
    public let trailing: Int
    
    public init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        
        // throw an error if we receive any more or less than 2 indices
        guard !container.isAtEnd else { throw EncodingError.invalidIndices }
        
            self.leading = try container.decode(Int.self)
        
        guard !container.isAtEnd else { throw EncodingError.invalidIndices }
        
            self.trailing = try container.decode(Int.self)
        
        guard container.isAtEnd else { throw EncodingError.invalidIndices }
    }

    public enum EncodingError: Error {
        case invalidIndices
    }
    
    public subscript(_ index: Int) -> Int {
        return [leading, trailing][index]
    }
}

public struct SwifterHashtagEntity: SwifterObject {
    public let indices: SwifterEntityIndices
    public let text: String
}

public struct SwifterMediaEntity: SwifterObject {
    public let indices: SwifterEntityIndices
    public let mediaURL: URL
    public let mediaURLHTTPS: URL
    public let type: MediaType
    public let sizes: Sizes
    public let id: UInt64
    public let idStr: String
    
    enum CodingKeys: String, CodingKey {
        case indices
        case mediaURL = "media_url"
        case mediaURLHTTPS = "media_url_https"
        case type, sizes, id
        case idStr = "id_str"
    }
    
    public enum MediaType: String, SwifterObject {
        case photo, video
        case multiPhotos = "multi_photos"
        case animatedGif = "animated_gif"
    }
    
    public struct Sizes: SwifterObject {
        public let medium: Size
        public let thumb: Size
        public let small: Size
        public let large: Size
        
        public struct Size: SwifterObject {
            public let w: Int
            public let h: Int
            public let resize: ResizeMethod
            
            public enum ResizeMethod: String, SwifterObject {
                case crop, fit
            }
        }
    }
}
