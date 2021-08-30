//
//  MSSlider.swift
//  Custom-Slider-Demo
//
//  Created by 王潇 on 2021/8/27.
//

import UIKit
import SnapKit

class MSSlider: UIView {
    /// slider的高度
    var sliderHeight: CGFloat? {
        didSet {
            if let newHeight = sliderHeight {
                frame.size.height = newHeight
            }
        }
    }
    /// slider的圆角
    var cornerRadius: CGFloat? {
        didSet {
            if let radius = cornerRadius {
                layer.cornerRadius = radius
                btn.layer.cornerRadius = radius
                gradientLayer.layer.cornerRadius = radius / 2
            }
        }
    }
    /// slider背景色
    var bgColor: UIColor? {
        didSet {
            if let color = bgColor {
                backgroundColor = color
            }
        }
    }
    /// slider进度条颜色
    var processColor: UIColor? {
        didSet {
            if let color = processColor {
                gradientLayer.backgroundColor = color
            }
        }
    }
    /// slider滑块图片
    var thumbImage: UIImage? {
        didSet {
            if var image = thumbImage {
                image = image.withRenderingMode(.alwaysTemplate)
                btn.setImage(image, for: .normal)
            }
        }
    }
    /// slider滑块图片颜色
    var thumbColor: UIColor? {
        didSet {
            if let color = thumbColor {
                btn.tintColor = color
            }
        }
    }
    
    /// 中间按钮
    private var btn: UIButton!
    /// 滚动条UIView
    private var gradientLayer: UIView!
    /// 数值Label
    private var contentLabel: UILabel!
    /// 覆盖层UIView
    private var coverView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        UIConfig()
        initConfig()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

/// UI搭建
extension MSSlider {
    func UIConfig() {
        coverView = UIView()
        self.addSubview(coverView)
        coverView.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left).offset(-10)
            make.right.equalTo(self.snp.right).offset(10)
            make.height.equalTo(10)
        }
        
        btn = UIButton(frame: .zero)
        self.addSubview(btn)
        btn.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.height.equalTo(20)
            make.left.equalToSuperview()
        }
        
        gradientLayer = UIView()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: 0, height: self.bounds.size.height)
        self.insertSubview(gradientLayer, at: 0)
        let handDrag = UIPanGestureRecognizer(target: self, action: #selector(funDragRight))
        btn.addGestureRecognizer(handDrag)
        
        contentLabel = UILabel(frame: .zero)
        self.addSubview(contentLabel)
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(self.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(20)
        }
        contentLabel.font = .systemFont(ofSize: 14, weight: .bold)
        contentLabel.textColor = .black
    }
}

/// 初始化数据
extension MSSlider {
    func initConfig() {
        self.sliderHeight = 20
        self.cornerRadius = 10
        self.bgColor = .red
        self.processColor = .systemBlue
        self.thumbImage = UIImage(named: "diamond")
        self.thumbColor = .black
    }
}

/// 拖拽手势
extension MSSlider {
    @objc func funDragRight(sender: UIPanGestureRecognizer) {
        var point = sender.translation(in: coverView)
        point = sender.location(in: coverView)
        if (point.x >= 0 && point.x <= self.frame.size.width) {
            btn.snp.remakeConstraints { make in
                make.centerY.equalToSuperview()
                make.width.height.equalTo(20)
                make.left.equalToSuperview().offset(point.x-15)
            }
            
            gradientLayer.frame = CGRect(x: 0, y: 0, width: point.x, height: self.bounds.size.height)
            contentLabel.text = "\(Int(point.x / coverView.frame.width * 100))"
        }
    }
}
