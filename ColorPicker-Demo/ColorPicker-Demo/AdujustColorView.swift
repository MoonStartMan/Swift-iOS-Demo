//
//  AdujustView.swift
//  ColorPicker-Demo
//
//  Created by 王潇 on 2022/2/17.
//

import UIKit
import SnapKit

class AdujustColorView: UIView {
    typealias adjustColorBlock = (_ saturation: CGFloat?, _ brightness: CGFloat?) -> Void

    private var hueGradientLayer: CAGradientLayer = CAGradientLayer()
    
    private var touchView: UIView = UIView()
    
    private var coverView: UIView = UIView()
    
    private var coverBgView: UIImageView = UIImageView()
    /// 饱和度
    var saturationValue: CGFloat = 0.0
    /// 亮度
    var brightnessValue: CGFloat = 0.0
    
    var currentColor: UIColor? {
        didSet {
            if let color = currentColor {
                updateColor(color: color)
            }
        }
    }
    
    var currentFrame: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
    
    var adjustBack: adjustColorBlock?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(coverView)
        coverView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        addSubview(coverBgView)
        coverBgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        coverBgView.image = UIImage(named: "edit_text_color_select_mask")
        super.layoutSubviews()
        
        addSubview(touchView)
        touchView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(3)
            make.right.equalToSuperview().offset(-4)
            make.width.height.equalTo(16)
        }
        touchView.layer.borderColor = UIColor.white.cgColor
        touchView.layer.borderWidth = 2
        touchView.backgroundColor = .clear
        touchView.layer.cornerRadius = 8
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(touchMove(pan:)))
        touchView.addGestureRecognizer(pan)
    }
    
    @objc func touchMove(pan: UIPanGestureRecognizer) {
        if pan.state == .changed {
            let location = pan.location(in: self)
            let x = location.x,
                y = location.y
            if x >= 0 && y >= 0 && x <= currentFrame.size.width && y <= currentFrame.size.height {
                //  竖直方向的距离
                var verticalSize: CGFloat = 0.0
                //  水平方向的距离
                var levelSize: CGFloat = 0.0
                
                if Int(x) >= lroundf(Float(currentFrame.size.width) / 2) {
                    levelSize = x - 16
                } else {
                    levelSize = x
                }
                
                if Int(y) >= lroundf(Float(currentFrame.size.height) / 2) {
                    verticalSize = y - 12
                } else {
                    verticalSize = y
                }
                
                touchView.snp.remakeConstraints { make in
                    make.top.equalToSuperview().offset(verticalSize)
                    make.left.equalToSuperview().offset(levelSize)
                    make.width.height.equalTo(16)
                }
                
                brightnessValue = levelSize / (currentFrame.size.width - 16)
                saturationValue = verticalSize / (currentFrame.size.height - 16)
                adjustBack?(brightnessValue, (1-saturationValue))
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        hueGradientLayer.frame = self.bounds
        currentFrame = hueGradientLayer.frame
    }
    
    func updateColor(color: UIColor) {
//        hueGradientLayer.removeFromSuperlayer()
//        var controls = [CGFloat]()
//        controls = Array(stride(from: 0.0, through: 1, by: 0.1))
//        hueGradientLayer.locations = controls as [NSNumber]?
//        let hue = color.hsba.hue / 360
//        hueGradientLayer.colors = controls.map {
//            UIColor(hue: hue, saturation: $0, brightness: 1 - $0, alpha: 1).cgColor
//        }
//        hueGradientLayer.startPoint = CGPoint(x: 0, y: 0)
//        hueGradientLayer.endPoint = CGPoint(x: 1, y: 1)
//        coverView.layer.addSublayer(hueGradientLayer)
        coverView.backgroundColor = color
    }
    
}
