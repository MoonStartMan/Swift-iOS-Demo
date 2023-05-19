//
//  AppDelegate.swift
//  Contacts-Demo
//
//  Created by 王潇 on 2023/5/18.
//

import UIKit
import ContactsUI

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        let vc = ViewController()
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        
        //  1. 获取授权状态
        //  CNContactStore 通讯录对象
        let status = CNContactStore.authorizationStatus(for: .contacts)
        
        //  判断如果是未决定状态,则请求授权
        if status == .notDetermined {
            
            //  创建通讯录对象
            let store = CNContactStore()
            
            //  请求授权
            store.requestAccess(for: .contacts) { isRight, error in
                if isRight {
                    print("授权成功")
                } else {
                    print("授权失败")
                }
            }
        }
        
        return true
    }


}

