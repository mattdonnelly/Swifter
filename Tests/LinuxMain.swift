import XCTest
@testable import SwifterTests

XCTMain([
     testCase(SwifterTests.allTests),
     testCase(String_SwifterTests.allTests),
])
