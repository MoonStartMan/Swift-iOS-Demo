//
//  AppDelegate.swift
//  WebView-Demo
//
//  Created by 王潇 on 2021/12/19.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        let vc = ViewController()
        let navigationViewController = UINavigationController(rootViewController: vc)
        window?.rootViewController = navigationViewController
        window?.makeKeyAndVisible()
        
        return true
    }

}

