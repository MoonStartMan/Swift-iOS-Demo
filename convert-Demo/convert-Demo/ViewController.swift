//
//  ViewController.swift
//  convert-Demo
//
//  Created by 王潇 on 2022/2/14.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private var testAView: TestAView = TestAView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.addSubview(testAView)
        testAView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(200)
            make.bottom.equalToSuperview()
        }
    }


}

