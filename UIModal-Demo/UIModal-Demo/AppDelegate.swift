//
//  AppDelegate.swift
//  UIModal-Demo
//
//  Created by 王潇 on 2022/7/13.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        let vc = UINavigationController(rootViewController: ViewController())
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        
        return true
    }

}

