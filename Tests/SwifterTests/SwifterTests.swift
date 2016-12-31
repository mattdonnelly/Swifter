import XCTest
@testable import Swifter

class SwifterTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(Swifter().text, "Hello, World!")
    }


    static var allTests : [(String, (SwifterTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
