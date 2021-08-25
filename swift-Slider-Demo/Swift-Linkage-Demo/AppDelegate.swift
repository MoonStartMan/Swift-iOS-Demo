//
//  AppDelegate.swift
//  Swift-Linkage-Demo
//
//  Created by 王潇 on 2021/8/25.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        let VC = ViewController()
        window?.rootViewController = VC
        window?.makeKeyAndVisible()
        return true
    }

}

