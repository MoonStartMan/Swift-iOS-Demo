//
//  NavigationView.swift
//  swift-navigation-demo
//
//  Created by 王潇 on 2021/10/5.
//

import UIKit
import SnapKit

private let margin: CGFloat = 16

private let btnSize: CGSize = CGSize(width: 44, height: 44)

private let corneRadius: CGFloat = 16

class NavigationView: UIView {
    
    typealias topBarLeftClick = () -> Void
    typealias topBarRightClick = () -> Void

    private var leftBtn: UIButton!
    private var rightBtn: UIButton!
    private var titleLabel: UILabel!
    
    /// 左侧按钮点击事件
    var leftClick: topBarLeftClick?
    /// 右侧按钮点击事件
    var rightClick: topBarRightClick?
    /// 标题
    var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }
    /// 左侧按钮背景颜色
    var leftBtnBgColor: UIColor = .white {
        didSet {
            leftBtn.backgroundColor = leftBtnBgColor
        }
    }
    /// 右侧按钮背景颜色
    var rightBtnBgColor: UIColor = .white {
        didSet {
            rightBtn.backgroundColor = rightBtnBgColor
        }
    }
    /// 左侧图片
    var leftIcon: UIImage = UIImage() {
        didSet {
            leftBtn.setImage(leftIcon, for: .normal)
        }
    }
    /// 右侧图片
    var rightIcon: UIImage = UIImage() {
        didSet {
            rightBtn.setImage(rightIcon, for: .normal)
        }
    }
    
    convenience init() {
        self.init(frame: CGRect(x: 0, y: 44, width: UIScreen.main.bounds.size.width, height: 56))
        self.backgroundColor = .systemPink
        setUI()
    }
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        leftBtn = UIButton()
        self.addSubview(leftBtn)
        leftBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(margin)
            make.centerY.equalToSuperview()
            make.size.equalTo(btnSize)
        }
        leftBtn.layer.cornerRadius = corneRadius
        leftBtn.layer.masksToBounds = true
        leftBtn.backgroundColor = .yellow
        leftBtn.addTarget(self, action: #selector(leftClickEvent), for: .touchUpInside)
        
        rightBtn = UIButton()
        self.addSubview(rightBtn)
        rightBtn.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-margin)
            make.centerY.equalToSuperview()
            make.size.equalTo(btnSize)
        }
        rightBtn.layer.cornerRadius = corneRadius
        rightBtn.layer.masksToBounds = true
        rightBtn.backgroundColor = .yellow
        rightBtn.addTarget(self, action: #selector(rightClickEvent), for: .touchUpInside)
        
        titleLabel = UILabel()
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(17)
        }
        titleLabel.font = .systemFont(ofSize: 14, weight: .bold)
        titleLabel.textColor = UIColor(red: 0.024, green: 0.024, blue: 0.024, alpha: 1.0)
        titleLabel.textAlignment = .center
    }
    
}

extension NavigationView {
    @objc func leftClickEvent() {
        leftClick?()
    }
    
    @objc func rightClickEvent() {
        rightClick?()
    }
}
