//
//  ViewController.swift
//  DrakAndLight-Demo
//
//  Created by 王潇 on 2021/8/10.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let viewDemo = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        viewDemo.backgroundColor = .systemPink
        view.addSubview(viewDemo)
        viewDemo.backgroundColor = ThemeColor.labelTextColor
    }

}

