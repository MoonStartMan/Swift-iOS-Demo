//
//  ViewController.swift
//  SOLID-Demo
//
//  Created by 王潇 on 2023/7/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let car: Car = Car()
        
        car.openDoor()
    }


}

