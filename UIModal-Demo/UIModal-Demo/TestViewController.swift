//
//  TestViewController.swift
//  UIModal-Demo
//
//  Created by 王潇 on 2022/7/13.
//

import UIKit

class TestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemPink
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(backViewController))
        view.addGestureRecognizer(tap)
    }
    
    //  返回上一级
    @objc func backViewController() {
        let lastVC = self.presentingViewController
        lastVC?.dismiss(animated: true, completion: nil)
    }
    
    //  返回指定VC层级
    @objc func backController() {
        let lastVC = self.presentingViewController
        if let VC = lastVC {
            if VC.isKind(of: ViewController.self) {
                VC.dismiss(animated: true, completion: nil)
            }
        }
    }
    
}
