//
//  UIColor+Extension.swift
//  Half-Slider
//
//  Created by 王潇 on 2022/4/6.
//

import Foundation
import UIKit

/// HEX字符串，兼容#前缀有无的情况
typealias HexString = String

extension UIColor {
    //  返回HSBA模式颜色值
    public var hsba: (hue: CGFloat, staturation: CGFloat, brightness: CGFloat, alpha: CGFloat) {
        var h: CGFloat = 0
        var s: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        self.getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        return (h * 360, s, b, a)
    }
    
    //  返回十六进制颜色
    public var hexColor: String {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        let multiplier = CGFloat(255.999999)
        
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        if alpha == 1.0 {
            return String(
                format: "#%02X%02X%02X",
                Int(red * multiplier),
                Int(green * multiplier),
                Int(blue * multiplier)
            )
        } else {
            return String(
                format: "#%02X%02X%02X",
                Int(red * multiplier),
                Int(green * multiplier),
                Int(blue * multiplier),
                Int(alpha * multiplier)
            )
        }
    }
    
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
        guard hexFormatted.count == 6 else {
            self.init(red: 0, green: 0, blue: 0, alpha: 1)
            return
        }
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
    
    func toHexString() -> String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        return String(format: "#%02lX%02lX%02lX", lroundf(Float(r * 255)), lroundf(Float(g * 255)), lroundf(Float(b * 255)))
    }
    
    func createOnePixelImage() -> UIImage? {
        let size = CGSize(width: 1, height: 1)
        UIGraphicsBeginImageContext(size)
        defer { UIGraphicsEndImageContext() }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        context.setFillColor(cgColor)
        context.fill(CGRect(origin: .zero, size: size))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
}
