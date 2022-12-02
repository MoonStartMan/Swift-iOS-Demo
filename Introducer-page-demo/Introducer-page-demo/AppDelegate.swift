//
//  AppDelegate.swift
//  Introducer-page-demo
//
//  Created by 王潇 on 2022/10/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let navController = UINavigationController(rootViewController: ViewController())
        navController.isNavigationBarHidden = true
        navController.isToolbarHidden = true
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navController
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
        return true
    }

}

