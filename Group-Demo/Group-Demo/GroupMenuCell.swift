//
//  GroupMenuCell.swift
//  Group-Demo
//
//  Created by 王潇 on 2022/3/4.
//

import UIKit
import SnapKit

class GroupMenuCell: UICollectionViewCell {
    typealias gropuMenuClickBlock = (_ value: Int) -> Void
    
    var textString: String = "" {
        didSet {
            textLabel.text = textString
        }
    }
    
    var id: String = "" {
        didSet {
            
        }
    }
    
    var isActive: Bool = false {
        didSet {
            changeState(isActive: isActive)
        }
    }
    
    var menuClickBack: gropuMenuClickBlock?
    
    private var coverView: UIView = UIView()
    
    private var textLabel: UILabel = UILabel()
    
    private var imageView: UIImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview()
            make.width.height.equalTo(16)
        }
        imageView.image = UIImage(named: "group_left_icon")
        
        contentView.addSubview(coverView)
        coverView.snp.makeConstraints { make in
            make.left.equalTo(imageView.snp.right)
            make.top.bottom.equalToSuperview()
        }
        
        coverView.addSubview(textLabel)
        textLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-8)
            make.top.bottom.equalToSuperview()
        }
        
        textLabel.textAlignment = .center
        textLabel.textColor = UIColor(red: 0.102, green: 0.102, blue: 0.102, alpha: 1)
        textLabel.font = .systemFont(ofSize: 10, weight: .bold)
        coverView.layer.cornerRadius = 13
        coverView.layer.masksToBounds = true
        coverView.backgroundColor = UIColor(red: 0.969, green: 0.969, blue: 0.969, alpha: 1)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changeState(isActive: Bool) {
        if isActive {
            coverView.backgroundColor = UIColor(red: 0.102, green: 0.102, blue: 0.102, alpha: 1)
            textLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        } else {
            coverView.backgroundColor = UIColor(red: 0.969, green: 0.969, blue: 0.969, alpha: 1)
            textLabel.textColor = UIColor(red: 0.102, green: 0.102, blue: 0.102, alpha: 1)
        }
    }
    
}
