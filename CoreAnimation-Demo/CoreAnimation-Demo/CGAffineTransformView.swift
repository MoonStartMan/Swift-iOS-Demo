//
//  CGAffineTransformView.swift
//  CoreAnimation-Demo
//
//  Created by 王潇 on 2023/3/6.
//

import UIKit

class CGAffineTransformView: UIView {
    
    private var transformView: UIView = UIView()
    
    private var imageView: UIImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        subLayerTransform()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(transformView)
        transformView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        transformView.backgroundColor = .systemPink
    }
    
    /// 旋转
    func setTransformAngle() {
        UIView.animate(withDuration: 3.0, delay: 0) {
            self.transformView.layer.setAffineTransform(CGAffineTransform(rotationAngle: -1))
        } completion: { finish in
            if finish {
                UIView.animate(withDuration: 3.0, delay: 0) {
                    self.transformView.layer.setAffineTransform(CGAffineTransform(rotationAngle: 1))
                }
            }
        }
    }
    
    /// 组合变换
    func setTransformIdentity() {
        //  先旋转,后平移
        UIView.animate(withDuration: 3.0, delay: 0) {
            var transform = CGAffineTransform.identity
            transform = transform.rotated(by: .pi / 4)
            transform = transform.translatedBy(x: 100, y: 0)
            self.transformView.transform = transform
        } completion: { finish in
            if finish {
                UIView.animate(withDuration: 3.0, delay: 0) {
                    var transform2 = CGAffineTransform.identity
                    transform2 = transform2.translatedBy(x: 0, y: 0)
                    transform2 = transform2.rotated(by: .pi)
                    self.transformView.transform = transform2
                }
            }
        }
    }
    
    /// 剪切变换
    func shearTransform() {
        UIView.animate(withDuration: 3.0, delay: 0) {
            self.transformView.layer.setAffineTransform(makeShear(x: 1, y: 0))
        }
        
        func makeShear(x: CGFloat, y: CGFloat) -> CGAffineTransform {
            var transform = CGAffineTransform.identity
            transform.c = -x
            transform.b = -y
            return transform
        }
    }
    
    /// 3D变换
    func setTransForm3DMakeRotation() {
        UIView.animate(withDuration: 3.0, delay: 0) {
            var transform = CATransform3DIdentity
            /// 如果有多个 view 或 layer，每个都需添加 3D 变换，则必须对所有 view、layer 应用相同m34，并确保变换前处于屏幕中心同样位置。
            transform.m34 = -1.0 / 500.0
            transform = CATransform3DRotate(transform, .pi / 4.0, 0, 1, 0)
            self.transformView.transform3D = transform
        }
    }
    
    func subLayerTransform() {
        transformView.removeFromSuperview()
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        imageView.image = UIImage(named: "scenery")
        
        UIView.animate(withDuration: 3.0) {
            var perspective = CATransform3DIdentity
            perspective.m34 = -1.0 / 500.0
            self.imageView.layer.sublayerTransform = perspective
            self.imageView.transform3D = CATransform3DMakeRotation(-.pi / 4.0, 0, 1, 0)
        }
    }
    
}
