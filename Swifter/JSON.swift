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

public let JSONNull = JSONValue.jsonNull

public enum JSON : Equatable, CustomStringConvertible {
    
    case jsonString(String)
    case jsonNumber(Double)
    case jsonObject(Dictionary<String, JSONValue>)
    case jsonArray(Array<JSON>)
    case jsonBool(Bool)
    case jsonNull
    case jsonInvalid
    
    init(_ value: Bool?) {
        if let bool = value {
            self = .jsonBool(bool)
        }
        else {
            self = .jsonInvalid
        }
    }
    
    init(_ value: Double?) {
        if let number = value {
            self = .jsonNumber(number)
        }
        else {
            self = .jsonInvalid
        }
    }
    
    init(_ value: Int?) {
        if let number = value {
            self = .jsonNumber(Double(number))
        }
        else {
            self = .jsonInvalid
        }
    }
    
    init(_ value: String?) {
        if let string = value {
            self = .jsonString(string)
        }
        else {
            self = .jsonInvalid
        }
    }
    
    init(_ value: Array<JSONValue>?) {
        if let array = value {
            self = .jsonArray(array)
        }
        else {
            self = .jsonInvalid
        }
    }
    
    init(_ value: Dictionary<String, JSONValue>?) {
        if let dict = value {
            self = .jsonObject(dict)
        }
        else {
            self = .jsonInvalid
        }
    }
    
    init(_ rawValue: AnyObject?) {
        if let value : AnyObject = rawValue {
            switch value {
            case let data as Data:
                do {
                    let jsonObject : AnyObject = try JSONSerialization.jsonObject(with: data, options: [])
                    self = JSON(jsonObject)
                } catch {
                    self = .jsonInvalid
                }

            case let array as NSArray:
                var newArray : [JSONValue] = []
                for item : AnyObject in array {
                    newArray.append(JSON(item))
                }
                self = .jsonArray(newArray)
                
            case let dict as NSDictionary:
                var newDict : Dictionary<String, JSONValue> = [:]
                for (k, v): (AnyObject, AnyObject) in dict {
                    if let key = k as? String {
                        newDict[key] = JSON(v)
                    }
                    else {
                        assert(true, "Invalid key type; expected String")
                        self = .jsonInvalid
                        return
                    }
                }
                self = .jsonObject(newDict)
                
            case let string as NSString:
                self = .jsonString(string as String)
                
            case let number as NSNumber:
                if number.isBool {
                    self = .jsonBool(number.boolValue)
                }
                else {
                    self = .jsonNumber(number.doubleValue)
                }
                
            case _ as NSNull:
                self = .jsonNull
                
            default:
                assert(true, "This location should never be reached")
                self = .jsonInvalid
            }
        }
        else {
            self = .jsonInvalid
        }
    }

    public var string : String? {
        switch self {
        case .jsonString(let value):
            return value
        default:
            return nil
        }
    }

    public var integer : Int? {
        switch self {
        case .jsonNumber(let value):
            return Int(value)
            
        default:
            return nil
        }
    }

    public var double : Double? {
        switch self {
        case .jsonNumber(let value):
            return value

        default:
            return nil
        }
    }

    public var object : Dictionary<String, JSONValue>? {
        switch self {
        case .jsonObject(let value):
            return value
            
        default:
            return nil
        }
    }

    public var array : Array<JSONValue>? {
        switch self {
        case .jsonArray(let value):
            return value
            
        default:
            return nil
        }
    }

    public var bool : Bool? {
        switch self {
        case .jsonBool(let value):
            return value

        default:
            return nil
        }
    }

    public subscript(key: String) -> JSONValue {
        switch self {
        case .jsonObject(let dict):
            if let value = dict[key] {
                return value
            }
            else {
                return .jsonInvalid
            }

        default:
            return .jsonInvalid
        }
    }

    public subscript(index: Int) -> JSONValue {
        switch self {
        case .jsonArray(let array) where array.count > index:
            return array[index]

        default:
            return .jsonInvalid
        }
    }

    static func parseJSONData(_ jsonData : Data) throws -> JSON {
        let JSONObject = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
        return (JSONObject == nil) ? nil : JSON(JSONObject)
    }

    static func parseJSONString(_ jsonString : String) throws -> JSON {
        let error: NSError! = NSError(domain: "Migrator", code: 0, userInfo: nil)
        if let data = jsonString.data(using: String.Encoding.utf8, allowLossyConversion: false) {
            return try parseJSONData(data)
        }
        throw error
    }

    func stringify(_ indent: String = "  ") -> String? {
        switch self {
        case .jsonInvalid:
            assert(true, "The JSON value is invalid")
            return nil

        default:
            return _prettyPrint(indent, 0)
        }
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
        if let jsonString = stringify() {
            return jsonString
        }
        else {
            return "<INVALID JSON>"
        }
    }

    private func _prettyPrint(_ indent: String, _ level: Int) -> String {
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
            return "[\n" + array.map({ "\(nextIndent)\($0._prettyPrint(indent, level + 1))" }).joined(separator: ",\n") + "\n\(currentIndent)]"
            
        case .jsonObject(let dict):
            return "{\n" + dict.map({ "\(nextIndent)\"\($0)\" : \($1._prettyPrint(indent, level + 1))"}).joined(separator: ",\n") + "\n\(currentIndent)}"
            
        case .jsonNull:
            return "null"
            
        case .jsonInvalid:
            assert(true, "This should never be reached")
            return ""
        }
    }

}

extension JSONValue: Boolean {

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
            if (self.compare(trueNumber) == ComparisonResult.orderedSame &&  objCType == trueObjCType) ||  (self.compare(falseNumber) == ComparisonResult.orderedSame && objCType == falseObjCType){
                return true
            } else {
                return false
            }
        }
    }
}
