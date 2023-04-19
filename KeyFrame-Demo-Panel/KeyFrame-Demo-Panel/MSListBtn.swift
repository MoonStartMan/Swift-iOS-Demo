//
//  MSListBtn.swift
//  KeyFrame-Demo-Panel
//
//  Created by 王潇 on 2023/4/7.
//

import UIKit

import UIKit

class MSListBtn: UIButton {
    
    var imageName: String? {
        didSet {
            if let name = imageName {
                self.setImage(UIImage(named: name), for: .normal)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
