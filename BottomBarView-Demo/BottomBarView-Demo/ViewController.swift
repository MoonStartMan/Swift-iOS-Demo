//
//  ViewController.swift
//  BottomBarView-Demo
//
//  Created by 王潇 on 2022/2/28.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private var bottomBarView: BottomBarView = BottomBarView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let btn = UIButton()
        view.addSubview(btn)
        btn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.width.height.equalTo(100)
            make.centerX.equalToSuperview()
        }
        btn.setTitle("测试按钮", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.layer.borderWidth = 2
        btn.layer.borderColor = UIColor.red.cgColor
        
        view.addSubview(bottomBarView)
        bottomBarView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(144)
        }
    }


}

