//
//  MSSlider.swift
//  Custom-Slider-Demo
//
//  Created by 王潇 on 2021/8/27.
//

import UIKit
import SnapKit

class MSSlider: UIView {
    typealias sliderBlock = (_ value: Int) -> Void
    /// slider的高度
    var sliderHeight: CGFloat? {
        didSet {
            if let newHeight = sliderHeight {
                self.snp.updateConstraints { make in
                    make.height.equalTo(newHeight)
                }
            }
        }
    }
    /// slider的圆角
    var cornerRadius: CGFloat? {
        didSet {
            if let radius = cornerRadius {
                layer.cornerRadius = radius
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
    /// slider滑块大小
    var sliderSize: CGRect? {
        didSet {
            if let sliderFrame = sliderSize {
                btn.snp.remakeConstraints { make in
                    make.width.equalTo(sliderFrame.size.width)
                    make.height.equalTo(sliderFrame.size.height)
                    make.centerY.equalToSuperview()
                    make.left.equalToSuperview()
                }
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
    /// 闭包传递sliderValue
    var sliderChange: sliderBlock?
    /// 左侧值(最小值)
    var minimumValue: Float = 0
    /// 右侧值(最大值)
    var maximumValue: Float = 100
    
    /// 中间按钮
    private var btn: MSSliderBtn!
    /// 滚动条UIView
    private var gradientLayer: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        uiConfig()
        initConfig()
    }
    
    override func layoutSubviews() {
        let radius = self.frame.size.height / 2
        if (cornerRadius == nil) {
            layer.cornerRadius = radius
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

/// UI搭建
extension MSSlider {
    func uiConfig() {
        self.layer.masksToBounds = true
        
        btn = MSSliderBtn(frame: .zero)
        self.addSubview(btn)
        btn.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.equalToSuperview()
            make.width.equalTo(btn.snp.height)
            make.left.equalToSuperview()
        }
        btn.contentMode = .scaleAspectFill
        
        gradientLayer = UIView()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: 0, height: self.bounds.size.height)
        self.insertSubview(gradientLayer, at: 0)
        let handDrag = UIPanGestureRecognizer(target: self, action: #selector(funDragRight))
        btn.addGestureRecognizer(handDrag)
    }
}

/// 初始化数据
extension MSSlider {
    func initConfig() {
        self.bgColor = .systemGray6
        self.processColor = .systemBlue
        self.thumbImage = UIImage(named: "slider-block")
        self.thumbColor = .systemGray4
    }
}

/// 拖拽手势
extension MSSlider {
    @objc func funDragRight(sender: UIPanGestureRecognizer) {
        var point = sender.translation(in: self)
        point = sender.location(in: self)
        if (point.x >= btn.frame.size.width / 2 && point.x <= self.frame.size.width - btn.frame.size.width / 2) {
            btn.snp.updateConstraints { make in
                make.left.equalToSuperview().offset(point.x-((btn.frame.size.width)/2))
            }
            gradientLayer.frame = CGRect(x: 0, y: 0, width: point.x, height: self.bounds.size.height)
            
            /// 起始点应该减去当前的默认按钮大小的宽度的一半
            let subtractBtnValue = btn.frame.size.width / 2
            /// 总长度应该减去当前按钮大小的宽度
            let subtractWidthValue = btn.frame.size.width
            /// 总的刻度量 = 最大值 - 最小值
            let totalScale = maximumValue - minimumValue;
            /// 滑动的刻度量
            let sliderScale = lroundf(Float((point.x - subtractBtnValue) * CGFloat(totalScale) / (self.frame.size.width - subtractWidthValue)))
            /// 滑动的值
            var sliderValue: Int = 0
            
            if point.x == (self.frame.size.width / 2) {
                sliderValue = (Int(minimumValue) + Int(maximumValue)) / 2
            } else {
                sliderValue = Int(minimumValue) + Int(sliderScale)
            }
            
            
            /// sliderValue为maximumValue和minimumValue时填充背景色
            if sliderValue == Int(maximumValue) {
                gradientLayer.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
            } else if sliderValue == Int(minimumValue) {
                gradientLayer.frame = CGRect(x: 0, y: 0, width: 0, height: self.frame.size.height)
            }
            
            /// sliderValue小于1份或者大于99份的时候吸附过去
            if sliderValue <= (Int(minimumValue) + 1) {
                UIView.animate(withDuration: 0.25) {
                    self.btn.snp.updateConstraints { make in
                        make.left.equalToSuperview().offset(0)
                    }
                }
                gradientLayer.frame = CGRect(x: 0, y: 0, width: 0, height: self.frame.size.height)
                sliderValue = Int(minimumValue)
            }

            if sliderValue >= (Int(maximumValue) - 1) {
                UIView.animate(withDuration: 0.25) {
                    self.btn.snp.updateConstraints { make in
                        make.left.equalToSuperview().offset(self.frame.size.width - self.btn.frame.size.width)
                    }
                }
                gradientLayer.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
                sliderValue = Int(maximumValue)
            }
            
            if sliderChange != nil {
                sliderChange!(sliderValue)
            }
        }
    }
}
