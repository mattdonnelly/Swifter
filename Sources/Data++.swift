//
//  NSData+OAuthSwift.swift
//  OAuthSwift
//
//  Created by Dongri Jin on 1/28/15.
//  Copyright (c) 2015 Dongri Jin. All rights reserved.
//

import Foundation


extension Data {
    
    var rawBytes: [UInt8] {
        return [UInt8](self)
    }
    
    init(bytes: [UInt8]) {
        self.init(bytes)
    }
    
}

