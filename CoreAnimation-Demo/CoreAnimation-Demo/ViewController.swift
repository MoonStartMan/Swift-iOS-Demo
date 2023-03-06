//
//  ViewController.swift
//  CoreAnimation-Demo
//
//  Created by 王潇 on 2023/3/6.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private var calayerView: CALayerView = CALayerView()
    
    private var cgaffineTransFromView: CGAffineTransformView = CGAffineTransformView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        DoCGAffineTransformView()
    }
}

extension ViewController {
    /// CALayer Demo
    func DoCALayerView() {
        view.addSubview(calayerView)
        calayerView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(100)
        }
        
        calayerView.setContents()
    }
    
    /// CGAffineTransform Demo
    func DoCGAffineTransformView() {
        view.addSubview(cgaffineTransFromView)
        cgaffineTransFromView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(100)
        }
    }
}
