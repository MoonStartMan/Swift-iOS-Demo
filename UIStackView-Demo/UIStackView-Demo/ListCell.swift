//
//  ListCell.swift
//  UIStackView-Demo
//
//  Created by 王潇 on 2023/2/20.
//

import UIKit
import SnapKit

class ListCell: SwipeableCollectionViewCell {
    
    private let indexLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .black
        label.textAlignment = .right
        return label
    }()
    
    var model: ListData? {
        didSet {
            if let model = model {
                indexLabel.text = "\(model.index)"
                nameLabel.text = "\(model.name)"
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
        visibleContainerView.addSubview(indexLabel)
        visibleContainerView.addSubview(nameLabel)
        
        indexLabel.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.centerY.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints { make in
            make.right.equalTo(-16)
            make.centerY.equalToSuperview()
        }
    }
}
