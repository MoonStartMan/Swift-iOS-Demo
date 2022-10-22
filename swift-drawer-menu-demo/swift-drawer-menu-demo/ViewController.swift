//
//  ViewController.swift
//  swift-drawer-menu-demo
//
//  Created by 王潇 on 2022/10/17.
//

import UIKit
import SnapKit

class ViewController: UIViewController, MenuViewProtocol {
    func getCurrentSelect(type: ResolutionMultipleType) {
        label.text = "\(type)"
    }

    private var menuView: MenuView = MenuView()
    
    private var label: UILabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(menuView)
        menuView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(200)
            make.width.equalTo(138)
            make.height.equalTo(210)
            make.left.equalToSuperview().offset(31)
        }
        menuView.layer.cornerRadius = 16
        menuView.layer.masksToBounds = true
        
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalTo(menuView.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(31)
        }
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textColor = .systemPink
        
        menuView.delegate = self
    }

}
