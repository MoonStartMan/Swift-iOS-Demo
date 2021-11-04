//
//  ViewController.swift
//  Half-Slider
//
//  Created by 王潇 on 2021/11/1.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private var slider: MSHalfSlider!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        slider = MSHalfSlider()
        self.view.addSubview(slider)
        slider.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 200, height: 16))
        }
        slider.maximumValue = 100
        slider.minimumValue = -100
    
        slider.sliderStartBack = { [weak self] value in
            print(value)
        }
        
        slider.sliderChangeBack = { [weak self] value in
            print(value)
        }
        
        slider.sliderEndBack = { [weak self] value in
            print(value)
        }
        
        slider.sliderProcess = 50
    }


}

