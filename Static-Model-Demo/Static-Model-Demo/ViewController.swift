//
//  ViewController.swift
//  Static-Model-Demo
//
//  Created by 王潇 on 2021/8/11.
//

import UIKit

class ViewController: UIViewController {
    
    let model: [ActionSheetModelItem] = [
        ActionSheetModelItem(iconImage: "copy", title: "copy"),
        ActionSheetModelItem(iconImage: "delete", title: "delete"),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let btn = UIButton(frame: .zero)
        view.addSubview(btn)
        btn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.width.equalTo(100)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
        }
        
        btn.setTitle("点击", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.black.cgColor
        btn.layer.cornerRadius = 5
        btn.layer.masksToBounds = true
        btn.addTarget(self, action: #selector(addActionSheet), for: .touchUpInside)
    }
    
    @objc func addActionSheet() {
        ActionSheet.setActionSheet(superView: view, model: model, ensureClick: { item in
            switch item.title {
                case "copy":  print("copy")
                case "delete":  print("delete")
            default:
                break
            }
        }, cancel: {
            
        })
    }

    

}

