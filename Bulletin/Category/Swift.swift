//
//  SwiftExtension.swift
//  Tuhu
//
//  Created by 丁帅 on 16/9/19.
//  Copyright © 2016年 Tuhu. All rights reserved.
//

import Foundation
import UIKit
// MARK: - 标准库 扩展
extension Bool {
    /// 通过String创建， 只有 "1" 和 "true" 会返回 true
    init(_ boolStr: String) {
        self = boolStr == "1" || boolStr == "true"
    }
}

extension Double {
    /// 返回格式化的String, 参数 f 代表小数点前后的位数，参考C语言的格式。 eg:  12.3456.format(".2") 返回 "12.34"，
    func format(f: String) -> String {
        return String(format: "%\(f)f", self)
    }
}

extension String {
    /// 字符串长度
    var length: Int { return characters.count }
   
    /// 返回字符串所表示的十六进制数值，支持"#"标识符， 支持 "-" 号
    var hexInteger: Int {
        var temp = self.uppercased()
        if temp.hasPrefix("#") {
            temp = temp.replacingOccurrences(of: "#", with: "")
        }
        var value = 0
        var negativeSign = 1
        var breakLoop = false
        for (idx, char) in temp.characters.enumerated() {
            guard !breakLoop else { break }
            value *= 16
            switch char {
            case "-" where idx == 0:
                negativeSign = -1
            case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9":
                value += Int(String(char))!
            case "A":
                value += 10
            case "B":
                value += 11
            case "C":
                value += 12
            case "D":
                value += 13
            case "E":
                value += 14
            case "F":
                value += 15
            default:
                breakLoop = true
                break;
            }
        }
        return value * negativeSign
    }

    func md5() -> String{
        let context = UnsafeMutablePointer<CC_MD5_CTX>.allocate(capacity: 1)
        var digest = Array<UInt8>(repeating:0, count:Int(CC_MD5_DIGEST_LENGTH))
        CC_MD5_Init(context)
        CC_MD5_Update(context, self, CC_LONG(lengthOfBytes(using: String.Encoding.utf8)))
        CC_MD5_Final(&digest, context)
        context.deallocate(capacity: 1)
        var hexString = ""
        for byte in digest {
            hexString += String(format:"%02x", byte)
        }
        
        return hexString
    }
}

extension Array where Element : Equatable {
    /**
     删除数组中的所有某个对象
     
     - parameter element: 要删除的对象
     */
    mutating func removeElement(element: Element) {
        if let index = index(of: element) {
            remove(at: index)
        }
    }
    
    ///添加唯一元素，在index上。如果遇到重复项，删除重复项。
    mutating func addUniqueElement(element: Element, atIndex i: Int) {
        removeElement(element: element)
        insert(element, at: i)
    }
}

// MARK: - Foundation 扩展
extension DateFormatter {
    convenience init(dateFormat: String) {
        self.init()
        self.locale = Locale(identifier: "zh")
        self.dateFormat = dateFormat
    }
}

extension Dictionary {
    /**
     映射字典中的字段， [oldKey : value]  ->  [newKey : value]
     
     - parameter map: key的映射关系  [oldKey : newKey]
     */
    func map(map: [Key : Key]) -> [Key : Value] {
        return reduce([:]) {
            var temp = $0
            if let mapKey = map[$1.0] {
                temp[mapKey] = $1.1
            } else {
                temp[$1.0] = $1.1
            }
            return temp
        }
    }
    
    /**
     转换字典中的(Key, Value)类型， 返回相应类型的字典
     
     - parameter transform: 每个(Key, Value)的转换方法
     */
    public func map<T: Hashable, V>( transform: (Dictionary.Generator.Element) throws -> (T, V)) rethrows -> [T : V] {
        var result: [T : V] = [:]
        for element in self {
            let (k, v) = try transform(element)
            result[k] = v
        }
        return result
    }
    
    /// 通过 [(Key, Value)] 类型的数组创建字典
    init(_ array: [(Key, Value)]) {
        var result: [Key : Value] = [:]
        for (k, v) in array {
            result[k] = v
        }
        self = result
    }
}

// MARK: - 操作符
infix operator ?= {
associativity right
precedence 90
assignment
}

/// 简化三目运算符赋值. eg:  x ?= y 等价于 x = x ?? y 或者 x = x ? x : y
func ?=<T>( lhs: inout T?, rhs: T?) { lhs = lhs ?? rhs }

// MARK: Dictionary的加法不满足加法交换律
/// Dictionary的加法，合并两个Dictionary中的(Key, Value)，返回新Dictionary。 对于相同的Kay， 右侧的Value会覆盖左侧的
func +<Key: Hashable, Value>(lhs: [Key : Value], rhs: [Key : Value]) -> [Key : Value] {
    var temp = lhs
    for (k, v) in rhs {
        temp[k] = v
    }
    return temp
}

/// Dictionary的加等. eg:  dic1 += dic2 等价于 dic1 = dic1 + dic2
func +=<Key: Hashable, Value>( lhs: inout [Key : Value], rhs: [Key : Value]) { lhs = lhs + rhs}


// MARK: - ** 操作符重载 **

// 自定义操作符 距离
infix operator |-| {
associativity none
precedence 135
}

// 不同类型数值 + - * /
func +(lhs: Int, rhs: Float) -> Float {return Float(lhs) + rhs}
func +(lhs: Int, rhs: Double) -> Double {return Double(lhs) + rhs}
func +(lhs: Int, rhs: CGFloat) -> CGFloat {return CGFloat(lhs) + rhs}
func +(lhs: Float, rhs: Int) -> Float {return lhs + Float(rhs)}
func +(lhs: Float, rhs: Double) -> Double {return Double(lhs) + rhs}
func +(lhs: Float, rhs: CGFloat) -> CGFloat {return CGFloat(lhs) + rhs}
func +(lhs: Double, rhs: Int) -> Double {return lhs + Double(rhs)}
func +(lhs: Double, rhs: Float) -> Double {return lhs + Double(rhs)}
func +(lhs: Double, rhs: CGFloat) -> CGFloat {return CGFloat(lhs) + rhs}
func +(lhs: CGFloat, rhs: Int) -> CGFloat {return lhs + CGFloat(rhs)}
func +(lhs: CGFloat, rhs: Float) -> CGFloat {return lhs + CGFloat(rhs)}
func +(lhs: CGFloat, rhs: Double) -> CGFloat {return lhs + CGFloat(rhs)}

func -(lhs: Int, rhs: Float) -> Float {return Float(lhs) - rhs}
func -(lhs: Int, rhs: Double) -> Double {return Double(lhs) - rhs}
func -(lhs: Int, rhs: CGFloat) -> CGFloat {return CGFloat(lhs) - rhs}
func -(lhs: Float, rhs: Int) -> Float {return lhs - Float(rhs)}
func -(lhs: Float, rhs: Double) -> Double {return Double(lhs) - rhs}
func -(lhs: Float, rhs: CGFloat) -> CGFloat {return CGFloat(lhs) - rhs}
func -(lhs: Double, rhs: Int) -> Double {return lhs - Double(rhs)}
func -(lhs: Double, rhs: Float) -> Double {return lhs - Double(rhs)}
func -(lhs: Double, rhs: CGFloat) -> CGFloat {return CGFloat(lhs) - rhs}
func -(lhs: CGFloat, rhs: Int) -> CGFloat {return lhs - CGFloat(rhs)}
func -(lhs: CGFloat, rhs: Float) -> CGFloat {return lhs - CGFloat(rhs)}
func -(lhs: CGFloat, rhs: Double) -> CGFloat {return lhs - CGFloat(rhs)}

func *(lhs: Int, rhs: Float) -> Float {return Float(lhs) * rhs}
func *(lhs: Int, rhs: Double) -> Double {return Double(lhs) * rhs}
func *(lhs: Int, rhs: CGFloat) -> CGFloat {return CGFloat(lhs) * rhs}
func *(lhs: Float, rhs: Int) -> Float {return lhs * Float(rhs)}
func *(lhs: Float, rhs: Double) -> Double {return Double(lhs) * rhs}
func *(lhs: Float, rhs: CGFloat) -> CGFloat {return CGFloat(lhs) * rhs}
func *(lhs: Double, rhs: Int) -> Double {return lhs * Double(rhs)}
func *(lhs: Double, rhs: Float) -> Double {return lhs * Double(rhs)}
func *(lhs: Double, rhs: CGFloat) -> CGFloat {return CGFloat(lhs) * rhs}
func *(lhs: CGFloat, rhs: Int) -> CGFloat {return lhs * CGFloat(rhs)}
func *(lhs: CGFloat, rhs: Float) -> CGFloat {return lhs * CGFloat(rhs)}
func *(lhs: CGFloat, rhs: Double) -> CGFloat {return lhs * CGFloat(rhs)}

func /(lhs: Int, rhs: Float) -> Float {return Float(lhs) / rhs}
func /(lhs: Int, rhs: Double) -> Double {return Double(lhs) / rhs}
func /(lhs: Int, rhs: CGFloat) -> CGFloat {return CGFloat(lhs) / rhs}
func /(lhs: Float, rhs: Int) -> Float {return lhs / Float(rhs)}
func /(lhs: Float, rhs: Double) -> Double {return Double(lhs) / rhs}
func /(lhs: Float, rhs: CGFloat) -> CGFloat {return CGFloat(lhs) / rhs}
func /(lhs: Double, rhs: Int) -> Double {return lhs / Double(rhs)}
func /(lhs: Double, rhs: Float) -> Double {return lhs / Double(rhs)}
func /(lhs: Double, rhs: CGFloat) -> CGFloat {return CGFloat(lhs) / rhs}
func /(lhs: CGFloat, rhs: Int) -> CGFloat {return lhs / CGFloat(rhs)}
func /(lhs: CGFloat, rhs: Float) -> CGFloat {return lhs / CGFloat(rhs)}
func /(lhs: CGFloat, rhs: Double) -> CGFloat {return lhs / CGFloat(rhs)}

// CGPoint, CGSize, CGRect
func +(lhs: CGPoint, rhs: CGPoint) -> CGPoint {return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)}
func +(lhs: CGRect, rhs: CGRect) -> CGRect {return lhs.union(rhs)}

func -(lhs: CGPoint, rhs: CGPoint) -> CGPoint {return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)}
func -(lhs: CGRect, rhs: CGRect) -> CGRect {return lhs.intersection(rhs)}

func *(lhs: CGPoint, rhs: CGFloat) -> CGPoint {return CGPoint(x: lhs.x * rhs, y: lhs.y * rhs)}
func *(lhs: CGSize, rhs: CGFloat) -> CGSize {return CGSize(width: lhs.width * rhs, height: lhs.height * rhs)}
func *(lhs: CGRect, rhs: CGFloat) -> CGRect {return CGRect(origin: lhs.origin * rhs, size: lhs.size * rhs)}

func +=(lhs: inout CGPoint, rhs: CGPoint) {lhs.x += rhs.x; lhs.y += rhs.y}
func +=(lhs: inout CGRect, rhs: CGRect) {lhs.union(rhs)}

func -=(lhs: inout CGPoint, rhs: CGPoint) {lhs.x -= rhs.x; lhs.y -= rhs.y}
func -=(lhs: inout CGRect, rhs: CGRect) {lhs.intersection(rhs)}

func *=(lhs: inout CGPoint, rhs: CGFloat) {lhs.x *= rhs; lhs.y *= rhs}
func *=(lhs: inout CGSize, rhs: CGFloat) {lhs.width *= rhs; lhs.height *= rhs}
func *=(lhs: inout CGRect, rhs: CGFloat) {lhs.origin *= rhs; lhs.size *= rhs}





//Mark: - 
/// 屏幕尺寸
var screenBounds : CGRect {return UIScreen.main.bounds}
// 判断屏幕尺寸

func screenFitted(x: CGFloat) -> CGFloat {
    return x * screenBounds.width / 375 //iphone6 width
}


//Mark: -
func LogDebug(_ info: Any?) {
    log.debug(info)
}
func LogInfo(_ info: Any?) {
    log.info(info)
}
func LogError(_ info: Any?) {
    log.error(info)
}
func LogVerbose(_ info: Any?) {
    log.verbose(info)
}

