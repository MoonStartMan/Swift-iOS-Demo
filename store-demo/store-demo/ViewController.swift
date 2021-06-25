//
//  ViewController.swift
//  store-demo
//
//  Created by 王潇 on 2021/6/24.
//

import UIKit

class ViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let homeVC = HomeViewController()
        homeVC.tabBarItem.image = R.image.home()
        homeVC.tabBarItem.selectedImage = R.image.home_selected()?.withRenderingMode(.alwaysOriginal)
        homeVC.tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.hexColor(0x333333)], for: .normal)
        homeVC.tabBarItem.title = "首页"
        let navgationHomeVC = UINavigationController(rootViewController: homeVC)
        self.addChild(navgationHomeVC)
        
        let mineVC = MineViewController()
        mineVC.tabBarItem.image = R.image.mine()
        mineVC.tabBarItem.selectedImage = R.image.mine_selected()?.withRenderingMode(.alwaysOriginal)
        mineVC.tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.hexColor(0x333333)], for: .normal)
        mineVC.tabBarItem.title = "我的"
        let navigationMineVC = UINavigationController(rootViewController: mineVC)
        self.addChild(navigationMineVC)
    }

}

