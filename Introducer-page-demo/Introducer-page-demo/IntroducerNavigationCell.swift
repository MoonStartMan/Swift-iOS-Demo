//
//  IntroducerNavigationCell.swift
//  Introducer-page-demo
//
//  Created by 王潇 on 2022/11/16.
//

import UIKit

class IntroducerNavigationCell: UICollectionViewCell {
    
    private var circleView: UIView = UIView()
    
    var active: Bool = false {
        didSet {
            setActive(isActive: active)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(circleView)
        circleView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        circleView.layer.masksToBounds = true
        circleView.layer.cornerRadius = 3.0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setActive(isActive: Bool) {
        if isActive {
            circleView.backgroundColor = .white
            circleView.layer.borderColor = UIColor(red: 0.102, green: 0.102, blue: 0.102, alpha: 1).cgColor
            circleView.layer.borderWidth = 2.0
        } else {
            circleView.backgroundColor = UIColor(red: 0.941, green: 0.944, blue: 0.96, alpha: 1)
            circleView.layer.borderColor = UIColor.clear.cgColor
            circleView.layer.borderWidth = 0.0
        }
    }
}
