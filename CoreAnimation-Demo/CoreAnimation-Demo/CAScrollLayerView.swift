//
//  CAScrollLayerView.swift
//  CoreAnimation-Demo
//
//  Created by 王潇 on 2023/3/8.
//

import UIKit

class CAScrollLayerView: UIView {
    
    private var imageView: UIImageView = UIImageView()
    
    override class var layerClass: AnyClass {
        return CAScrollLayer.self
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    private func setup() {
        layer.masksToBounds = true
        backgroundColor = .lightGray
        
        let recognizer = UIPanGestureRecognizer(target: self, action: #selector(pan))
        addGestureRecognizer(recognizer)
        
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        imageView.image = UIImage(named: "scenery")
    }
    
    @objc func pan(_ recognizer: UIPanGestureRecognizer) {
        var offset = bounds.origin
        offset.x -= recognizer.translation(in: self).x
        offset.y -= recognizer.translation(in: self).y

        layer.scroll(offset)

        recognizer.setTranslation(CGPoint.zero, in: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
