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
    var menuLabel: UILabel!
    /// 是否点击状态
    var isActive: Bool?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        menuLabel = UILabel()
        self.addSubview(menuLabel)
        menuLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        menuLabel.textColor = UIColor(red: 153/255.0, green: 153/255.0, blue: 153/255.0, alpha: 1.0)
        menuLabel.font = UIFont(name: "Montserrat-Medium", size: 12)
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
