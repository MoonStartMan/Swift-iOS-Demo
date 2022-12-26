//
//  DeleteController.swift
//  AutoLayout-Demo
//
//  Created by 王潇 on 2022/12/23.
//

import UIKit
import SnapKit

class DeleteController: UIViewController {

    private var view1: UIView = UIView()
    
    private var view2: UIView = UIView()
    
    private var view3: UIView = UIView()
    
    private var deleteBtn1: UIButton = UIButton()
    
    private var deleteBtn2: UIButton = UIButton()
    
    private var deleteBtn3: UIButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupView()
    }

    private func setupView() {
        view.addSubview(view1)
        view.addSubview(view2)
        view.addSubview(view3)
        view.addSubview(deleteBtn1)
        view.addSubview(deleteBtn2)
        view.addSubview(deleteBtn3)
        
        view1.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(200)
            make.width.height.equalTo(50)
            make.centerX.equalToSuperview()
        }
        view1.backgroundColor = .red
        
        view2.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(200).priority(750)
            make.top.equalTo(view1.snp.bottom).offset(20)
            make.width.height.equalTo(50)
            make.centerX.equalToSuperview()
        }
        view2.backgroundColor = .green
        
        view3.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(200).priority(500)
            make.top.equalTo(view2.snp.bottom).offset(20)
            make.top.equalTo(view1.snp.bottom).offset(20).priority(750)
            make.width.height.equalTo(50)
            make.centerX.equalToSuperview()
        }
        view3.backgroundColor = .orange
        
        deleteBtn1.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.width.equalTo(100)
            make.height.equalTo(30)
            make.top.equalToSuperview().offset(100)
        }
        
        deleteBtn2.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.width.equalTo(100)
            make.height.equalTo(30)
            make.top.equalTo(deleteBtn1.snp.bottom).offset(20)
        }
        
        deleteBtn3.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.width.equalTo(100)
            make.height.equalTo(30)
            make.top.equalTo(deleteBtn2.snp.bottom).offset(20)
        }
        
        deleteBtn1.setTitle("删除view1", for: .normal)
        deleteBtn1.layer.cornerRadius = 15
        deleteBtn1.layer.masksToBounds = true
        deleteBtn1.backgroundColor = .black
        deleteBtn1.titleLabel?.textColor = .white
        deleteBtn1.addTarget(self, action: #selector(deleteFunc1), for: .touchUpInside)
        
        deleteBtn2.setTitle("删除view2", for: .normal)
        deleteBtn2.layer.cornerRadius = 15
        deleteBtn2.layer.masksToBounds = true
        deleteBtn2.backgroundColor = .black
        deleteBtn2.titleLabel?.textColor = .white
        deleteBtn2.addTarget(self, action: #selector(deleteFunc2), for: .touchUpInside)
        
        deleteBtn3.setTitle("删除view3", for: .normal)
        deleteBtn3.layer.cornerRadius = 15
        deleteBtn3.layer.masksToBounds = true
        deleteBtn3.backgroundColor = .black
        deleteBtn3.titleLabel?.textColor = .white
        deleteBtn3.addTarget(self, action: #selector(deleteFunc3), for: .touchUpInside)
    }
}

extension DeleteController {
    @objc func deleteFunc1() {
        view1.removeFromSuperview()
    }
    
    @objc func deleteFunc2() {
        view2.removeFromSuperview()
    }
    
    @objc func deleteFunc3() {
        view3.removeFromSuperview()
    }
}
