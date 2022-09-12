//
//  AppDelegate.swift
//  MovingViewDemo
//
//  Created by 王潇 on 2022/9/11.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let vc = ViewController()
        window?.rootViewController = vc
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
        
        return true
    }


}

