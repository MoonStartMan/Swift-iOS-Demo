//
//  ViewController.swift
//  ColorPicker-Demo
//
//  Created by 王潇 on 2022/2/16.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private var colorPickerView: ColorPickerView = ColorPickerView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .black
        view.addSubview(colorPickerView)
        colorPickerView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(254)
            make.height.equalTo(337)
        }
        colorPickerView.layer.cornerRadius = 16
        colorPickerView.layer.masksToBounds = true
        colorPickerView.backgroundColor = .white
    }


}

