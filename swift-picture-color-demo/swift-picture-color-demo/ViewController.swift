//
//  ViewController.swift
//  swift-picture-color-demo
//
//  Created by 王潇 on 2022/4/15.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private var imageView: UIImageView!
    
    private var editColorBtn: UIButton!
    
    private var editColorView: EditColorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        imageView = UIImageView()
        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(144)
            make.left.right.equalToSuperview()
            make.height.equalTo(200)
        }
        imageView.image = UIImage(named: "1")
        imageView.contentMode = .scaleAspectFill
        
        editColorBtn = UIButton()
        view.addSubview(editColorBtn)
        editColorBtn.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(50)
            make.width.equalTo(100)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
        }
        editColorBtn.addTarget(self, action: #selector(getCurrentImage), for: .touchUpInside)
        
        editColorBtn.setImage(UIImage(named: "edit-color"), for: .normal)
        editColorBtn.setTitle("取色", for: .normal)
        editColorBtn.titleLabel?.font = .systemFont(ofSize: 12, weight: .bold)
        editColorBtn.setTitleColor(.black, for: .normal)
        editColorBtn.layer.borderWidth = 2
        editColorBtn.layer.borderColor = UIColor.black.cgColor
        editColorBtn.layer.cornerRadius = 16
        editColorBtn.layer.masksToBounds = true
        editColorBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
    }
    
    func getcurrentFramgeImage() -> UIImage {
        let size = imageView.bounds.size
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        let rect = imageView.bounds
        imageView.drawHierarchy(in: rect, afterScreenUpdates: true)
        let snapshotImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return snapshotImage
    }
    
    @objc func getCurrentImage() {
        editColorView = EditColorView()
        view.addSubview(editColorView)
        editColorView.snp.makeConstraints { make in
            make.top.equalTo(editColorBtn.snp.bottom).offset(20)
            make.left.right.equalToSuperview()
            make.height.equalTo(200)
        }
        let image = getcurrentFramgeImage()
        editColorView.currentImage = image
        editColorView.layoutIfNeeded()
        editColorView.firstInit()
    }
    
}

