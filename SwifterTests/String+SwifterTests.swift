//
//  String+SwifterTests.swift
//  Swifter
//
//  Created by Lewis Smith on 20/02/2016.
//  Copyright © 2016 Matt Donnelly. All rights reserved.
//

import XCTest

@testable import SwifteriOS

class String_SwifterTests: XCTestCase {
    
    
    override func setUp() {

        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testEncoding() {
        
        let shouldBeTheSameAfterEncoding = [
            "a": "a",
            "a a": "a%20a",
            ".": ".",
            "[": "[",
            "]": "]",
            "'": "%27",
            "$": "%24",
            "&": "%26",
            "<": "%3C",
            ">": "%3E",
            "?": "%3F",
            ";": "%3B",
            "#": "%23",
            ":": "%3A",
            "=": "%3D",
            ",": "%2C",
            "\"": "%22",
            "+": "%2B",
            "%":  "%25",
            ":/?&=;+!@# ()',*": "%3A%2F%3F%26%3D%3B%2B%21%40%23%20%28%29%27%2C%2A",
            "http://a?a=[a,b]": "http%3A%2F%2Fa%3Fa%3D[a%2Cb]"
        ]
        
        let shouldBeDifferentAfterEcoding = [
            "a": "b",
            "a a": "a a",
            "$": "$"
        ]
        
        for (input, output) in shouldBeTheSameAfterEncoding {
            XCTAssertEqual(input.urlEncodedStringWithEncoding(), output, input)
        }

        
        for (input, output) in shouldBeDifferentAfterEcoding {
            XCTAssertNotEqual(input.urlEncodedStringWithEncoding(), output)
        }
    }


}
