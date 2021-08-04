//
//  ColorScheme.swift
//  SwiftUI-LightAndDark
//
//  Created by 王潇 on 2021/8/2.
//

import SwiftUI

/// 黑色模式下为黑 白色模式下为白
var backgroundColor = UIColor { (trait) -> UIColor in
    if trait.userInterfaceStyle == .light {
        return UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255, alpha: 1)
    } else {
        return UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1)
    }
}


/// 黑色模式下为白 白色模式下为黑

var backgroundColor2 = UIColor { (trait) -> UIColor in
    if trait.userInterfaceStyle == .dark {
        return UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255, alpha: 1)
    } else {
        return UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1)
    }
}
