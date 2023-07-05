//
//  ListCell.swift
//  Slider-Show-Demo
//
//  Created by 王潇 on 2023/7/5.
//

import UIKit
import SnapKit

class ListCell: UICollectionViewCell {
    
    private var coverView: UIView = UIView()
    
    var currentColor: UIColor? {
        didSet {
            if let currentColor = currentColor {
                coverView.backgroundColor = currentColor
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.addSubview(coverView)
        coverView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        coverView.layer.cornerRadius = 20.0
        coverView.layer.masksToBounds = true
    }
}
