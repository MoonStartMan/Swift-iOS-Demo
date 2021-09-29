//
//  AppDelegate.swift
//  Layer-shadow-Demo
//
//  Created by 王潇 on 2021/9/28.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow.init(frame: UIScreen.main.bounds)
        let VC = ViewController()
        window?.backgroundColor = .white
        window?.rootViewController = VC
        window?.makeKeyAndVisible()
        
        return true
    }

}

