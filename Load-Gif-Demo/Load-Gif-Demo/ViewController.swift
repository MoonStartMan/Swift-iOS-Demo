//
//  ViewController.swift
//  Load-Gif-Demo
//
//  Created by 王潇 on 2022/2/15.
//

import UIKit
import SnapKit
import Kingfisher

class ViewController: UIViewController {
    
    private var imageView1: UIImageView = UIImageView()
    private var imageView2: UIImageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.addSubview(imageView1)
        imageView1.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(200)
            make.left.right.centerX.equalToSuperview()
            make.height.equalTo(200)
        }
        if let gifPath = Bundle.main.path(forResource: "1", ofType: "gif") {
            let url = URL(fileURLWithPath: gifPath)
            imageView1.kf.setImage(with: url, placeholder: UIImage(named: ""))
        }
        
        view.addSubview(imageView2)
        imageView2.snp.makeConstraints { make in
            make.top.equalTo(imageView1.snp.bottom).offset(100)
            make.left.right.centerX.equalToSuperview()
            make.height.equalTo(200)
        }
        
        if let gifPath = Bundle.main.path(forResource: "2", ofType: "gif") {
            let url = URL(fileURLWithPath: gifPath)
            imageView2.kf.setImage(with: url, placeholder: UIImage(named: ""))
        }
        
    }


}

