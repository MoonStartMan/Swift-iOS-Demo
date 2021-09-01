//
//  FillterDetailCell.swift
//  List-Of-Fillter-Demo
//
//  Created by 王潇 on 2021/9/1.
//

import UIKit
import SnapKit

class FillterDetailCell: UICollectionViewCell {
    
    /// 图片圆角大小
    let fillterCornerRadius: CGFloat = 5
    /// 图片的高度
    let fillterHeight: CGFloat = 60
    /// 图片的边框长
    let borderWidth: CGFloat = 1
    /// 文字与图片距离
    let marginTop: CGFloat = 10
    /// cell的文字大小
    let fontSize: CGFloat = 14
    
    private var fillterImage: UIImageView!
    private var fillterName: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        fillterImage = UIImageView()
        self.addSubview(fillterImage)
        fillterImage.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(fillterHeight)
        }
        fillterImage.layer.cornerRadius = fillterCornerRadius
        fillterImage.layer.masksToBounds = true
        fillterImage.layer.borderColor = UIColor.init(red: 0 / 255.0, green: 0 / 255.0, blue: 0 / 255.0, alpha: 1.0).cgColor
        fillterImage.layer.borderWidth = borderWidth
        
        fillterName = UILabel()
        self.addSubview(fillterName)
        fillterName.snp.makeConstraints { make in
            make.top.equalTo(fillterImage.snp.bottom).offset(marginTop)
            make.left.right.equalToSuperview()
            make.height.equalTo(fontSize)
        }
        
        fillterName.textColor = UIColor.init(red: 0 / 255.0, green: 0 / 255.0, blue: 0 / 255.0, alpha: 1.0)
        fillterName.font = .systemFont(ofSize: fontSize)
        fillterName.textAlignment = .center
    }
    
    /// 切换激活态
    func changeActive(isActive: Bool) {
        if isActive {
            fillterImage.layer.borderColor = UIColor(red: 163/255.0, green: 69/255.0, blue: 255/255.0, alpha: 1.0).cgColor
            fillterName.textColor = UIColor(red: 163/255.0, green: 69/255.0, blue: 255/255.0, alpha: 1.0)
        } else {
            fillterImage.layer.borderColor = UIColor.init(red: 0 / 255.0, green: 0 / 255.0, blue: 0 / 255.0, alpha: 1.0).cgColor
            fillterName.textColor = UIColor.init(red: 0 / 255.0, green: 0 / 255.0, blue: 0 / 255.0, alpha: 1.0)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
