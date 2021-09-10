//
//  ChildCell.swift
//  Dynamic-Material-List-Demo
//
//  Created by 王潇 on 2021/9/10.
//

import UIKit
import SnapKit

/// 圆角大小
private let cornerRadius: CGFloat = 10
/// 字体大小
private let fontSize: UIFont = .systemFont(ofSize: 12)
/// 字体颜色
private let fontColor: UIColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0)
/// cell背景色
private let bgColor: UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)

class ChildCell: UICollectionViewCell {
    
    /// 文字Label
    private var textLabel: UILabel!
    /// 文字内容
    var textString: String = "" {
        didSet {
            textLabel.text = textString
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        UIConfig()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ChildCell {
    func UIConfig() {
        textLabel = UILabel()
        self.addSubview(textLabel)
        textLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(56)
            make.centerX.equalToSuperview()
            make.height.equalTo(12)
        }
        textLabel.font = fontSize
        textLabel.textColor = fontColor
        
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
        self.backgroundColor = bgColor
    }
}
