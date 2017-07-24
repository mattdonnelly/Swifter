//
//  WrapperObjectRetweeters.swift
//  Swifter
//
//  Created by Zach Wolfe on 2017-07-24.
//  Copyright © 2017 Matt Donnelly. All rights reserved.
//

extension Swifter {
    public struct IDList: Object {
        public let previousCursor: Int
        public let previousCursorStr: String
        public let nextCursor: Int
        public let nextCursorStr: String
        public let ids: [UInt64]?
        public let idsStr: [String]?
        
        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            previousCursor = try container.decode(Int.self, forKey: .previousCursor)
            previousCursorStr = try container.decode(String.self, forKey: .previousCursorStr)
            nextCursor = try container.decode(Int.self, forKey: .nextCursor)
            nextCursorStr = try container.decode(String.self, forKey: .nextCursorStr)
            
            // TODO: test whether this actually does what we want, or if the existence of an incorrectly-typed `ids` will throw an error here
            ids = try container.decodeIfPresent([UInt64].self, forKey: .ids)
            idsStr = try container.decodeIfPresent([String].self, forKey: .ids)
        }
        
        enum CodingKeys: String, CodingKey {
            case previousCursor = "previous_cursor"
            case previousCursorStr = "previous_cursor_str"
            case nextCursor = "next_cursor"
            case nextCursorStr = "next_cursor_str"
            case ids
        }
    }
}
