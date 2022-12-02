//
//  TestViewController.swift
//  AVFoundtion-Demo
//
//  Created by 王潇 on 2022/12/1.
//

import UIKit
import SnapKit

class TestViewController: UIViewController {
    
    private var textLabel: UILabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(textLabel)
        textLabel.font = .systemFont(ofSize: 30, weight: .bold)
        textLabel.textAlignment = .center
        textLabel.text = "字体投影和颜色渐变"
    }

}
