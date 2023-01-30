//
//  PlistManager.swift
//  iOS-SnapKit-Demo
//
//  Created by 王潇 on 2023/1/29.
//

import UIKit

public enum Type: Int {
    case number
    case string
    case bool
    case array
    case dictionary
    case null
    case unknown
    case data
}

class PlistManager: NSObject {
    
    private override init() {
        super.init()
    }
    
    static let defaltManager = PlistManager()
    
    private let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
    
    /** 读取根目录 plistName: plist文件名 **/
    subscript (_ plistName: String) -> Dictionary<String, Any> {
        get {
            let filePath = "\(path)/MyDatas/\(plistName).plist"
            
            if FileManager.default.fileExists(atPath: filePath) {
                let rootDic = NSDictionary.init(contentsOfFile: filePath)
                return rootDic as! Dictionary<String, Any>
            }
            
            return Dictionary<String, Any>()
        }
    }
    
    /** 读取数据 plistName: 文件名, name: 字段名 **/
    subscript (_ plistName: String, _ name: String) -> JHJSON {
        get {
            let filePath = "\(path)/MyDatas/\(plistName).plist"
            if FileManager.default.fileExists(atPath: filePath) {
                let rootDic = NSDictionary.init(contentsOfFile: filePath)
                return JHJSON.init(rootDic![name])
            }
            return JHJSON.init(nil)
        }
    }
    
    /** 写入数据 **/
    func set(value: Any, forKey: String, plistName: String) {
        if forKey == "" || plistName == "" {
            return
        }
        let filePath = "\(path)/MyDatas/\(plistName).plist"
        print("plist文件路径 === \(filePath)")
        if !(FileManager.default.fileExists(atPath: filePath)) {
            if let dict = value as? Dictionary<String, Any> {
                /// 如果存储对象是字典就转化为json字符串,防止字典内存在空值导致写入plist失败
                let dic = [forKey: dict.toJsonString()] as NSDictionary
                dic.write(toFile: filePath, atomically: true)
            } else {
                let dic = [forKey: value] as NSDictionary
                dic.write(toFile: filePath, atomically: true)
            }
        } else {
            if let dict = value as? Dictionary<String, Any> {
                /// 如果存储对象是字典就转化为json字符串,防止字典内存在空值导致写入plist失败
                var dic = self[plistName]
                dic[forKey] = dict.toJsonString()
                (dic as NSDictionary).write(toFile: filePath, atomically: true)
            } else {
                var dic = self[plistName]
                dic[forKey] = value
                (dic as NSDictionary).write(toFile: filePath, atomically: true)
            }
        }
    }
}

/** 用来解析数据 **/
struct JHJSON {
    fileprivate var rawArray: [Any]!
    fileprivate var rawDictionary: [String: Any]!
    fileprivate var rawString: String!
    fileprivate var rawNumber: NSNumber!
    fileprivate var rawNull: NSNull = NSNull()
    fileprivate var rawBool: Bool = false
    fileprivate var rawData: Data!
    
    fileprivate var type: Type = .null
    
    public init(_ object: Any?) {
        if object != nil {
            switch object {
            case let object as [Any] where object.count > 0:
                self.rawArray = object as [Any]
                self.type = .array
                break
            case let object as Dictionary<String, Any> where object.count > 0:
                self.rawDictionary = object
                self.type = .dictionary
                break
            case let object as String:
                self.rawString = object
                self.type = .string
                break
            case let object as NSNumber:
                self.rawNumber = object
                self.type = .number
                break
            case let object as Bool:
                self.rawBool = object
                self.type = .bool
                break
            case let object as Data:
                self.rawData = object
                self.type = .data
                break
            default:
                self.type = .null
                break
            }
        }
    }
    
    /** 转化为Array **/
    public var arrayValue: [Any] {
        get {
            switch self.type {
            case .array:
                return self.rawArray
            default:
                return [Any]()
            }
        }
    }
    
    /** 转化为Dictionary **/
    public var dictionaryValue: Dictionary<String, Any> {
        get {
            switch self.type {
            case .dictionary:
                return self.rawDictionary
            case .data:
                do {
                    let json = try JSONSerialization.jsonObject(with: self.rawData, options: .mutableContainers)
                    if let dic = json as? Dictionary<String, Any> {
                        return dic
                    } else {
                        print("不是正确的字典格式")
                        return Dictionary<String, Any>()
                    }
                } catch {
                    print("不是正确的字典格式: \(error.localizedDescription)")
                    return Dictionary<String, Any>()
                }
            case .string:
                let jsonData: Data = self.rawString.data(using: .utf8)!
                do {
                    let json = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
                    if let dict = json as? Dictionary<String, Any> {
                        return dict
                    } else {
                        print("不是正确的字典格式")
                        return Dictionary<String, Any>()
                    }
                } catch {
                    print("不是正确的字典格式: \(error)")
                    return Dictionary<String, Any>()
                }
            default:
                print("不是正确的字典格式")
                return Dictionary<String, Any>()
            }
        }
    }
    
    /** 转化为NSNumber **/
    public var numberValue: NSNumber {
        get {
            switch self.type {
            case .string:
                let decimal = NSDecimalNumber(string: self.rawString)
                if decimal == NSDecimalNumber.notANumber {
                    return NSDecimalNumber.zero
                }
                return decimal
            case .number:
                return self.rawNumber ?? NSNumber(value: 0)
            case .bool:
                return NSNumber(value: self.rawBool ? 1 : 0)
            default:
                return NSNumber(value: 0.0)
            }
        }
    }
    
    /** 转化为Bool **/
    public var boolValue: Bool {
        get {
            switch self.type {
            case .bool:
                return self.rawBool
            case .number:
                return self.rawNumber.boolValue
            case .string:
                return["true", "y", "t"].contains() { (truthyString) in
                    return self.rawString.caseInsensitiveCompare(truthyString) == .orderedSame
                }
            default:
                return false
            }
        }
    }
    
    /** 转化为Data **/
    public var dataValue: Data {
        get {
            switch self.type {
            case .data:
                return self.rawData
            default:
                return Data.init()
            }
        }
    }
    
}
