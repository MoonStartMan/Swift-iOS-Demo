//
//  HueGradientView.swift
//  ColorPicker-Demo
//
//  Created by 王潇 on 2022/2/17.
//

import UIKit
import SnapKit

class HueGradientView: UIView {
    typealias huegradientBlock = (_ color: UIColor) -> Void
    
    private var hueGradientLayer: CAGradientLayer = CAGradientLayer()
    
    private var selectView: UIView = UIView()
    
    private var coverView: UIView = UIView()
    
    private var currentFrame: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
    
    var currentHue: CGFloat = 0.0 {
        didSet {
            
        }
    }
    /// 外部传入更新颜色位置
    var colorValue: UIColor? {
        didSet {
            if let color = colorValue {
                updatePosition(color: color)
            }
        }
    }
    
    var huegradientBack: huegradientBlock?

    override init(frame: CGRect) {
        super.init(frame: frame)
        super.layoutSubviews()
        
        addSubview(coverView)
        coverView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        var controls = [CGFloat]()
        controls = Array(stride(from: 0, through: 1, by: 0.1))
        hueGradientLayer.locations = controls as [NSNumber]?
        hueGradientLayer.colors = controls.map {
            UIColor(hue: $0, saturation: 1, brightness: 1, alpha: 1).cgColor
        }
        hueGradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        hueGradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        coverView.layer.addSublayer(hueGradientLayer)
        
        addSubview(selectView)
        selectView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.height.equalTo(16)
        }
        selectView.layer.cornerRadius = 8
        selectView.layer.borderWidth = 2
        selectView.layer.borderColor = UIColor.white.cgColor
        selectView.backgroundColor = .clear
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(touchMove(pan:)))
        selectView.addGestureRecognizer(pan)
    }
    
    @objc func touchMove(pan: UIPanGestureRecognizer) {
        let location = pan.location(in: self)
        if pan.state == .changed {
            let x = location.x
            if x >= 0 && x <= currentFrame.size.width - 16 {
                selectView.snp.remakeConstraints { make in
                    make.width.height.equalTo(16)
                    make.left.equalToSuperview().offset(x)
                }
                currentHue = x / (currentFrame.size.width - 16)
                let color = UIColor(hue: currentHue, saturation: 1, brightness: 1, alpha: 1)
                huegradientBack?(color)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        hueGradientLayer.frame = self.bounds
        currentFrame = self.hueGradientLayer.frame
    }
    
    private func updatePosition(color: UIColor) {
        let hue = color.hsba.hue / 360
        let marginLeft = CGFloat((currentFrame.size.width-16) * hue)
        selectView.snp.remakeConstraints { make in
            make.width.height.equalTo(16)
            make.left.equalToSuperview().offset(marginLeft)
        }
        currentHue = hue
    }
}
