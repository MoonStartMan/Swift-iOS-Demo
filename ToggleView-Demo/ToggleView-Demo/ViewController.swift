//
//  ViewController.swift
//  ToggleView-Demo
//
//  Created by 王潇 on 2023/2/14.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private var toggleView: MSMultiEffectToggleView = MSMultiEffectToggleView()
    
    private var leftImageView: UIImageView = UIImageView()
    
    private var rightImageView: UIImageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .hex("#000000")
        
        view.addSubview(leftImageView)
        leftImageView.snp.makeConstraints { make in
            make.top.equalTo(34)
            make.left.equalToSuperview()
            make.bottom.equalTo(-34)
            make.width.equalToSuperview().multipliedBy(0.5)
        }
        leftImageView.image = UIImage(named: "1")
        leftImageView.contentMode = .scaleAspectFit
        leftImageView.alpha = 0
        
        view.addSubview(rightImageView)
        rightImageView.snp.makeConstraints { make in
            make.top.equalTo(34)
            make.right.equalToSuperview()
            make.bottom.equalTo(-34)
            make.width.equalToSuperview().multipliedBy(0.5)
        }
        rightImageView.image = UIImage(named: "2")
        rightImageView.contentMode = .scaleAspectFit
        rightImageView.alpha = 0
        
        view.addSubview(toggleView)
        toggleView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-34)
            make.width.equalTo(186)
            make.height.equalTo(46)
            make.centerX.equalToSuperview()
        }
        toggleView.selectBlock = { [weak self] num in
            print("\(num)")
            
            self?.setCurrentShow(index: num, layout: true)
        }
        
        toggleView.setCurrentActive(index: 0)
        setCurrentShow(index: 0, layout: false)
    }
    
    private func setCurrentShow(index: Int, layout: Bool) {
        if index == 0 {
            UIView.animate(withDuration: 2) {
                self.leftImageView.snp.remakeConstraints { make in
                    make.top.equalTo(34)
                    make.centerX.equalToSuperview()
                    make.bottom.equalTo(-34)
                    make.width.equalToSuperview().multipliedBy(0.8)
                }
                self.rightImageView.snp.remakeConstraints { make in
                    make.top.equalTo(34)
                    make.right.equalToSuperview()
                    make.bottom.equalTo(-34)
                    make.width.equalToSuperview().multipliedBy(0.5)
                }
                self.leftImageView.alpha = 1
                self.rightImageView.alpha = 0
                if layout {
                    self.leftImageView.superview?.layoutIfNeeded()
                }
            }
        } else {
            UIView.animate(withDuration: 2) {
                self.leftImageView.snp.remakeConstraints { make in
                    make.top.equalTo(34)
                    make.left.equalToSuperview()
                    make.bottom.equalTo(-34)
                    make.width.equalToSuperview().multipliedBy(0.5)
                }
                self.rightImageView.snp.remakeConstraints { make in
                    make.top.equalTo(34)
                    make.centerX.equalToSuperview()
                    make.bottom.equalTo(-34)
                    make.width.equalToSuperview().multipliedBy(0.8)
                }
                self.leftImageView.alpha = 0
                self.rightImageView.alpha = 1
                if layout {
                    self.rightImageView.superview?.layoutIfNeeded()
                }
            }
        }
    }
    
}

