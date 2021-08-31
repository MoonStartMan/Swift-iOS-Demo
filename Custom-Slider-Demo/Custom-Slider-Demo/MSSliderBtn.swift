//
//  NSSliderBtn.swift
//  Custom-Slider-Demo
//
//  Created by 王潇 on 2021/8/31.
//

import UIKit

class MSSliderBtn: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        return CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
