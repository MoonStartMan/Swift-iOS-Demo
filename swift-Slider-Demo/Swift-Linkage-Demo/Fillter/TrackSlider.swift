//
//  TrackSlider.swift
//  Swift-Linkage-Demo
//
//  Created by 王潇 on 2021/8/25.
//

import UIKit

class TrackSlider: UISlider {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func minimumValueImageRect(forBounds bounds: CGRect) -> CGRect {
        return self.bounds
    }
    
    override func maximumValueImageRect(forBounds bounds: CGRect) -> CGRect {
        return self.bounds
    }
    
    //  设置UISlider的高度
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x, y: bounds.origin.y, width: bounds.size.width, height: 40)
    }
    
    override func thumbRect(forBounds bounds: CGRect, trackRect rect: CGRect, value: Float) -> CGRect {
        return super.thumbRect(forBounds: bounds, trackRect: rect, value: value)
    }
    
}
