//
//  ViewController.swift
//  Swift-ScrollView-Demo
//
//  Created by 王潇 on 2022/6/4.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private var swiperView: SwiperView = SwiperView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.addSubview(swiperView)
        swiperView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }


}

