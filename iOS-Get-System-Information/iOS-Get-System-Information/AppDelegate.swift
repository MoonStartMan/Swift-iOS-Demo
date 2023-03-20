//
//  AppDelegate.swift
//  iOS-Get-System-Information
//
//  Created by 王潇 on 2023/3/15.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = ViewController()
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
        
        return true
    }


}

