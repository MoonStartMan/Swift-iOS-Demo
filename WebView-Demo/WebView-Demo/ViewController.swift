//
//  ViewController.swift
//  WebView-Demo
//
//  Created by 王潇 on 2021/12/19.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    private var testBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        testBtn = UIButton()
        self.view.addSubview(testBtn)
        testBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 200, height: 60))
        }
        testBtn.backgroundColor = .brown
        testBtn.setTitle("测试点击", for: .normal)
        testBtn.addTarget(self, action: #selector(testClick), for: .touchUpInside)
    }

    @objc func testClick() {
        let WebVC = WebViewController()
        WebVC.title = "特别感谢"
        WebVC.urlString = "https://blurrr.saladvideo.com/thanks.html?lang=en"
        self.navigationController?.pushViewController(WebVC, animated: true)
    }
    
}

