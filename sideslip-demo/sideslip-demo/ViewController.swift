//
//  ViewController.swift
//  sideslip-demo
//
//  Created by 王潇 on 2023/2/17.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private var slidesView: SlidesView = SlidesView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.addSubview(slidesView)
        slidesView.snp.makeConstraints { make in
            make.top.equalTo(34)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(-34)
        }
    }

}

