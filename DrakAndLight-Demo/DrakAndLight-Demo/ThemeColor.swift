//
//  ThemeColor.swift
//  DrakAndLight-Demo
//
//  Created by 王潇 on 2021/8/10.
//

import UIKit

class ThemeColor {
    /// 深色模式适配  手动控制适配模式  启用  关闭(如非必要, 可移除相关代码)
    static let isOpenDarkModel: Bool = true
    /// MARK:  eg文字颜色
    /// 文字颜色  如果有多种文字颜色可以设置多个eg:   labelTextColor
    public class var labelTextColor: UIColor {
        return darkModeColor(dark: UIColor.white, light: UIColor.black)
    }
    
    /// MARK: 检测当前是否是深色模式
    class func isDarkStyle() -> Bool {
        if(!isOpenDarkModel) {
            return false
        }
        if #available(iOS 13.0, *) {
            let currentMode = UITraitCollection.current.userInterfaceStyle
            if(currentMode == .dark) {
                return true
            }
        }
        return false
    }
    
    /// MARK:   适配  动态颜色
    class func darkModeColor(dark:UIColor, light: UIColor) -> UIColor {
        if(!isOpenDarkModel) {
            return light
        }
        if #available(iOS 13.0, *) {
            return UIColor{(trainCollection) -> UIColor in
                if trainCollection.userInterfaceStyle == .dark {
                    return dark
                } else {
                    return light
                }
            }
        }
        return light
    }
}
