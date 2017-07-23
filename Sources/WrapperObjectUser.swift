//
//  WrapperObjectUser.swift
//  Swifter
//
//  Created by Zach Wolfe on 2017-05-18.
//  Copyright © 2017 Matt Donnelly. All rights reserved.
//

import Foundation

extension SwifterWrapper {
    public struct User: Object {
        public let profileImageURL: URL
        public let profileImageURLHTTPS: URL
        public let name: String
        public let screenName: String
    
        enum CodingKeys: String, CodingKey {
            case profileImageURL = "profile_image_url"
            case profileImageURLHTTPS = "profile_image_url_https"
            case name = "name"
            case screenName = "screen_name"
        }
    }
}
