//
//  ViewController.swift
//  Effect-PopView
//
//  Created by 王潇 on 2023/2/28.
//

import UIKit

class ViewController: UIViewController {
    
    private let effectUpgradeView: MSEffectUpgradeView = MSEffectUpgradeView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.addSubview(effectUpgradeView)
        effectUpgradeView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }


}

