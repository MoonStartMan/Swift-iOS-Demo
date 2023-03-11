//
//  ReflectionView.swift
//  CoreAnimation-Demo
//
//  Created by 王潇 on 2023/3/8.
//

import UIKit

class ReflectionView: UIView {

    override class var layerClass: AnyClass {
        return CAReplicatorLayer.self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = .systemPink
        
        let layer = self.layer as! CAReplicatorLayer
        layer.instanceCount = 2
        
        var transform = CATransform3DIdentity
        let verticalOffset = self.bounds.size.height + 2
        transform = CATransform3DTranslate(transform, 0, verticalOffset, 0)
        transform = CATransform3DScale(transform, 1, -1, 0)
        layer.instanceTransform = transform
        
        layer.instanceAlphaOffset = -0.6
    }
}
