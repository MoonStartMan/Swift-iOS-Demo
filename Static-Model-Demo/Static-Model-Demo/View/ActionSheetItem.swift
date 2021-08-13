//
//  ActionSheetItem.swift
//  Static-Model-Demo
//
//  Created by 王潇 on 2021/8/11.
//

import UIKit
import SnapKit

class ActionSheetItem: UIButton {
    var iconImage: String = "" {
        didSet {
            imageIconView.image = UIImage(named: iconImage)
        }
    }
    var title: String = "" {
        didSet {
            actionSheetLabel.text = title
        }
    }
    private var imageIconView: UIImageView!
    private var actionSheetLabel: UILabel!
    

    override init(frame: CGRect) {
        super.init(frame: .zero)
        imageIconView = UIImageView()
        self.addSubview(imageIconView)
        imageIconView.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(0)
            make.left.equalToSuperview().offset(16)
            make.width.height.equalTo(24)
        }
        
        actionSheetLabel = UILabel()
        self.addSubview(actionSheetLabel)
        actionSheetLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(0)
            make.left.equalTo(imageIconView.snp.right).offset(24)
            make.height.equalTo(18)
        }
        actionSheetLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        actionSheetLabel.textColor = UIColor.hex("#060606")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
