//
//  ViewController.swift
//  List-Of-Fillter-Demo
//
//  Created by 王潇 on 2021/9/1.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let fillerListView = FillterListView(frame: .zero)
        self.view.addSubview(fillerListView)
        fillerListView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(215)
        }
    }


}

