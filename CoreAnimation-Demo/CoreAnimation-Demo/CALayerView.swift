//
//  CALayerView.swift
//  CoreAnimation-Demo
//
//  Created by 王潇 on 2023/3/6.
//

import UIKit

class CALayerView: UIView {
    
    private var translateView: UIView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(translateView)
        translateView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        translateView.backgroundColor = .systemPink
    }
    
    ///  设置中心点的旋转
    func setAnchorPoint() {
        translateView.layer.anchorPoint = CGPoint(x: 0, y: 0)
        UIView.animate(withDuration: 3.0, delay: 0) {
            self.translateView.layer.transform = CATransform3DMakeRotation(.pi, 0, 0, 1)
        } completion: { finish in
            if finish {
                UIView.animate(withDuration: 3.0, delay: 0) {
                    self.translateView.layer.transform = CATransform3DMakeRotation(.pi * 2, 0, 0, 1)
                }
            }
        }
    }
    
    /// 设置圆角变化动画
    func setCornerRadius() {
        translateView.layer.masksToBounds = true
        translateView.layer.cornerRadius = 200
        UIView.animate(withDuration: 3.0, delay: 0.0) {
            self.translateView.layer.cornerRadius = 20
        }
    }
    
    /// 设置阴影
    func setShadow() {
        UIView.animate(withDuration: 3.0, delay: 0) {
            self.translateView.layer.shadowOffset = CGSize(width: 15, height: 20)
            self.translateView.layer.shadowOpacity = 0.6
        }
    }
    
    /// 设置阴影ShadowPath
    func setShadowPath() {
        UIView.animate(withDuration: 3.0, delay: 0) {
            self.translateView.layer.shadowOpacity = 1.0
            self.translateView.layer.shadowOffset = CGSize(width: 20, height: 20)
            let shadowHeight: CGFloat = 20.0
            let shadowPath = CGPath(ellipseIn: CGRect(x: -shadowHeight,
                                                      y: self.translateView.layer.bounds.size.height,
                                                      width: self.translateView.layer.bounds.width,
                                                      height: shadowHeight),
                                    transform: nil)
            self.translateView.layer.shadowPath = shadowPath
        }
    }
    
    /// 设置Contents
    func setContents() {
        translateView.layer.opacity = 0.0
        UIView.animate(withDuration: 3.0, delay: 0) {
            self.translateView.layer.contents = UIImage(named: "scenery")?.cgImage
            self.translateView.layer.cornerRadius = 20
            self.translateView.layer.masksToBounds = true
            self.translateView.layer.opacity = 1.0
        }
    }
    
}
