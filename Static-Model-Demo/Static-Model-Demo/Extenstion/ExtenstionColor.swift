//
//  ExtenstionColor.swift
//  Static-Model-Demo
//
//  Created by 王潇 on 2021/8/11.
//

import UIKit

extension UIColor {
    /// HEX字符串，兼容#前缀有无的情况
    typealias HexString = String
    
    /// 使用Hex 初始化字符串
    ///
    /// - Parameters:
    ///   - hexString: hex, #484848
    ///   - alpha: alpha
    convenience init(hex: HexString, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }
        assert(hexFormatted.count == 6, "Invalid hex code used.")
        var color: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    class func hex(_ hex: HexString, _ alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(hex: hex, alpha: alpha)
    }
    
}
