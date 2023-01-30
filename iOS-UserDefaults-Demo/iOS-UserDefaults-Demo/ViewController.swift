//
//  ViewController.swift
//  iOS-UserDefaults-Demo
//
//  Created by 王潇 on 2023/1/30.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print("\(UserDefault.shared.isLogin)")
        UserDefault.shared.isLogin = true
        print("\(UserDefault.shared.isLogin)")
    }
}

