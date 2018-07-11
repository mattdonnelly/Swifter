//
//  Tweet.swift
//  SwifterDemoMac
//
//  Created by Andy Liang on 2018-07-11.
//  Copyright © 2018 Matt Donnelly. All rights reserved.
//

import Cocoa

class Tweet: NSObject {
    
    // the name of the poster
    @objc dynamic let name: String
    
    // the text of the tweet
    @objc dynamic let text: String
    
    init(name: String, text: String) {
        self.name = name
        self.text = text
        super.init()
    }
    
}
