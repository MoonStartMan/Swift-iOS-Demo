//
//  ViewController.swift
//  AutoLayout_StackView_Demo
//
//  Created by 王潇 on 2023/7/7.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private var topStackView: UIStackView = UIStackView()
    
    private var titleLabel: UILabel = UILabel()
    
    private var switchover: UISwitch = UISwitch()
    
    private var bottomStackView: UIStackView = UIStackView()
    
    private var imageView1: UIImageView = UIImageView()
    
    private var imageView2: UIImageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupView()
    }

    private func setupView() {
        topStackView.axis = .horizontal
        topStackView.alignment = .center
        topStackView.distribution = .fill
        topStackView.spacing = 16.0
        
        view.addSubview(topStackView)
        topStackView.snp.makeConstraints { make in
            make.top.equalTo(50)
            make.centerX.equalToSuperview()
            make.width.equalTo(150)
        }
        topStackView.addArrangedSubview(titleLabel)
        titleLabel.font = .systemFont(ofSize: 14.0, weight: .medium)
        titleLabel.text = "Horizontal"
        
        topStackView.addArrangedSubview(switchover)
        switchover.addTarget(self, action: #selector(axisChange(sender:)), for: .valueChanged)
        
        view.addSubview(bottomStackView)
        bottomStackView.axis = .horizontal
        bottomStackView.alignment = .center
        bottomStackView.distribution = .fill
        bottomStackView.spacing = 16.0
        bottomStackView.snp.makeConstraints { make in
            make.top.equalTo(topStackView.snp.bottom).offset(20)
            make.left.right.equalToSuperview()
        }
        bottomStackView.layer.borderWidth = 1.0
        bottomStackView.layer.borderColor = UIColor.black.cgColor
        
        bottomStackView.addArrangedSubview(imageView1)
        bottomStackView.addArrangedSubview(imageView2)
        imageView1.image = UIImage(named: "demo1")
        imageView1.contentMode = .scaleToFill
        imageView2.image = UIImage(named: "demo2")
        imageView2.contentMode = .scaleToFill
        
        imageView1.snp.makeConstraints { make in
            make.width.lessThanOrEqualTo(150)
            make.height.lessThanOrEqualTo(150)
        }
        
        imageView2.snp.makeConstraints { make in
            make.width.lessThanOrEqualTo(150)
            make.height.lessThanOrEqualTo(150)
        }
    }
    
    @objc func axisChange(sender: UISwitch) {
        if self.bottomStackView.axis == .horizontal {
            bottomStackView.axis = .vertical
            titleLabel.text = "Vertical"
        } else {
            bottomStackView.axis = .horizontal
            titleLabel.text = "Horizontal"
        }
        
        view.layoutIfNeeded()
    }

}

