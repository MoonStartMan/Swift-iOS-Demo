//
//  CAShapeLayerView.swift
//  CoreAnimation-Demo
//
//  Created by 王潇 on 2023/3/7.
//

import UIKit

class CAShapeLayerView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        drawCAReplicatorLayer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func drawPath() {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 175, y: 100))
        path.addArc(withCenter: CGPoint(x: 150, y: 100), radius: 25, startAngle: 0, endAngle: .pi * 2, clockwise: true)
        path.move(to: CGPoint(x: 150, y: 125))
        path.addLine(to: CGPoint(x: 150, y: 175))
        path.addLine(to: CGPoint(x: 125, y: 225))
        path.move(to: CGPoint(x: 150, y: 175))
        path.addLine(to: CGPoint(x: 175, y: 225))
        path.move(to: CGPoint(x: 100, y: 150))
        path.addLine(to: CGPoint(x: 200, y: 150))
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 5
        shapeLayer.lineJoin = .bevel
        shapeLayer.lineCap = .round
        shapeLayer.path = path.cgPath
        
        layer.addSublayer(shapeLayer)
    }
    
    /// 画圆角
    private func drawCornerRadius() {
//        backgroundColor = .systemPink
        
        let rect = CGRect(x: 0, y: 0, width: 100, height: 100)
        let radii = CGSize(width: 20, height: 20)
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topRight, .bottomRight], cornerRadii: radii)
        
        let layer = CALayer()
        layer.backgroundColor = UIColor.gray.cgColor
        layer.position = center
        layer.bounds = CGRect(x: 0, y: 0, width: 200, height: 200)
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        layer.mask = maskLayer
        
        self.layer.addSublayer(layer)
    }
    
    private func transformLayer() {
        let container = CATransformLayer()
//        let container = CALayer()
        container.frame = frame
        layer.addSublayer(container)
        
        let planesPosition = layer.position
        let planeSize = CGSize(width: 200, height: 200)
        let purplePlane = addPlane(container: container, size: planeSize, position: planesPosition, color: UIColor.purple)
        let redPlane = addPlane(container: container, size: planeSize, position: planesPosition, color: UIColor.red)
        let orangePlane = addPlane(container: container, size: planeSize, position: planesPosition, color: UIColor.orange)
        let yellowPlane = addPlane(container: container, size: planeSize, position: planesPosition, color: UIColor.yellow)
        
        var t = CATransform3DIdentity
        t.m34 = 1.0 / -500
        t = CATransform3DRotate(t, .pi / 3.0, 0, 1, 0)
        container.transform = t
        
        // Apply transform to the planes
        t = CATransform3DIdentity
        t = CATransform3DTranslate(t, 0, 0, 0)
        purplePlane.transform = t
        
        // Apply transform to the planes
        t = CATransform3DIdentity
        t = CATransform3DTranslate(t, 0, 0, -40)
        redPlane.transform = t
        
        // Apply transform to the planes
        t = CATransform3DIdentity
        t = CATransform3DTranslate(t, 0, 0, -80)
        orangePlane.transform = t
                
        // Apply transform to the planes
        t = CATransform3DIdentity
        t = CATransform3DTranslate(t, 0, 0, -120)
        yellowPlane.transform = t
        
        func addPlane(container: CALayer, size: CGSize, position: CGPoint, color: UIColor) -> CALayer {
            let plane = CALayer()
            plane.backgroundColor = color.cgColor
            plane.opacity = 0.6
            plane.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
            plane.position = position
            plane.borderColor = UIColor.init(white: 1.0, alpha: 0.5).cgColor
            plane.borderWidth = 3
            plane.cornerRadius = 10.0
            container.addSublayer(plane)
            return plane
        }
    }
    
    private func drawCAGradientLayer() {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.red.cgColor, UIColor.yellow.cgColor, UIColor.green.cgColor]
        gradient.locations = [0.0, 0.25, 0.5]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        gradient.frame = bounds
        layer.addSublayer(gradient)
    }
    
    private func drawCAReplicatorLayer() {
        var replicatorLayer = CAReplicatorLayer()
        replicatorLayer.bounds = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
        layer.addSublayer(replicatorLayer)
        
        replicatorLayer.instanceCount = 10
        
        var transform = CATransform3DIdentity
        transform = CATransform3DTranslate(transform, 0, 50, 0)
        transform = CATransform3DRotate(transform, .pi / 5.0, 0, 0, 1)
        transform = CATransform3DTranslate(transform, 0, -50, 0)
        replicatorLayer.instanceTransform = transform
        
        replicatorLayer.instanceBlueOffset = -0.1
        replicatorLayer.instanceGreenOffset = -0.1
        
        let layer = CALayer()
        layer.bounds = CGRect(x: 0, y: 0, width: 25, height: 25)
        layer.position = layer.position
        layer.backgroundColor = UIColor.white.cgColor
        
        replicatorLayer.addSublayer(layer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
//        drawCAGradientLayer()
    }
}
