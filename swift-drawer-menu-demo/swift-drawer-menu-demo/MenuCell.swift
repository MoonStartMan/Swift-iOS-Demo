//
//  MenuCell.swift
//  swift-drawer-menu-demo
//
//  Created by 王潇 on 2022/10/17.
//

import UIKit

class MenuCell: UICollectionViewCell {
    
    private var textLabel: UILabel = UILabel()
    
    private var checkIcon: UIImageView = UIImageView()
    
    private var disableView: UIView = UIView()
    
    var model: ResolutionMultipleModel? {
        didSet {
            if let model = model {
                textLabel.text = model.title
                checkIcon.isHidden = !model.isSelect
                setActive(isActive: model.isSelect)
                isUserInteractionEnabled = model.isCheck
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
        contentView.addSubview(textLabel)
        textLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(12)
        }
        textLabel.font = .systemFont(ofSize: 12, weight: .medium)
        textLabel.textColor = UIColor(red: 0.102, green: 0.102, blue: 0.102, alpha: 1.0)
        
        contentView.addSubview(checkIcon)
        checkIcon.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-12)
        }
        checkIcon.image = UIImage(named: "check")
        checkIcon.isHidden = true
    }
    
    private func setActive(isActive: Bool) {
        if isActive {
            contentView.backgroundColor = UIColor(red: 0.969, green: 0.969, blue: 0.969, alpha: 1)
        } else {
            contentView.backgroundColor = .clear
        }
    }
}
