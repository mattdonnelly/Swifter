//
//  WrapperObjectTweet.swift
//  Swifter
//
//  Created by Zach Wolfe on 2017-05-18.
//  Copyright © 2017 Matt Donnelly. All rights reserved.
//

import Foundation

extension SwifterWrapper {
    public final class Tweet: Object {
        public let text: String
        public let user: User
        public let entities: Entities
        public let retweetedStatus: Tweet?
        
        init(text: String, user: User, entities: Entities, retweetedStatus: Tweet? = nil) {
            self.text = text
            self.user = user
            self.entities = entities
            self.retweetedStatus = retweetedStatus
        }
        
        enum CodingKeys: String, CodingKey {
            case text, user, entities
            case retweetedStatus = "retweeted_status"
        }
    }
}
