//
//  ViewController.swift
//  Switch-Demo
//
//  Created by 王潇 on 2022/3/6.
//

import UIKit

class ViewController: UIViewController {

    var customSwitch: MSSwitch!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        testSwitch()
    }
    
    private func testSwitch() {
        self.customSwitch = MSSwitch()
        self.view.addSubview(customSwitch)
        customSwitch.center = self.view.center
        customSwitch.bounds = CGRect(x: 0, y: 0, width: 64, height: 32)
        customSwitch.valueChangedHandle = {(isOn) in
            print(isOn)
        }
        
        var config = KYLSwitchConfig()
        config.offBgColor = .red
        config.onPointImage = UIImage(named: "icon_switch_turn")
        config.offPointImage = UIImage(named: "icon_switch_angle")
        customSwitch.config = config
    }


}

