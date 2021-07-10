//
//  AppDelegate.swift
//  UICollectionView-拖拽
//
//  Created by 王潇 on 2021/7/9.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        let mainVC = MainVC()
        window?.rootViewController = mainVC
        window?.makeKeyAndVisible()
        
        return true
    }

}
