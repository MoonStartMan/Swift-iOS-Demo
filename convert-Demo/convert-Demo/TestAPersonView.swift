//
//  TestAPersonView.swift
//  convert-Demo
//
//  Created by 王潇 on 2022/2/15.
//

import UIKit
import SnapKit

class TestAPersonView: UIView {
    
    var clickBtn: UIButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(clickBtn)
        clickBtn.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        clickBtn.setImage(UIImage(named: "iocn1"), for: .normal)
        clickBtn.imageView?.contentMode = .scaleToFill
        clickBtn.backgroundColor = .clear
        clickBtn.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
