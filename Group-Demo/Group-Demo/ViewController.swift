//
//  ViewController.swift
//  Group-Demo
//
//  Created by 王潇 on 2022/3/4.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private var groupMenuView: GroupMenuView = GroupMenuView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = UIColor(red: 0.969, green: 0.969, blue: 0.969, alpha: 1)
        view.addSubview(groupMenuView)
        groupMenuView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(44)
            make.left.right.equalToSuperview()
            make.height.equalTo(44)
        }
        groupMenuView.currentLevel = 5
        groupMenuView.cellClickBack = { [weak self] (value) in
            guard let self = self else { return }
            print(value)
        }
    }


}

