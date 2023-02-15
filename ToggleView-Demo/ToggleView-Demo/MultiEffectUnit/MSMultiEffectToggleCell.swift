//
//  MSMultiEffectToggleItemView.swift
//  Aries
//
//  Created by 王潇 on 2023/2/14.
//

import UIKit
import SnapKit

fileprivate let margin: CGFloat = 4

class MSMultiEffectToggleCell: UICollectionViewCell {
    
    var model: MSToggleItemModel? {
        didSet {
            if let model = model {
                iconImage.image = UIImage(named: model.image)
                titleLabel.text = model.name
            }
        }
    }
    
    private lazy var iconImage: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .hex("#1A1A1A", 0.7)
//        label.font = .i18n(font: .PingFangSC_Medium, size: 14.0)
        label.font = .systemFont(ofSize: 14, weight: .black)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        contentView.addSubview(iconImage)
        iconImage.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.centerY.equalToSuperview()
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(iconImage.snp.right)
        }
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    func setActive(active: Bool, ifLayout: Bool) {
        addAnimation(isActive: active, ifLayout: ifLayout)
    }
    
    private func addAnimation(isActive: Bool, ifLayout: Bool) {
        if isActive {
            UIView.animate(withDuration: 0.3) {
                self.iconImage.alpha = 1
                self.titleLabel.textColor = .hex("#1A1A1A")
                self.titleLabel.snp.remakeConstraints { make in
                    make.centerY.equalToSuperview()
                    make.left.equalTo(self.iconImage.snp.right)
                }
                self.titleLabel.sizeToFit()
                let size = self.iconImage.frame.size.width + margin + self.titleLabel.frame.size.width
                let currentContentSize = self.contentView.frame.size.width
                self.iconImage.snp.remakeConstraints { make in
                    make.left.equalTo((currentContentSize - size) / 2.0)
                    make.centerY.equalToSuperview()
                    make.width.height.equalTo(24)
                }
                self.titleLabel.snp.makeConstraints { make in
                    make.right.equalTo(-(currentContentSize - size) / 2.0)
                    make.centerY.equalToSuperview()
                }
                if ifLayout {
                    self.layoutIfNeeded()
                }
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                self.iconImage.alpha = 0
                self.titleLabel.textColor = .hex("#1A1A1A", 0.7)
                self.titleLabel.snp.remakeConstraints { make in
                    make.center.equalToSuperview()
                }
                if ifLayout {
                    self.layoutIfNeeded()
                }
            }
        }
    }
}
