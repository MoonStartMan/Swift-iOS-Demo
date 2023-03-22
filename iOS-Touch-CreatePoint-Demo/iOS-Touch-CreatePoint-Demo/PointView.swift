//
//  PointView.swift
//  iOS-Touch-CreatePoint-Demo
//
//  Created by 王潇 on 2023/3/21.
//

import UIKit

class PointView: UIView {
    
    static let pointWidth: CGFloat = 48.0
    
    static let pointHeight: CGFloat = 48.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //  点击创建光标
    private func setupView() {
        alpha = 0.0
        layer.masksToBounds = true
        layer.cornerRadius = PointView.pointHeight / 2.0
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 2.0
        backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.15)
    }
    
    //  点击显示动画
    func touchAnimation() {
        let width = self.frame.size.width
        let height = self.frame.size.height
        UIView.animate(withDuration: 0.1, delay: 0) { [weak self] in
            self?.alpha = 1.0
            self?.frame.size = CGSize(width: width * 0.75, height: height * 0.75)
            self?.layer.cornerRadius = PointView.pointHeight / 2.0 * 0.75
        }
        self.layoutIfNeeded()
    }
    
    func touchesDissmis() {
        let width = self.frame.size.width
        let height = self.frame.size.height
        UIView.animate(withDuration: 0.1, delay: 0) { [weak self] in
            self?.alpha = 0.0
            self?.frame.size = CGSize(width: width, height: height)
            self?.layer.cornerRadius = PointView.pointHeight / 2.0
            self?.removeFromSuperview()
        }
        self.layoutIfNeeded()
    }
}
