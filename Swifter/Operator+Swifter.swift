//
//  Operator+Swifter.swift
//  Swifter
//
//  Created by Andy Liang on 2016-02-19.
//  Copyright © 2016 Matt Donnelly. All rights reserved.
//

import Foundation

/// If `rhs` is not `nil`, assign it to `lhs`.
infix operator ??= { associativity right precedence 90 assignment } // matches other assignment operators

/// If `rhs` is not `nil`, assign it to `lhs`.
func ??=<T>(inout lhs: T?, rhs: T?) {
    guard let rhs = rhs else { return }
    lhs = rhs
}
