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
    
//    private var showBtn: UIButton = UIButton()
//
//    private var hideBtn: UIButton = UIButton()
    
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
        toggleView.selectBlock = { num in
            if num == 0 {
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
                    self.leftImageView.superview?.layoutIfNeeded()
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
                    self.rightImageView.superview?.layoutIfNeeded()
                }
            }
        }
        
//        view.addSubview(showBtn)
//        showBtn.snp.makeConstraints { make in
//            make.top.equalTo(200)
//            make.left.equalTo(16)
//            make.width.equalTo(100)
//            make.height.equalTo(30)
//        }
//        showBtn.setTitle("展示", for: .normal)
//        showBtn.backgroundColor = .hex("#000000", 0.6)
//        showBtn.setTitleColor(.hex("#FFFFFF"), for: .normal)
//        showBtn.layer.cornerRadius = 15
//        showBtn.layer.masksToBounds = true
//        showBtn.titleLabel?.font = .systemFont(ofSize: 12, weight: .bold)
//        showBtn.addTarget(self, action: #selector(showBtnClick), for: .touchUpInside)
//
//        view.addSubview(hideBtn)
//        hideBtn.snp.makeConstraints { make in
//            make.top.equalTo(200)
//            make.right.equalTo(-16)
//            make.width.equalTo(100)
//            make.height.equalTo(30)
//        }
//        hideBtn.setTitle("隐藏", for: .normal)
//        hideBtn.backgroundColor = .hex("#000000", 0.6)
//        hideBtn.setTitleColor(.hex("#FFFFFF"), for: .normal)
//        hideBtn.layer.cornerRadius = 15
//        hideBtn.layer.masksToBounds = true
//        hideBtn.titleLabel?.font = .systemFont(ofSize: 12, weight: .bold)
//        hideBtn.addTarget(self, action: #selector(hideBtnClick), for: .touchUpInside)
    }
    
//    @objc func showBtnClick() {
//        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut) {
//            self.toggleView.snp.updateConstraints { make in
//                make.bottom.equalToSuperview().offset(-34)
//            }
//            self.toggleView.superview?.layoutIfNeeded()
//        }
//    }
//
//    @objc func hideBtnClick() {
//        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0) {
//            self.toggleView.snp.updateConstraints { make in
//                make.bottom.equalToSuperview().offset(46)
//            }
//            self.toggleView.superview?.layoutIfNeeded()
//        }
//    }
    
}

