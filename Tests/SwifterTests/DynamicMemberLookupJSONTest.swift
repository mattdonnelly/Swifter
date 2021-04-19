//
//  DynamicMemberLookupJSONTest.swift
//  SwifterTests
//
//  Created by TOUYA KAWANO on 2021/04/20.
//  Copyright © 2021 Matt Donnelly. All rights reserved.
//


import XCTest

#if os(iOS)
@testable import SwifteriOS
#elseif os(macOS)
@testable import SwifterMac
#elseif os(Linux)
@testable import Swifter
#endif

class DynamicMemberLookupJSONTest: XCTestCase {

    func testDynamicMemberLookupJSON() throws {

        let dummyTweetObject: [String: Any] = [
            "retweeted": false,
            "is_quote_status": false,
            "created_at": "Sun Apr 18 23:54:27 +0000 2021",
            "id_str": "1383931967297650690",
            "full_text": "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
            "lang": "ja",
            "user": [
                "friends_count": 673.0,
                "geo_enabled": false,
                "profile_background_tile": false,
                "translator_type": "none",
                "profile_use_background_image": true,
                "followers_count": 725.0,
                "id_str": "1111111456788893",
                "created_at": "Thu Aug 27 09:06:03 +0000 2009",
                "profile_background_color": "BADFCD",
                "favourites_count": 278.0
            ],
            "entities": [
                "urls": [
                    "http://www.example.com/",
                    "https://www.example.com/",
                    "http://www.example.com/brass.html?blow=army",
                    "http://www.example.com/babies/bath.php",
                    "http://www.example.com/?account=afterthought",
                    "https://example.com/"
                ]
            ]
        ]

        let jsonData = try JSONSerialization.data(withJSONObject: dummyTweetObject, options: [])
        let json = try JSON.parse(jsonData: jsonData)

        XCTContext.runActivity(named: "can get value") { _ in
            XCTAssertEqual(json.id_str.string, dummyTweetObject["id_str"] as? String)
            XCTAssertEqual(json.id_str.string, json["id_str"].string)
        }

        XCTContext.runActivity(named: "can access nested value") { _ in
            XCTAssertEqual(json.user.created_at.string, json["user"]["created_at"].string)
        }

        XCTContext.runActivity(named: "wrong key") { _ in
            XCTAssertTrue(json.xxxxxxxxxxxxxxxxxx == .invalid)
            XCTAssertTrue(json["xxxxxxxxxxxxxxxxxx"] == .invalid)
        }
    }
}

