//
//  String+Swifter.swift
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

extension String {

    internal func indexOf(sub: String) -> Int? {
        guard let range = self.rangeOfString(sub) where !range.isEmpty else {
            return nil
        }
        return self.startIndex.distanceTo(range.startIndex)
    }

    internal subscript (r: Range<Int>) -> String {
        get {
            let startIndex = self.startIndex.advancedBy(r.startIndex)
            let endIndex = startIndex.advancedBy(r.endIndex - r.startIndex)
            return self[startIndex..<endIndex]
        }
    }
    
    func urlEncodedStringWithEncoding(all: Bool = false) -> String {
        let allowedCharacterSet = NSCharacterSet.URLQueryAllowedCharacterSet().mutableCopy() as! NSMutableCharacterSet
        allowedCharacterSet.removeCharactersInString("\n:#/?@!$&'()*+,;=")
        if !all {
            allowedCharacterSet.addCharactersInString("[]")
        }
        return self.stringByAddingPercentEncodingWithAllowedCharacters(allowedCharacterSet)!

    }

    func parametersFromQueryString() -> Dictionary<String, String> {
        var parameters = Dictionary<String, String>()

        let scanner = NSScanner(string: self)

        var key: NSString?
        var value: NSString?

        while !scanner.atEnd {
            key = nil
            scanner.scanUpToString("=", intoString: &key)
            scanner.scanString("=", intoString: nil)

            value = nil
            scanner.scanUpToString("&", intoString: &value)
            scanner.scanString("&", intoString: nil)

            if let key = key as? String, let value = value as? String {
                parameters.updateValue(value, forKey: key)
            }
        }
        
        return parameters
    }
    
    func parametersDictionaryFromCommaSeparatedParametersString() -> Dictionary<String, String> {
        var dict = Dictionary<String, String>()
        
        for parameter in self.componentsSeparatedByString(", ") {
            // transform k="v" into {'k':'v'}
            let keyValue = parameter.componentsSeparatedByString("=")
            if keyValue.count != 2 {
                continue
            }
            
            let value = keyValue[1].stringByReplacingOccurrencesOfString("\"", withString:"")
            dict.updateValue(value, forKey: keyValue[0])
        }
        
        return dict
    }
    
}

