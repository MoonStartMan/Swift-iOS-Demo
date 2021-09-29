//
//  ViewController.swift
//  Layer-shadow-Demo
//
//  Created by 王潇 on 2021/9/28.
//

import UIKit

class ViewController: UIViewController {

    private var shadowView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        shadowView = UIView(frame: CGRect(x: (self.view.frame.size.width - 200) / 2, y: (self.view.frame.size.height - 200) / 2, width: 200, height: 200))
        
        shadowView.backgroundColor = .white
        shadowView.layer.cornerRadius = 20
        
        shadowView.layer.shadowColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.05).cgColor
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 4)
        shadowView.layer.shadowOpacity = 1
        shadowView.layer.shadowRadius = 30
        
        self.view.addSubview(shadowView)
        
        
    }


}

