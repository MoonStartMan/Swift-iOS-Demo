//
//  ViewController.swift
//  Prototype-Pattern-Demo
//
//  Created by 王潇 on 2023/8/1.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let monster = Monster(health: 700, level: 37)
        let monster2 = monster.copy()
        print("Watch out! That monster's level is \(monster2.level)")
        
        // 创建EyeballMonster的实例,复制后得到 eyeball2
        let eyeball = EyeballMonster(health: 3002, level: 60, redness: 648)
        let eyeball2 = eyeball.copy()
        print("Eww! Its eyeball redness is \(eyeball2.redness)")
        
        
    }


}

