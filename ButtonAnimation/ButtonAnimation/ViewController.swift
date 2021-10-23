//
//  ViewController.swift
//  ButtonAnimation
//
//  Created by 王潇 on 2021/10/22.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private var btn: UIButton!
    /// 定义图层
    var pulseLayer: CAShapeLayer!
    /// 外部view
    var coverView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        
        coverView = UIView()
        self.view.addSubview(coverView)
        coverView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 324, height: 99))
        }
        coverView.layer.masksToBounds = true
        coverView.layer.cornerRadius = 24
        
        btn = UIButton()
        coverView.addSubview(btn)
        btn.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 300, height: 75))
            make.centerX.equalToSuperview()
        }
        btn.layer.cornerRadius = 16
        btn.layer.masksToBounds = false
        btn.backgroundColor = UIColor(red: 0.816, green: 0.996, blue: 0.094, alpha: 1)
        btn.setTitle("continue", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        btn.setTitleColor(UIColor(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        
        self.view.layoutSubviews()
        
        /// 动画图层
        pulseLayer = CAShapeLayer()
        pulseLayer.frame = CGRect(x: 0, y: 0, width: coverView.bounds.size.width, height: coverView.bounds.size.height)
        pulseLayer.backgroundColor = UIColor(red: 0.816, green: 0.996, blue: 0.094, alpha: 1).cgColor
        pulseLayer.opacity = 0.0
        coverView.layer.addSublayer(pulseLayer)
        coverView.layer.insertSublayer(pulseLayer, at: 0)
        starAnimation()
    }
    
    func starAnimation() {
        // 透明
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.fromValue = 0.2  // 起始值
        opacityAnimation.toValue = 0.6     // 结束值
        
        // 扩散动画
        let scaleAnimation = CABasicAnimation(keyPath: "transform")
        scaleAnimation.fromValue = NSValue(cgAffineTransform: CGAffineTransform(scaleX: 0.9, y: 0.9))
        scaleAnimation.toValue = NSValue(cgAffineTransform: CGAffineTransform(scaleX: 1.05, y: 1.05))
        
        // 给CAShapeLayer添加组合动画
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [opacityAnimation, scaleAnimation]
        groupAnimation.duration = 0.25  //持续时间
        groupAnimation.autoreverses = true //循环效果
        groupAnimation.repeatCount = HUGE
        pulseLayer.add(groupAnimation, forKey: nil)
    }
    
}

