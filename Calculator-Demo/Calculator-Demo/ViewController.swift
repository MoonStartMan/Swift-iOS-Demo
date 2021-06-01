//
//  ViewController.swift
//  Calculator-Demo
//
//  Created by 王潇 on 2021/5/25.
//

import UIKit

class ViewController: UIViewController {

    var digitalView: UIView?
    
    var backgroundView: UIView?
    
    var digitalLabel: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.backgroundView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        self.view.addSubview(self.backgroundView!)
        self.backgroundView?.backgroundColor = UIColor.black
        
        self.digitalView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.size.width, height: 200))
        self.digitalView?.backgroundColor = UIColor.black
        self.view.addSubview(self.digitalView!)
        
        self.digitalLabel = UILabel.init(frame: CGRect.init(x: 0, y: 100, width: self.view.frame.size.width, height: 100))
        self.digitalView?.addSubview(self.digitalLabel!)
        self.digitalLabel?.text = "0"
        self.digitalLabel?.font = UIFont.systemFont(ofSize: 100)
        self.digitalLabel?.textColor = UIColor.white
        self.digitalLabel?.textAlignment = NSTextAlignment.right
    }
}

