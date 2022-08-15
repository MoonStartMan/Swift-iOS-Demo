//
//  AppDelegate.swift
//  panpelProtocol-Demo
//
//  Created by 王潇 on 2022/7/16.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var vc: UIViewController = ViewController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        let editVc = EditViewController()
        editVc.delegate = vc as? EditViewControllerDelegate
        
        let navVC = UINavigationController(rootViewController: editVc)
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
        return true
    }

}

