//
//  ViewController.swift
//  Swift-PopWindow-Demo
//
//  Created by 王潇 on 2021/9/29.
//

import UIKit

class ViewController: UIViewController {
    
    var popWindowView: MSPopupWindowView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        popWindowView = MSPopupWindowView(frame: .zero, type: .AlertHideView)
        
        self.view.addSubview(popWindowView)
        popWindowView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 170, height: 170))
        }
        popWindowView.title = "Sound is off"
        popWindowView.iconImage = UIImage(named: "turn-on")
    }


}

