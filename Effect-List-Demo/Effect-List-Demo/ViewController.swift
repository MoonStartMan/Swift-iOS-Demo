//
//  ViewController.swift
//  Effect-List-Demo
//
//  Created by 王潇 on 2021/9/8.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let effectView = MSListControlView()
        self.view.addSubview(effectView)
        effectView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(40)
        }
        effectView.titleText = "Effect"
        effectView.clearBack = {
            print("点击了清除")
        }
        effectView.determineBack = {
            print("点击了确定")
        }
        
        let effectDetailsView = EffectDetailsView()
        self.view.addSubview(effectDetailsView)
        effectDetailsView.snp.makeConstraints { make in
            make.top.equalTo(effectView.snp.bottom).offset(20)
            make.left.right.equalToSuperview()
            make.height.equalTo(80)
        }
    }


}

