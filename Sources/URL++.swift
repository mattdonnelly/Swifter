//
//  URL+Swifter.swift
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

extension URL {
    
    func append(queryString: String) -> URL {
        guard !queryString.utf16.isEmpty else {
            return self
        }
        
        var absoluteURLString = self.absoluteString
        
        if absoluteURLString.hasSuffix("?") {
            absoluteURLString = String(absoluteURLString[0..<absoluteURLString.utf16.count])
        }
        
        let urlString = absoluteURLString + (absoluteURLString.range(of: "?") != nil ? "&" : "?") + queryString
        return URL(string: urlString)!
    }
    
    func hasSameUrlScheme(as otherUrl: URL) -> Bool {
        guard let scheme = self.scheme, let otherScheme = otherUrl.scheme else { return false }
        return scheme.caseInsensitiveCompare(otherScheme) == .orderedSame
    }
  
    var queryParamsForSSO: [String : String] {
        guard let host = self.host else { return [:] }
        return host.split(separator: "&").reduce(into: [:]) { (result, parameter) in
            let keyValue = parameter.split(separator: "=")
            result[String(keyValue[0])] = String(keyValue[1])
        }
    }
}
