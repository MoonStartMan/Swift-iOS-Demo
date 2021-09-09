//
//  MSListBtn.swift
//  Effect-List-Demo
//
//  Created by 王潇 on 2021/9/8.
//

import UIKit

/// 按钮的圆角大小
private let conrnerRadius: CGFloat = 10
/// 按钮的边框宽度
private let btnBorderWidth: CGFloat = 0.5
/// 按钮边框的颜色
private let btnBorderColor: UIColor = UIColor.hex("#000000", 0.06)

class MSListBtn: UIButton {
    /// 图片名称
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
