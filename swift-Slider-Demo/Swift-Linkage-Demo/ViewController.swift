//
//  ViewController.swift
//  Swift-Linkage-Demo
//
//  Created by 王潇 on 2021/8/25.
//

import UIKit
import SnapKit

let marginBottom = 44
let fillterHeight = 300

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
        let fillterView = FillterView(frame: .zero)
        view.addSubview(fillterView)
        fillterView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-marginBottom)
            make.width.equalToSuperview()
            make.height.equalTo(fillterHeight)
        }
        fillterView.backgroundColor = .systemPink
    }


}

