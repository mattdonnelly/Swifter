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

public typealias JSONValue = JSON

public let JSONTrue = JSONValue(true)
public let JSONFalse = JSONValue(false)

public let JSONNull = JSONValue.JSONNull

public enum JSON : Equatable, CustomStringConvertible {
    
    case JSONString(String)
    case JSONNumber(Double)
    case JSONObject(Dictionary<String, JSONValue>)
    case JSONArray(Array<JSON>)
    case JSONBool(Bool)
    case JSONNull
    case JSONInvalid
    
    init(_ value: Bool?) {
        if let bool = value {
            self = .JSONBool(bool)
        }
        else {
            self = .JSONInvalid
        }
    }
    
    init(_ value: Double?) {
        if let number = value {
            self = .JSONNumber(number)
        }
        else {
            self = .JSONInvalid
        }
    }
    
    init(_ value: Int?) {
        if let number = value {
            self = .JSONNumber(Double(number))
        }
        else {
            self = .JSONInvalid
        }
    }
    
    init(_ value: String?) {
        if let string = value {
            self = .JSONString(string)
        }
        else {
            self = .JSONInvalid
        }
    }
    
    init(_ value: Array<JSONValue>?) {
        if let array = value {
            self = .JSONArray(array)
        }
        else {
            self = .JSONInvalid
        }
    }
    
    init(_ value: Dictionary<String, JSONValue>?) {
        if let dict = value {
            self = .JSONObject(dict)
        }
        else {
            self = .JSONInvalid
        }
    }
    
    init(_ rawValue: AnyObject?) {
        if let value : AnyObject = rawValue {
            switch value {
            case let data as NSData:
                do {
                    let jsonObject : AnyObject = try NSJSONSerialization.JSONObjectWithData(data, options: [])
                    self = JSON(jsonObject)
                } catch {
                    self = .JSONInvalid
                }

            case let array as NSArray:
                var newArray : [JSONValue] = []
                for item : AnyObject in array {
                    newArray.append(JSON(item))
                }
                self = .JSONArray(newArray)
                
            case let dict as NSDictionary:
                var newDict : Dictionary<String, JSONValue> = [:]
                for (k, v): (AnyObject, AnyObject) in dict {
                    if let key = k as? String {
                        newDict[key] = JSON(v)
                    }
                    else {
                        assert(true, "Invalid key type; expected String")
                        self = .JSONInvalid
                        return
                    }
                }
                self = .JSONObject(newDict)
                
            case let string as NSString:
                self = .JSONString(string as String)
                
            case let number as NSNumber:
                if number.isBool {
                    self = .JSONBool(number.boolValue)
                }
                else {
                    self = .JSONNumber(number.doubleValue)
                }
                
            case _ as NSNull:
                self = .JSONNull
                
            default:
                assert(true, "This location should never be reached")
                self = .JSONInvalid
            }
        }
        else {
            self = .JSONInvalid
        }
    }

    public var string : String? {
        switch self {
        case .JSONString(let value):
            return value
        default:
            return nil
        }
    }

    public var integer : Int? {
        switch self {
        case .JSONNumber(let value):
            return Int(value)
            
        default:
            return nil
        }
    }

    public var double : Double? {
        switch self {
        case .JSONNumber(let value):
            return value

        default:
            return nil
        }
    }

    public var object : Dictionary<String, JSONValue>? {
        switch self {
        case .JSONObject(let value):
            return value
            
        default:
            return nil
        }
    }

    public var array : Array<JSONValue>? {
        switch self {
        case .JSONArray(let value):
            return value
            
        default:
            return nil
        }
    }

    public var bool : Bool? {
        switch self {
        case .JSONBool(let value):
            return value

        default:
            return nil
        }
    }

    public subscript(key: String) -> JSONValue {
        switch self {
        case .JSONObject(let dict):
            if let value = dict[key] {
                return value
            }
            else {
                return .JSONInvalid
            }

        default:
            return .JSONInvalid
        }
    }

    public subscript(index: Int) -> JSONValue {
        switch self {
        case .JSONArray(let array) where array.count > index:
            return array[index]

        default:
            return .JSONInvalid
        }
    }

    static func parseJSONData(jsonData : NSData) throws -> JSON {
        let JSONObject = try? NSJSONSerialization.JSONObjectWithData(jsonData, options: .MutableContainers)
        return (JSONObject == nil) ? nil : JSON(JSONObject)
    }

    static func parseJSONString(jsonString : String) throws -> JSON {
        let error: NSError! = NSError(domain: "Migrator", code: 0, userInfo: nil)
        if let data = jsonString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
            return try parseJSONData(data)
        }
        throw error
    }

    func stringify(indent: String = "  ") -> String? {
        switch self {
        case .JSONInvalid:
            assert(true, "The JSON value is invalid")
            return nil

        default:
            return _prettyPrint(indent, 0)
        }
    }

}

public func ==(lhs: JSON, rhs: JSON) -> Bool {
    switch (lhs, rhs) {
    case (.JSONNull, .JSONNull):
        return true
        
    case (.JSONBool(let lhsValue), .JSONBool(let rhsValue)):
        return lhsValue == rhsValue

    case (.JSONString(let lhsValue), .JSONString(let rhsValue)):
        return lhsValue == rhsValue

    case (.JSONNumber(let lhsValue), .JSONNumber(let rhsValue)):
        return lhsValue == rhsValue

    case (.JSONArray(let lhsValue), .JSONArray(let rhsValue)):
        return lhsValue == rhsValue

    case (.JSONObject(let lhsValue), .JSONObject(let rhsValue)):
        return lhsValue == rhsValue
        
    default:
        return false
    }
}

extension JSON {

    public var description: String {
        if let jsonString = stringify() {
            return jsonString
        }
        else {
            return "<INVALID JSON>"
        }
    }

    private func _prettyPrint(indent: String, _ level: Int) -> String {
        let currentIndent = (0...level).map({ _ in "" }).joinWithSeparator(indent)
        let nextIndent = currentIndent + "  "
        
        switch self {
        case .JSONBool(let bool):
            return bool ? "true" : "false"
            
        case .JSONNumber(let number):
            return "\(number)"
            
        case .JSONString(let string):
            return "\"\(string)\""
            
        case .JSONArray(let array):
            return "[\n" + array.map({ "\(nextIndent)\($0._prettyPrint(indent, level + 1))" }).joinWithSeparator(",\n") + "\n\(currentIndent)]"
            
        case .JSONObject(let dict):
            return "{\n" + dict.map({ "\(nextIndent)\"\($0)\" : \($1._prettyPrint(indent, level + 1))"}).joinWithSeparator(",\n") + "\n\(currentIndent)}"
            
        case .JSONNull:
            return "null"
            
        case .JSONInvalid:
            assert(true, "This should never be reached")
            return ""
        }
    }

}

extension JSONValue: BooleanType {

    public var boolValue: Bool {
        switch self {
        case .JSONBool(let bool):
            return bool
        case .JSONInvalid:
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

private let trueNumber = NSNumber(bool: true)
private let falseNumber = NSNumber(bool: false)
private let trueObjCType = String.fromCString(trueNumber.objCType)
private let falseObjCType = String.fromCString(falseNumber.objCType)

private extension NSNumber {
    var isBool:Bool {
        get {
            let objCType = String.fromCString(self.objCType)
            if (self.compare(trueNumber) == NSComparisonResult.OrderedSame &&  objCType == trueObjCType) ||  (self.compare(falseNumber) == NSComparisonResult.OrderedSame && objCType == falseObjCType){
                return true
            } else {
                return false
            }
        }
    }
}
