//
//  ViewController.swift
//  swift-navigation-demo
//
//  Created by 王潇 on 2021/10/5.
//

import UIKit

class ViewController: UIViewController {

    var navbar: NavigationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navbar = NavigationView()
        self.view.addSubview(navbar)
        
        navbar.leftClick = {
            print("点击左侧")
        }
        
        navbar.rightClick = {
            print("点击右侧")
        }
        
        navbar.title = "Setting"
    }


}

