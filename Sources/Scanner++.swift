//
//  Scanner++.swift
//  Swifter
//
//  Created by Harlan Haskins on 5/15/17.
//  Copyright © 2017 Matt Donnelly. All rights reserved.
//

import Foundation

/// These extensions are needed for API compatibility with Scanner in
/// swift-corelibs-foundation. These are exactly the same API as in
/// https://github.com/apple/swift-corelibs-foundation/blob/master/Foundation/NSScanner.swift
extension Scanner {
    #if os(macOS) || os(iOS)
    func scanString(string: String) -> String? {
        var buffer: NSString?
        scanString(string, into: &buffer)
        return buffer as String?
    }
    func scanUpToString(_ string: String) -> String? {
        var buffer: NSString?
        scanUpTo(string, into: &buffer)
        return buffer as String?
    }
    #endif

    #if os(Linux)
    var isAtEnd: Bool {
        // This is the same check being done inside NSScanner.swift to
        // determine if the scanner is at the end.
        return scanLocation == string.utf16.count
    }
    #endif
}
