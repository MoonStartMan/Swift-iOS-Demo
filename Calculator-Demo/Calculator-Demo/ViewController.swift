//
//  ViewController.swift
//  Calculator-Demo
//
//  Created by 王潇 on 2021/5/25.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    //  背景视图
    var backgroundView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.black
        
        //  顶部数值展示视图
        let numsView = NumsView(frame: .zero)
        self.view.addSubview(numsView)
        numsView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(200)
            make.top.equalTo(0)
            make.left.equalTo(0)
        }
    }
}

