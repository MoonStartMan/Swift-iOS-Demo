//
//  AppDelegate.swift
//  LoginDemo
//
//  Created by 王潇 on 2022/9/6.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        let navVC = UINavigationController(rootViewController: LoginViewController())
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
        
        return true
    }


}

