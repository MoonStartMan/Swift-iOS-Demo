//
//  UIColor+Extension.swift
//  Effect-List-Demo
//
//  Created by 王潇 on 2021/9/8.
//

import UIKit

/// HEX字符串，兼容#前缀有无的情况
typealias HexString = String

extension UIColor {
    
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
    
    func toHexString() -> String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb: Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format: "#%06x", rgb)
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

extension UIColor {
    
    /// 主题绿色 #D9FB55
    static let themeGreen: UIColor = UIColor(named: "themeGreen") ?? .hex("#D9FB55")
    
    /// 字体黑 #1A1A1A
    static let textBlack: UIColor = UIColor(named: "textBlack") ?? .hex("#1A1A1A")
    
    
    typealias GradientGroup = (UIColor, UIColor)
    
    /// 主题渐变色  #AA63B4 - #DD8AE9
    static let themeGradient: GradientGroup = (.hex("#AA63B4"), .hex("#DD8AE9"))
    
    /// 主题浅渐变色  #D995FF - #DD8AE9
    static let themeGradientLight: GradientGroup = (.hex("#D995FF"), .hex("#DD8AE9"))
    
    /// 特殊渐变色  #43F9FF - #FFD5FF
    static let themeGradientSpecial: GradientGroup = (.hex("#43F9FF"), .hex("#FFD5FF"))
    
}

extension UIColor {
    
    static let grayWhite = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
    static let grayBg = #colorLiteral(red: 0.1176470588, green: 0.1176470588, blue: 0.1176470588, alpha: 1)
    static let sunYellow = #colorLiteral(red: 0.9882352941, green: 0.8117647059, blue: 0.168627451, alpha: 1)
    static let blackText = #colorLiteral(red: 0.1960784314, green: 0.1960784314, blue: 0.1960784314, alpha: 1)
    static let grayText = #colorLiteral(red: 0.4911665916, green: 0.4911786318, blue: 0.4911721349, alpha: 1)
    static let purpleText = #colorLiteral(red: 1, green: 0.8431372549, blue: 1, alpha: 1)
    static let black20 = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
    static let black30 = #colorLiteral(red: 0.3019607843, green: 0.3019607843, blue: 0.3019607843, alpha: 1)
    static let black50 = #colorLiteral(red: 0.5019607843, green: 0.5019607843, blue: 0.5019607843, alpha: 1)
    static let black70 = #colorLiteral(red: 0.7019607843, green: 0.7019607843, blue: 0.7019607843, alpha: 1)
    static let black90 = #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9019607843, alpha: 1)
    static let black95 = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
    
}

