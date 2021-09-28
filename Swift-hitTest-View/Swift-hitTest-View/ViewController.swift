//
//  ViewController.swift
//  Swift-hitTest-View
//
//  Created by 王潇 on 2021/9/28.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private var testView: TestView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        testView = TestView()
        self.view.addSubview(testView)
        testView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 200, height: 200))
        }
    }
    
}

