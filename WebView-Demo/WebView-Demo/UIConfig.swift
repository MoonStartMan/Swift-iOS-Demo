//
//  UIConfig.swift
//  WebView-Demo
//
//  Created by 王潇 on 2021/12/22.
//

import UIKit

//  全屏高宽
let kScreenW: CGFloat = UIScreen.main.bounds.size.width
let kScreenH: CGFloat = UIScreen.main.bounds.size.height

//  判断是否为 iPhoneX
let isIphoneX = kScreenH >= 812 ? true : false

let kSafeAreaTop: CGFloat = isIphoneX ? 44 : 20
let kSafeAreaBottom: CGFloat = isIphoneX ? 34 : 0
