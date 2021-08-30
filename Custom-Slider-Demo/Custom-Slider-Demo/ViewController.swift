//
//  ViewController.swift
//  Custom-Slider-Demo
//
//  Created by 王潇 on 2021/8/27.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let slider = MSSlider(frame: .zero)
        self.view.addSubview(slider)
        slider.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(200)
            make.width.equalTo(300)
            make.centerX.equalToSuperview()
            make.height.equalTo(10)
        }
    }


}

