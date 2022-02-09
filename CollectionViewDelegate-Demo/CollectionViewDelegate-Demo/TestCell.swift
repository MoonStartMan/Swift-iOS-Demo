//
//  TestCell.swift
//  CollectionViewDelegate-Demo
//
//  Created by 王潇 on 2022/2/8.
//

import UIKit
import SnapKit

class TestCell: UICollectionViewCell {
    
    private var label: UILabel!
    
    var model: TestModel? {
        didSet {
            label.text = model?.title
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        label = UILabel()
        contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(16)
        }
        
        label.textAlignment = .center
        label.textColor = .systemPink
        label.font = .systemFont(ofSize: 12)
        
        contentView.backgroundColor = .systemGray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
