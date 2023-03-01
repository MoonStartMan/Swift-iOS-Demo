//
//  MSEffectUpgardeTextCell.swift
//  Effect-PopView
//
//  Created by 王潇 on 2023/2/28.
//

import UIKit

class MSEffectUpgardeTextCell: UITableViewCell {
    
    var model: MSEffectUpgradeModel? {
        didSet {
            if let model = model {
                imageView?.image = UIImage(named: model.iconName)
                titleLabel.text = model.title
                lineView.isHidden = model.showUnderline
            }
        }
    }
    
    private var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "effect")
        return imageView
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .hex("#FFFFFF")
        return label
    }()
    
    private var tipsView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 4
        view.backgroundColor = .hex("#D0FE18", 0.1)
        return view
    }()
    
    private var tipsLabel: UILabel = {
        let label = UILabel()
        label.text = "升级"
        label.textColor = .hex("#D0FE18")
        label.font = .systemFont(ofSize: 10, weight: .bold)
        return label
    }()
    
    private var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .hex("#FFFFFF", 0.1)
        view.isHidden = true
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.backgroundColor = .hex("#1A1A1A")
        
        contentView.addSubview(iconImageView)
        iconImageView.snp.makeConstraints { make in
            make.left.equalTo(24)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(iconImageView.snp.right).offset(4)
            make.centerY.equalToSuperview()
        }
        
        contentView.addSubview(tipsView)
        tipsView.snp.makeConstraints { make in
            make.right.equalTo(-24)
            make.height.equalTo(18)
            make.width.equalTo(28)
            make.centerY.equalToSuperview()
        }
        
        tipsView.addSubview(tipsLabel)
        tipsLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        contentView.addSubview(lineView)
        lineView.snp.makeConstraints { make in
            make.top.equalTo(iconImageView.snp.bottom).offset(12)
            make.left.equalTo(24)
            make.right.equalTo(-24)
            make.height.equalTo(0.5)
        }
    }
}
