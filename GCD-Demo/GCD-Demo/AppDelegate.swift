//
//  AppDelegate.swift
//  GCD-Demo
//
//  Created by 王潇 on 2022/10/9.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        let rootVC = ViewController()
        window?.rootViewController = rootVC
        window?.makeKeyAndVisible()
        return true
    }
    
}

