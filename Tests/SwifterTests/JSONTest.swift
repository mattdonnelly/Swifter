//
//  JSONTest.swift
//  SwifterTests
//
//  Created by mironal on 2018/09/28.
//  Copyright © 2018年 Matt Donnelly. All rights reserved.
//

import XCTest

#if os(iOS)
@testable import SwifteriOS
#elseif os(macOS)
@testable import SwifterMac
#elseif os(Linux)
@testable import Swifter
#endif


class JSONTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    /*

     Because to forgot the escape of /, An exteption raised when parsing
     a string acquired using "String(describing: )" or "description" to JSON object.

     */
    func testFixCanNotParseStringFromDescription() throws {

        let obj:[String: String] = ["key": "this is invalid string -> \\ <-"]

        let jsonData = try JSONSerialization.data(withJSONObject: obj, options: [])

        let json = try JSON.parse(jsonData: jsonData)

        guard let data = json.description.data(using: .utf8) else {
            XCTFail()
            fatalError()
        }

        XCTAssertNoThrow(try JSONSerialization.jsonObject(with: data, options: []))
        XCTAssertEqual(try JSONSerialization.jsonObject(with: data, options: []) as! [String: String], obj)
    }
}
