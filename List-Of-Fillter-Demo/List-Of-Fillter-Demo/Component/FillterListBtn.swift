//
//  FillterBtn.swift
//  List-Of-Fillter-Demo
//
//  Created by 王潇 on 2021/9/2.
//

import UIKit

/// 按钮的圆角大小
fileprivate let conrnerRadius: CGFloat = 10
/// 按钮的边框宽度
fileprivate let btnBorderWidth: CGFloat = 0.5
/// 按钮边框的颜色
fileprivate let btnBorderColor: UIColor = UIColor.init(red: 0 / 255.0, green: 0 / 255.0, blue: 0 / 255.0, alpha: 0.06)

class FillterListBtn: UIButton {
    
    var imageName: String? {
        didSet {
            if let name = imageName {
                self.setImage(UIImage(named: name), for: .normal)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = conrnerRadius
        self.layer.borderColor = btnBorderColor.cgColor
        self.layer.borderWidth = btnBorderWidth
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
