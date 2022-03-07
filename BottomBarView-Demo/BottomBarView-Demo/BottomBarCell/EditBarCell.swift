//
//  EditBarCell.swift
//  BottomBarView-Demo
//
//  Created by 王潇 on 2022/2/28.
//

import Foundation
import UIKit
import SnapKit

enum EditBarCellBtnType {
    //  复制
    case copy
    //  替换
    case replace
    //  左分割
    case leftCut
    //  中间分割
    case centerCut
    //  右分割
    case rightCut
    //  音量
    case volume
    //  删除
    case delete
    //  啥都不干
    case none
}

enum EditBarCellType {
    case icon
    case line
}

struct EditBarCellModel {
    var btnType: EditBarCellType
    var imageName: String
    var actionType: EditBarCellBtnType
    var isClick: Bool
}

class EditBarCell: UICollectionViewCell {
    typealias editClickBlock = (_ type: EditBarCellBtnType) -> Void

    private var btn: UIButton = UIButton()
    
    private var line: UIView = UIView()
    
    var btnClickBack: editClickBlock?
    
    var model: EditBarCellModel? {
        didSet {
            if let itemModel = model {
                let image = UIImage(named: itemModel.imageName)
                if itemModel.isClick {
                    btn.setImage(image?.withAlpha(1), for: .normal)
                    btn.isUserInteractionEnabled = true
                } else {
                    btn.setImage(image?.withAlpha(0.2), for: .normal)
                    btn.isUserInteractionEnabled = false
                }
                if itemModel.btnType == .icon {
                    line.removeFromSuperview()
                } else {
                    btn.removeFromSuperview()
                }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        btn = UIButton()
        addSubview(btn)
        btn.snp.makeConstraints({ make in
            make.edges.equalToSuperview()
        })
        btn.addTarget(self, action: #selector(sendClickType), for: .touchUpInside)
    
        line = UIView()
        addSubview(line)
        line.snp.makeConstraints({ make in
            make.height.equalTo(16)
            make.width.equalTo(1)
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        })
        line.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.06)
    }
    
    @objc func sendClickType() {
        if let type = model?.actionType {
            btnClickBack?(type)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
