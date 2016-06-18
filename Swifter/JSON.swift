//
//  JSON.swift
//  Swifter
//
//  Copyright (c) 2014 Matt Donnelly
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

public let JSONTrue = JSON(true)
public let JSONFalse = JSON(false)

public let JSONNull = JSON.jsonNull

enum JSONError: ErrorProtocol {
    case parseError(String)
}

public enum JSON : Equatable, CustomStringConvertible {
    
    case jsonString(String)
    case jsonNumber(Double)
    case jsonObject(Dictionary<String, JSON>)
    case jsonArray(Array<JSON>)
    case jsonBool(Bool)
    case jsonNull
    case jsonInvalid
    
    init(_ value: Bool?) {
        guard let bool = value else {
            self = .jsonInvalid
            return
        }
        self = .jsonBool(bool)
    }
    
    init(_ value: Double?) {
        guard let number = value else {
            self = .jsonInvalid
            return
        }
        self = .jsonNumber(number)
    }
    
    init(_ value: Int?) {
        guard let number = value else {
            self = .jsonInvalid
            return
        }
        self = .jsonNumber(Double(number))
    }
    
    init(_ value: String?) {
        guard let string = value else {
            self = .jsonInvalid
            return
        }
        self = .jsonString(string)
    }
    
    init(_ value: [JSON]?) {
        guard let array = value else {
            self = .jsonInvalid
            return
        }
        self = .jsonArray(array)
    }
    
    init(_ value: [String: JSON]?) {
        guard let dict = value else {
            self = .jsonInvalid
            return
        }
        self = .jsonObject(dict)
    }
    
    init(_ rawValue: AnyObject?) {
        guard let value = rawValue else {
            self = .jsonInvalid
            return
        }

        switch value {
        case let data as Data:
            do {
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
                self = JSON(jsonObject)
            } catch {
                self = .jsonInvalid
            }
            
        case let array as NSArray:
            let newArray = array.map { JSON($0) }
            self = .jsonArray(newArray)
            
        case let dict as [String: AnyObject]:
            var newDict = [String: JSON]()
            for (key, value) in dict {
                newDict[key] = JSON(value)
            }
            self = .jsonObject(newDict)
            
        case let string as String:
            self = .jsonString(string)
            
        case let number as NSNumber:
            if number.isBool {
                self = .jsonBool(number.boolValue)
            } else {
                self = .jsonNumber(number.doubleValue)
            }
            
        case _ as NSNull:
            self = .jsonNull
            
        default:
            assert(true, "This location should never be reached")
            self = .jsonInvalid
        }

    }

    public var string : String? {
        guard case .jsonString(let value) = self else {
            return nil
        }
        return value
    }

    public var integer : Int? {
        guard case .jsonNumber(let value) = self else {
            return nil
        }
         return Int(value)
    }

    public var double : Double? {
        guard case .jsonNumber(let value) = self else {
            return nil
        }
        return value
    }

    public var object : [String: JSON]? {
        guard case .jsonObject(let value) = self else {
            return nil
        }
        return value
    }

    public var array : [JSON]? {
        guard case .jsonArray(let value) = self else {
            return nil
        }
        return value
    }

    public var bool : Bool? {
        guard case .jsonBool(let value) = self else {
            return nil
        }
        return value
    }

    public subscript(key: String) -> JSON {
        guard case .jsonObject(let dict) = self, let value = dict[key] else {
            return .jsonInvalid
        }
        return value
    }

    public subscript(index: Int) -> JSON {
        guard case .jsonArray(let array) = self where array.count > index else {
            return .jsonInvalid
        }
        return array[index]
    }

    static func parse(jsonData: Data) throws -> JSON {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
            return JSON(jsonObject)
        } catch {
            throw JSONError.parseError("\(error)")
        }
    }

    static func parse(jsonString : String) throws -> JSON {
        do {
            guard let data = jsonString.data(using: .utf8, allowLossyConversion: false) else {
                throw JSONError.parseError("Cannot parse invalid string")
            }
            return try parse(jsonData: data)
        } catch {
            throw JSONError.parseError("\(error)")
        }
    }

    func stringify(_ indent: String = "  ") -> String? {
        guard self != .jsonInvalid else {
            assert(true, "The JSON value is invalid")
            return nil
        }
        return prettyPrint(indent, 0)
    }

}

public func ==(lhs: JSON, rhs: JSON) -> Bool {
    switch (lhs, rhs) {
    case (.jsonNull, .jsonNull):
        return true
        
    case (.jsonBool(let lhsValue), .jsonBool(let rhsValue)):
        return lhsValue == rhsValue

    case (.jsonString(let lhsValue), .jsonString(let rhsValue)):
        return lhsValue == rhsValue

    case (.jsonNumber(let lhsValue), .jsonNumber(let rhsValue)):
        return lhsValue == rhsValue

    case (.jsonArray(let lhsValue), .jsonArray(let rhsValue)):
        return lhsValue == rhsValue

    case (.jsonObject(let lhsValue), .jsonObject(let rhsValue)):
        return lhsValue == rhsValue
        
    default:
        return false
    }
}

extension JSON {

    public var description: String {
        guard let jsonString = stringify() else {
            return "<INVALID JSON>"
        }
        return jsonString
    }

    private func prettyPrint(_ indent: String, _ level: Int) -> String {
        let currentIndent = (0...level).map({ _ in "" }).joined(separator: indent)
        let nextIndent = currentIndent + "  "
        
        switch self {
        case .jsonBool(let bool):
            return bool ? "true" : "false"
            
        case .jsonNumber(let number):
            return "\(number)"
            
        case .jsonString(let string):
            return "\"\(string)\""
            
        case .jsonArray(let array):
            return "[\n" + array.map { "\(nextIndent)\($0.prettyPrint(indent, level + 1))" }.joined(separator: ",\n") + "\n\(currentIndent)]"
            
        case .jsonObject(let dict):
            return "{\n" + dict.map { "\(nextIndent)\"\($0)\" : \($1.prettyPrint(indent, level + 1))"}.joined(separator: ",\n") + "\n\(currentIndent)}"
            
        case .jsonNull:
            return "null"
            
        case .jsonInvalid:
            assert(true, "This should never be reached")
            return ""
        }
    }

}

extension JSON: Boolean {

    public var boolValue: Bool {
        switch self {
        case .jsonBool(let bool):
            return bool
        case .jsonInvalid:
            return false
        default:
            return true
        }
    }

}

extension JSON: StringLiteralConvertible {
    
    public init(stringLiteral value: StringLiteralType) {
        self.init(value)
    }
    
    public init(extendedGraphemeClusterLiteral value: StringLiteralType) {
        self.init(value)
    }
    
    public init(unicodeScalarLiteral value: StringLiteralType) {
        self.init(value)
    }

}

extension JSON: IntegerLiteralConvertible {
    
    public init(integerLiteral value: IntegerLiteralType) {
        self.init(value)
    }

}

extension JSON: BooleanLiteralConvertible {
    
    public init(booleanLiteral value: BooleanLiteralType) {
        self.init(value)
    }

}

extension JSON: FloatLiteralConvertible {
    
    public init(floatLiteral value: FloatLiteralType) {
        self.init(value)
    }

}

extension JSON: DictionaryLiteralConvertible {
    
    public init(dictionaryLiteral elements: (String, AnyObject)...) {
        var dict = [String : AnyObject]()
        
        for (key, value) in elements {
            dict[key] = value
        }
       
        self.init(dict)
    }

}

extension JSON: ArrayLiteralConvertible {
    
    public init(arrayLiteral elements: AnyObject...) {
        self.init(elements)
    }
}

extension JSON: NilLiteralConvertible {
    
    public init(nilLiteral: ()) {
        self.init(NSNull())
    }

}

private let trueNumber = NSNumber(value: true)
private let falseNumber = NSNumber(value: false)
private let trueObjCType = String(cString: trueNumber.objCType)
private let falseObjCType = String(cString: falseNumber.objCType)

private extension NSNumber {
    var isBool:Bool {
        get {
            let objCType = String(cString: self.objCType)
            if (self.compare(trueNumber) == .orderedSame &&  objCType == trueObjCType) ||  (self.compare(falseNumber) == .orderedSame && objCType == falseObjCType){
                return true
            } else {
                return false
            }
        }
    }
}
