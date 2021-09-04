//
//  MenuCell.swift
//  List-Of-Fillter-Demo
//
//  Created by 王潇 on 2021/9/1.
//

import UIKit
import SnapKit

class MenuCell: UICollectionViewCell {
    
    /// 文字
    private var menuLabel: UILabel!
    /// 是否点击状态
    private var isActive: Bool?
    /// 文字大小
    let fontSize: CGFloat = 12
    /// model
    var model: FillterListModel? {
        didSet {
            menuLabel.text = model?.fillterTitle
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        menuLabel = UILabel()
        self.contentView.addSubview(menuLabel)
        menuLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        menuLabel.textColor = UIColor(red: 153/255.0, green: 153/255.0, blue: 153/255.0, alpha: 1.0)
        menuLabel.font = .systemFont(ofSize: fontSize)
        menuLabel.textAlignment = .center
    }
    
    /// 切换激活态
    func changeActive(isActive: Bool) {
        if isActive {
            menuLabel.textColor = UIColor(red: 34/255.0, green: 34/255.0, blue: 34/255.0, alpha: 1.0)
        } else {
            menuLabel.textColor = UIColor(red: 153/255.0, green: 153/255.0, blue: 153/255.0, alpha: 1.0)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
