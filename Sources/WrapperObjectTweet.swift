//
//  WrapperObjectTweet.swift
//  Swifter
//
//  Created by Zach Wolfe on 2017-05-18.
//  Copyright © 2017 Matt Donnelly. All rights reserved.
//

import Foundation

extension Swifter {
    public final class Tweet: Object {
        public let text: String
        public let user: User
        public let entities: Entities
        public let id: UInt64
        public let idStr: String
        public let retweetedStatus: Tweet?
        
        init(text: String, user: User, entities: Entities, id: UInt64, idStr: String, retweetedStatus: Tweet? = nil) {
            self.text = text
            self.user = user
            self.entities = entities
            self.id = id
            self.idStr = idStr
            self.retweetedStatus = retweetedStatus
        }
        
        enum CodingKeys: String, CodingKey {
            case text, user, entities, id
            case retweetedStatus = "retweeted_status"
            case idStr = "id_str"
        }
    }
}
