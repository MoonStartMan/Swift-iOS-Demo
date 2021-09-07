//
//  FillterValueView.swift
//  List-Of-Fillter-Demo
//
//  Created by 王潇 on 2021/9/2.
//

import UIKit
import SnapKit

/// 圆角
fileprivate let corneRadius: CGFloat = 10
/// border的宽度
fileprivate let borderWidth: CGFloat = 0.5
/// border的颜色
fileprivate let borderColor: UIColor = UIColor.init(red: 0 / 255.0, green: 0 / 255.0, blue: 0 / 255.0, alpha: 0.06)
/// 字体颜色
fileprivate let textColor: UIColor = UIColor.init(red: 26 / 255.0, green: 26 / 255.0, blue: 26 / 255.0, alpha: 1.0)
/// 字体大小
fileprivate let fontSize: CGFloat = 12.0

class FillterListValueView: UIView {
    /// 数值
    var changeValue: Int? {
        didSet {
            if let value = changeValue {
                valueLabel.text = "\(value)"
            }
        }
    }
    /// 数值Label
    private var valueLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        valueLabel = UILabel()
        self.addSubview(valueLabel)
        valueLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        valueLabel.font = .systemFont(ofSize: fontSize)
        valueLabel.textAlignment = .center
        valueLabel.textColor = textColor
        valueLabel.text = "\(changeValue ?? 0)"
        
        self.layer.cornerRadius = corneRadius
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
