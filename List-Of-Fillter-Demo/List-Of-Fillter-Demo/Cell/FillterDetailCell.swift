//
//  FillterDetailCell.swift
//  List-Of-Fillter-Demo
//
//  Created by 王潇 on 2021/9/1.
//

import UIKit
import SnapKit
import Kingfisher

class FillterDetailCell: UICollectionViewCell {
    
    /// 图片圆角大小
    let fillterCornerRadius: CGFloat = 10
    /// cell的文字大小
    let fontSize: CGFloat = 10
    /// 文字框的高度
    let textHeight: CGFloat = 18
    
    /// 状态栏覆盖层
    private var coverView: UIView!
    /// 状态栏文字
    private var coverLabel: UILabel!
    /// 图片
    private var fillterImage: UIImageView!
    /// 文字遮罩层
    private var fillterCover: UIView!
    /// 文字label
    private var fillterNameLabel: UILabel!
    /// model
    var model: FillterListModelItem? {
        didSet {
            fillterNameLabel.text = model?.fillterName
            if let url = URL(string: model?.imageUrl ?? "") {
                fillterImage.kf.setImage(with: url)
            }
            if (model?.isUpdate == false) {
                coverView.isHidden = true
            } else {
                coverView.isHidden = false
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        uiConfig()
    }
    
    func uiConfig() {
        self.layer.cornerRadius = fillterCornerRadius
        self.layer.masksToBounds = true
        self.backgroundColor = .systemGray
        
        fillterImage = UIImageView()
        self.addSubview(fillterImage)
        fillterImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        fillterImage.contentMode = .scaleAspectFill
        
        fillterCover = UIView()
        self.addSubview(fillterCover)
        fillterCover.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(textHeight)
        }
        fillterCover.backgroundColor = UIColor.init(red: 255 / 255.0, green: 255 / 255.0, blue: 255 / 255.0, alpha: 0.1)
        
        fillterNameLabel = UILabel()
        fillterCover.addSubview(fillterNameLabel)
        fillterNameLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(fontSize)
            make.centerY.equalToSuperview()
        }
        
        fillterNameLabel.textColor = UIColor.init(red: 255 / 255.0, green: 255 / 255.0, blue: 255 / 255.0, alpha: 1.0)
        fillterNameLabel.font = .systemFont(ofSize: fontSize)
        fillterNameLabel.textAlignment = .center
        
        coverView = UIView()
        self.addSubview(coverView)
        coverView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        coverView.backgroundColor = UIColor(red: 0 / 255, green: 0 / 255, blue: 0 / 255, alpha: 0.6)
        coverView.isHidden = true
        
        coverLabel = UILabel()
        coverView.addSubview(coverLabel)
        coverLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(12)
            make.width.equalToSuperview()
        }
        coverLabel.text = "需更新"
        coverLabel.font = .systemFont(ofSize: 10)
        coverLabel.textColor = .white
        coverLabel.textAlignment = .center
    }
    
    /// 切换激活态
    func changeActive(isActive: Bool) {
        if isActive {
            self.layer.borderWidth = 2
            self.layer.borderColor = UIColor.init(red: 0.102 / 255.0, green: 0.102 / 255.0, blue: 0.102 / 255.0, alpha: 1.0).cgColor
        } else {
            self.layer.borderWidth = 0
            self.layer.borderColor = UIColor.init(red: 0.102 / 255.0, green: 0.102 / 255.0, blue: 0.102 / 255.0, alpha: 0).cgColor
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
