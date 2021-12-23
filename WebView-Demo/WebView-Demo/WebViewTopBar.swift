//
//  WebViewTopBar.swift
//  WebView-Demo
//
//  Created by 王潇 on 2021/12/20.
//

import UIKit

class WebViewTopBar: UIView {
    
    typealias topBarLeftClick = () -> Void
    typealias topBarRightClick = () -> Void

    private var leftBtn: UIButton!
    private var titleLabel: UILabel!
    private var rightBtn: UIButton!
    
    var leftIconImage: UIImage? {
        didSet {
            if let image = leftIconImage {
                leftBtn.setImage(image, for: .normal)
                leftBtn.isHidden = false
            } else {
                leftBtn.isHidden = true
            }
        }
    }
    
    var rightIconImage: UIImage? {
        didSet {
            if let image = rightIconImage {
                rightBtn.setImage(image, for: .normal)
                rightBtn.isHidden = false
            } else {
                rightBtn.isHidden = true
            }
        }
    }
    
    var titleString: String? {
        didSet {
            if let title = titleString {
                titleLabel.text = title
                titleLabel.isHidden = false
            } else {
                titleLabel.isHidden = true
            }
        }
    }
    
    /// 左侧按钮点击事件
    var leftClickBlock: topBarLeftClick?
    /// 右侧按钮点击事件
    var rightClickBlock: topBarRightClick?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    func setupUI() {
        leftBtn = UIButton()
        addSubview(leftBtn)
        leftBtn.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.size.equalTo(CGSize(width: 44, height: 44))
            make.left.equalToSuperview().offset(16)
        }
        leftBtn.addTarget(self, action: #selector(leftClick), for: .touchUpInside)
        leftBtn.setImage(UIImage(named: "nav-bar-back-btn"), for: .normal)
        leftBtn.layer.borderColor = UIColor.black.cgColor
        leftBtn.layer.borderWidth = 1
        leftBtn.layer.cornerRadius = 6
        
        titleLabel = UILabel()
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(14)
        }
        titleLabel.font = .systemFont(ofSize: 14, weight: .bold)
        titleLabel.textColor = .black
            
        rightBtn = UIButton()
        addSubview(rightBtn)
        rightBtn.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16)
            make.top.equalTo(leftBtn.snp.top)
            make.size.equalTo(CGSize(width: 44, height: 44))
        }
        rightBtn.addTarget(self, action: #selector(rightClick), for: .touchUpInside)
        
    }
    
    @objc func leftClick() {
        leftClickBlock?()
    }
    
    @objc func rightClick() {
        rightClickBlock?()
    }
}
