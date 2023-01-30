//
//  UserDefaults.swift
//  iOS-UserDefaults-Demo
//
//  Created by 王潇 on 2023/1/30.
//

import UIKit

struct UserDefaultsKey {
    /// 用户会员信息
    enum UserState: String {
        case isLogin
        case vipState
    }
}

public class UserDefault: NSObject {
    static let shared: UserDefault = UserDefault()
    
    let defaultStand = UserDefaults.standard
    
    var isLogin: Bool {
        get {
            defaultStand.bool(forKey: UserDefaultsKey.UserState.isLogin.rawValue)
        }
        set {
            defaultStand.set(newValue, forKey: UserDefaultsKey.UserState.isLogin.rawValue)
        }
    }
    
    var isVip: Bool {
        get {
            defaultStand.bool(forKey: UserDefaultsKey.UserState.vipState.rawValue)
        }
        set {
            defaultStand.set(newValue, forKey: UserDefaultsKey.UserState.vipState.rawValue)
        }
    }
}
