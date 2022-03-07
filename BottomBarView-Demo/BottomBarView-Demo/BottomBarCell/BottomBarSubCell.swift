//
//  BottomBarSubCell.swift
//  BottomBarView-Demo
//
//  Created by 王潇 on 2022/3/1.
//

import UIKit
import SnapKit

enum BottomBarBtnType {
    /// 编辑
    case edit
    /// 变换
    case transform
    /// 预设
    case preset
    /// 混合模式
    case blend
    /// 编组
    case group
    /// 进入编组
    case ingroup
    /// 取消编组
    case ungroup
    /// 淡入淡出
    case fade
}

class BottomBarSubCell: UICollectionViewCell {
    
    private var imageView: UIImageView = UIImageView()
    
    private var iconName: UILabel = UILabel()
    
    var model: BottomBarCellModel? {
        didSet {
            if let itemModel = model {
                imageView.image = UIImage(named: itemModel.imageName)
                iconName.text = itemModel.titleName
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.height.equalTo(24)
            make.top.equalToSuperview().offset(8)
        }
        
        contentView.addSubview(iconName)
        iconName.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(2)
            make.height.equalTo(12)
        }
        iconName.font = .systemFont(ofSize: 12, weight: .bold)
        iconName.textColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
        iconName.textAlignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

struct BottomBarCellModel {
    var imageName: String
    var titleName: String
}
