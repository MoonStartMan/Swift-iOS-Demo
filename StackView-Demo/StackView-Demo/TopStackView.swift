//
//  TopStackView.swift
//  StackView-Demo
//
//  Created by 王潇 on 2023/6/28.
//

import UIKit

class TopStackView: UIStackView {
    
    private let leftBtn: UIButton = UIButton()

    private let titleLabel: UILabel = UILabel()
    
    private let rightBtn: UIButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addArrangedSubview(leftBtn)
        addArrangedSubview(titleLabel)
        addArrangedSubview(rightBtn)
        
        leftBtn.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.top.equalTo(20)
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
        leftBtn.setTitle("Left Btn", for: .normal)
        leftBtn.layer.cornerRadius = 15
        leftBtn.layer.masksToBounds = true
        leftBtn.backgroundColor = .black
        leftBtn.setTitleColor(.white, for: .normal)
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
        }
        titleLabel.font = .systemFont(ofSize: 14.0, weight: .bold)
        titleLabel.textColor = .black
        titleLabel.text = "TopStackView"
        titleLabel.textAlignment = .center
        
        rightBtn.snp.makeConstraints { make in
            make.right.equalTo(-16)
            make.top.equalTo(20)
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
        rightBtn.setTitle("Right Btn", for: .normal)
        rightBtn.layer.cornerRadius = 15
        rightBtn.layer.masksToBounds = true
        rightBtn.backgroundColor = .black
        rightBtn.setTitleColor(.white, for: .normal)
    }
}
