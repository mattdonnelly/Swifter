//
//  WrapperTweet.swift
//  Swifter
//
//  Created by Zach Wolfe on 2017-05-18.
//  Copyright © 2017 Matt Donnelly. All rights reserved.
//

import Foundation

public final class SwifterTweet: SwifterObject {
    public let text: String
    public let user: SwifterUser
    public let entities: SwifterEntities
    public let retweetedStatus: SwifterTweet?
    
    init(
        text: String,
        user: SwifterUser,
        entities: SwifterEntities,
        retweetedStatus: SwifterTweet? = nil)
    {
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
