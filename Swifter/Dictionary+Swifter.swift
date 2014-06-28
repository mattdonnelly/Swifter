//
//  Dictionary+Swifter.swift
//  Swifter
//
//  Copyright (c) 2014 Matt Donnelly.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation

extension Dictionary {

    func join(other: Dictionary) -> Dictionary {
        var joinedDictionary = Dictionary()

        for (key, value) in self {
            joinedDictionary.updateValue(value, forKey: key)
        }

        for (key, value) in other {
            joinedDictionary.updateValue(value, forKey: key)
        }

        return joinedDictionary
    }

    func filter(predicate: (key: KeyType, value: ValueType) -> Bool) -> Dictionary {
        var filteredDictionary = Dictionary()

        for (key, value) in self {
            if predicate(key: key, value: value) {
                filteredDictionary.updateValue(value, forKey: key)
            }
        }

        return filteredDictionary
    }

    func queryStringWithEncoding() -> String {
        var parts = String[]()

        for (key, value) in self {
            let keyString: String = "\(key)"
            let valueString: String = "\(value)"
            let query: String = "\(keyString)=\(valueString)"
            parts.append(query)
        }

        return parts.bridgeToObjectiveC().componentsJoinedByString("&") as String
    }

    func urlEncodedQueryStringWithEncoding(encoding: NSStringEncoding) -> String {
        var parts = String[]()

        for (key, value) in self {
            let keyString: String = "\(key)".urlEncodedStringWithEncoding(encoding)
            let valueString: String = "\(value)".urlEncodedStringWithEncoding(encoding)
            let query: String = "\(keyString)=\(valueString)"
            parts.append(query)
        }

        return parts.bridgeToObjectiveC().componentsJoinedByString("&") as String
    }
    
}
