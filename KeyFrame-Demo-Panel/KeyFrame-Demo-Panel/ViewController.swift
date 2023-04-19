//
//  ViewController.swift
//  KeyFrame-Demo-Panel
//
//  Created by 王潇 on 2023/4/7.
//

import UIKit

class ViewController: UIViewController, TimeRemapPlateViewDelegate {
    func keyFrameBtnClick() {
        print("点击了添加/删除关键帧")
    }
    
    func decideFrameBtnClick() {
        print("点击了设置/取消定格帧")
    }
    
    func prevFrameBtnClick() {
        print("点击了上一帧")
    }
    
    func nextFrameBtnClick() {
        print("点击了下一帧")
    }
    
    func curveBtnClick() {
        print("点击了曲线")
    }
    
    func resetBtnClick() {
        print("点击了重置")
    }
    
    
    private var timeRemapPlateview: TimeRemapPlateView = TimeRemapPlateView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.addSubview(timeRemapPlateview)
        timeRemapPlateview.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(276)
        }
        timeRemapPlateview.delegate = self
    }


}

