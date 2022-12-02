//
//  ViewController.swift
//  Introducer-page-demo
//
//  Created by 王潇 on 2022/10/22.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    var introducerView: IntroducerView = IntroducerView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupView()
    }

    private func setupView() {
        view.addSubview(introducerView)
        introducerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

