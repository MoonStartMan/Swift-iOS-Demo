//
//  MSHalfSlider.swift
//  Half-Slider
//
//  Created by 王潇 on 2021/11/1.
//

import UIKit
import SnapKit

class MSHalfSlider: UIView {
    /// 滑动开始闭包
    typealias sliderStartBlock = (_ value: Float) -> Void
    /// 滑动改变闭包
    typealias sliderChangeBlock = (_ value: Float) -> Void
    /// 滑动结束的闭包
    typealias sliderEndBlock = (_ value: Float) -> Void
    /// slider的高度
    var sliderHeight: CGFloat? {
        didSet {
            if let newHeight = sliderHeight {
                self.snp.updateConstraints { make in
                    make.height.equalTo(newHeight)
                }
                sliderBtn.snp.updateConstraints { make in
                    make.size.equalTo(CGSize(width: newHeight, height: newHeight))
                }
            }
        }
    }
    
    /// slider的圆角
    var cornerRadius: CGFloat? {
        didSet {
            if let radius = cornerRadius {
                sliderCoverView.layer.cornerRadius = radius
                sliderCoverView.layer.masksToBounds = true
            }
        }
    }
    
    /// slider的背景色
    var bgColor: UIColor? {
        didSet {
            if let color = bgColor {
                sliderCoverView.backgroundColor = color
            }
        }
    }
    
    /// slider左侧进度条的颜色
    var leftBgColor: UIColor? {
        didSet {
            if let color = leftBgColor {
                sliderLeftView.backgroundColor = color
            }
        }
    }
    
    /// slider右侧进度条的颜色
    var rightBgColor: UIColor? {
        didSet {
            if let color = rightBgColor {
                sliderRightView.backgroundColor = color
            }
        }
    }
    
    /// slider滑块大小
    var sliderBtnSize: CGSize? {
        didSet {
            if let sliderFrame = sliderBtnSize {
                sliderBtn.snp.updateConstraints { make in
                    make.size.equalTo(sliderFrame)
                }
            }
        }
    }
    
    /// slider滑块图片
    var thumbImage: UIImage? {
        didSet {
            if let image = thumbImage {
                sliderBtn.setImage(image, for: .normal)
                sliderBtn.setImage(image, for: .highlighted)
            }
        }
    }
    
    /// slider进度条大小
    var sliderProcess: Float? {
        didSet {
            if let process = sliderProcess {
                sliderValue = Double(sliderProcess ?? 0)
                if process >= Float(minimumValue) && process <= Float(maximumValue) {
                    let ratio: Double = Double(process) / Double((maximumValue - minimumValue) / 2) + 1
                    if ratio > 0 {
                        sliderBtn.snp.remakeConstraints { make in
                            make.centerX.equalToSuperview().multipliedBy(ratio)
                            make.width.height.equalTo(16)
                            make.centerY.equalToSuperview()
                        }
                    } else {
                        /**
                         * 解决这个crash问题：
                         * A multiplier of 0 or a nil second item together with a location for the first attribute creates an illegal constraint of a location equal to a constant.
                         * Location attributes must be specified in pairs.'
                         ***/
                        sliderBtn.snp.remakeConstraints { make in
                            make.centerX.equalTo(self.snp.left)
                            make.size.equalTo(CGSize(width: 16, height: 16))
                            make.centerY.equalToSuperview()
                        }
                    }
                }
            }
        }
    }
    
    var sliderValue: Double = 0.0 {
        didSet {
            sliderValueLabel.text = "\(Float(sliderValue))"
        }
    }
    /// 滑动开始闭包
    var sliderStartBack: sliderStartBlock?
    /// 滑动变化闭包
    var sliderChangeBack: sliderChangeBlock?
    /// 滑动结束闭包
    var sliderEndBack: sliderEndBlock?
    /// 最小值
    var minimumValue: Float = -100
    /// 最大值
    var maximumValue: Float = 100
    /// 中间值
    var centerValue: Float = 0
    
    private var sliderCoverView: UIView!
    private var sliderBtn: UIButton!
    private var sliderLeftView: UIView!
    private var sliderRightView: UIView!
    private var centerView: UIView!
    private var sliderValueView: UIView!
    private var sliderValueLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        sliderCoverView = UIView()
        self.addSubview(sliderCoverView)
        sliderCoverView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(2)
        }
        sliderCoverView.backgroundColor = .hex("#CCCCCC", 0.4)
        
        centerView = UIView()
        self.addSubview(centerView)
        centerView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(10)
            make.width.equalTo(1)
        }
        centerView.backgroundColor = UIColor.hex("#1A1A1A")
        
        sliderBtn = UIButton()
        self.addSubview(sliderBtn)
        sliderBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 16, height: 16))
            make.centerY.equalToSuperview()
        }
        sliderBtn.setImage(UIImage(named: "edit_music_volume_thumb_icon"), for: .normal)
        sliderBtn.imageView?.contentMode = .scaleAspectFill
        sliderBtn.setImage(UIImage(named: "edit_music_volume_thumb_icon"), for: .highlighted)
        let handDrag = UIPanGestureRecognizer(target: self, action: #selector(dragRight))
        sliderBtn.addGestureRecognizer(handDrag)
        
        sliderLeftView = UIView()
        sliderCoverView.addSubview(sliderLeftView)
        sliderLeftView.snp.makeConstraints { make in
            make.left.equalTo(sliderBtn.snp.centerX).priority(.high)
            make.right.equalTo(sliderCoverView.snp.centerX)
            make.height.equalToSuperview()
            make.width.greaterThanOrEqualTo(0)
        }
        sliderLeftView.backgroundColor = UIColor.hex("#D1FF18")
        
        sliderRightView = UIView()
        sliderCoverView.addSubview(sliderRightView)
        sliderRightView.snp.makeConstraints { make in
            make.right.equalTo(sliderBtn.snp.centerX).priority(.high)
            make.left.equalTo(sliderCoverView.snp.centerX)
            make.height.equalToSuperview()
            make.width.greaterThanOrEqualTo(0)
        }
        sliderRightView.backgroundColor = UIColor.hex("#D1FF18")
        
        sliderValueView = UIView()
        self.addSubview(sliderValueView)
        sliderValueView.snp.makeConstraints { make in
            make.bottom.equalTo(sliderBtn.snp.top).offset(-8)
            make.centerX.equalTo(sliderBtn.snp.centerX)
            make.size.equalTo(CGSize(width: 42, height: 26))
        }
        sliderValueView.backgroundColor = .hex("#FFFFFF")
        sliderValueView.layer.borderWidth = 0.5
        sliderValueView.layer.borderColor = UIColor.hex("#000000", 0.06).cgColor
        sliderValueView.layer.cornerRadius = 10
        sliderValueView.layer.masksToBounds = true
        sliderValueView.isHidden = true
        
        sliderValueLabel = UILabel()
        sliderValueView.addSubview(sliderValueLabel)
        sliderValueLabel.snp.makeConstraints { make in
            make.height.equalTo(14)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        sliderValueLabel.textColor = .hex("#1A1A1A")
        sliderValueLabel.font = .systemFont(ofSize: 12, weight: .bold)
        sliderValueLabel.text = "\(Int(sliderValue))"
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let margin: CGFloat = 20
        let area = self.bounds.insetBy(dx: -margin, dy: -margin)
        return area.contains(point)
    }
}

/// 初始化数据
extension MSHalfSlider {
    func initConfig() {
        bgColor = .hex("#CCCCCC", 0.4)
        leftBgColor = .hex("#D1FF18")
        rightBgColor = .hex("#D1FF18")
        thumbImage = UIImage(named: "edit_music_volume_thumb_icon")
    }
}

// MARK: - 拖拽手势
extension MSHalfSlider {
    @objc func dragRight(sender: UIPanGestureRecognizer) {
        
        func callbackValue(isEnd: Bool) {
            let value = Float(sliderValue).clamped(min: minimumValue, max: maximumValue)
            if isEnd {
                sliderEndBack?(value)
            } else {
                sliderChangeBack?(value)
            }
        }
        
        /// 开始滑动时
        if sender.state == .changed {
            sliderValueView.isHidden = false
            var point = sender.translation(in: self)
            point = sender.location(in: self)
            
            /// 当前宽度
            let currentWidth = self.frame.size.width
            /// 滑动的距离
            let sliderWidth = point.x
            /// 滑动的值
            var currentSliderValue: Double = 0.0
            
            if point.x >= 0 && point.x <= self.frame.size.width / 2 {
                if minimumValue >= 0 {
                    let a = currentWidth / 2.0 - sliderWidth
                    let b = currentWidth / 2.0
                    let c = Float(a / b) * (centerValue - minimumValue) + minimumValue
                    currentSliderValue = Double(centerValue - c)
                } else {
                    let a = currentWidth / 2.0 - sliderWidth
                    let b = currentWidth / 2.0
                    let c = Float(a / b) * (centerValue - minimumValue)
                    currentSliderValue = Double(centerValue - c)
                }
            } else if point.x >= currentWidth / 2 && point.x <= currentWidth {
                if maximumValue >= 0 {
                    let a = sliderWidth - currentWidth / 2.0
                    let b = currentWidth / 2.0
                    let c = Float(a / b) * (maximumValue - centerValue) + centerValue
                    currentSliderValue = Double(c)
                } else {
                    let a = sliderWidth - currentWidth / 2.0
                    let b = currentWidth / 2.0
                    let c = Float(a / b) * (maximumValue - centerValue)
                    currentSliderValue = Double(c)
                }
            } else if point.x == currentWidth / 2 {
                currentSliderValue = Double(centerValue)
            } else if point.x > currentWidth {
                currentSliderValue = Double(maximumValue)
            } else if point.x < 0 {
                currentSliderValue = Double(minimumValue)
            }
            
            currentSliderValue = min(currentSliderValue, Double(maximumValue))
            currentSliderValue = max(currentSliderValue, Double(minimumValue))
            
            sliderValue = roundToplaces(value: currentSliderValue, places: 2)
            
            if point.x >= 0 && point.x <= self.frame.size.width {
                
                if point.x > currentWidth / 2 && point.x <= currentWidth {
                    //  右滑
                    sliderBtn.snp.remakeConstraints { make in
                        let offset = sliderWidth - currentWidth / 2.0
                        make.centerX.equalToSuperview().offset(offset)
                        make.size.equalTo(CGSize(width: 16, height: 16))
                        make.centerY.equalToSuperview()
                    }
                } else if point.x > 0 && point.x < currentWidth / 2 {
                    sliderBtn.snp.remakeConstraints { make in
                        let offset = sliderWidth - currentWidth / 2.0
                        make.centerX.equalToSuperview().offset(offset)
                        make.size.equalTo(CGSize(width: 16, height: 16))
                        make.centerY.equalToSuperview()
                    }
                } else if point.x == currentWidth / 2 {
                    sliderBtn.snp.remakeConstraints { make in
                        make.centerX.equalToSuperview()
                        make.size.equalTo(CGSize(width: 16, height: 16))
                        make.centerY.equalToSuperview()
                    }
                }
                callbackValue(isEnd: false)
            }
        } else if sender.state == .began {
            
        } else {
            sliderValueView.isHidden = true
            callbackValue(isEnd: true)
        }
        
    }
    
    func roundToplaces(value: Double, places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return round(value * divisor) / divisor
    }
}
