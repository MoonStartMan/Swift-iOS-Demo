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
    typealias sliderStartBlock = (_ value: Int) -> Void
    /// 滑动改变闭包
    typealias sliderChangeBlock = (_ value: Int) -> Void
    /// 滑动结束的闭包
    typealias sliderEndBlock = (_ value: Int) -> Void
    /// 滑动结束闭包
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
            if var image = thumbImage {
                image = image.withRenderingMode(.alwaysTemplate)
                sliderBtn.setImage(image, for: .normal)
            }
        }
    }
    
    /// slider滑块图片颜色
    var thumbColor: UIColor? {
        didSet {
            if let color = thumbColor {
                sliderBtn.tintColor = color
            }
        }
    }
    /// slider进度条大小
    var sliderProcess: Float? {
        didSet {
            if let process = sliderProcess {
                if process >= Float(minimumValue) && process <= Float(maximumValue) {
                    let ratio: Double = Double(process) / Double((maximumValue - minimumValue) / 2) + 1
                    sliderBtn.snp.remakeConstraints { make in
                        make.centerX.equalToSuperview().multipliedBy(ratio)
                        make.size.equalTo(CGSize(width: 16, height: 16))
                        make.centerY.equalToSuperview()
                    }
                }
            }
        }
    }
    
    var sliderValue: Double = 0.0
    /// 滑动开始闭包
    var sliderStartBack: sliderStartBlock?
    /// 滑动变化闭包
    var sliderChangeBack: sliderChangeBlock?
    /// 滑动结束闭包
    var sliderEndBack: sliderEndBlock?
    /// 最小值
    var minimumValue: Int = -100
    /// 最大值
    var maximumValue: Int = 100
    
    private var sliderCoverView: UIView!
    private var sliderBtn: UIButton!
    private var sliderLeftView: UIView!
    private var sliderRightView: UIView!
    private var centerView: UIView!
    
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
        sliderCoverView.backgroundColor = .systemGray3
        
        centerView = UIView()
        self.addSubview(centerView)
        centerView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(10)
            make.width.equalTo(2)
        }
        centerView.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        
        sliderBtn = UIButton()
        self.addSubview(sliderBtn)
        sliderBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 16, height: 16))
            make.centerY.equalToSuperview()
        }
        sliderBtn.setImage(UIImage(named: "ms_slider_btn"), for: .normal)
        sliderBtn.imageView?.contentMode = .scaleAspectFit
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
        sliderLeftView.backgroundColor = UIColor(red: 0.819, green: 1, blue: 0.094, alpha: 1)
        
        sliderRightView = UIView()
        sliderCoverView.addSubview(sliderRightView)
        sliderRightView.snp.makeConstraints { make in
            make.right.equalTo(sliderBtn.snp.centerX).priority(.high)
            make.left.equalTo(sliderCoverView.snp.centerX)
            make.height.equalToSuperview()
            make.width.greaterThanOrEqualTo(0)
        }
        sliderRightView.backgroundColor = UIColor(red: 0.819, green: 1, blue: 0.094, alpha: 1)
    }
}

// MARK: - 拖拽手势
extension MSHalfSlider {
    @objc func dragRight(sender: UIPanGestureRecognizer) {
        /// 开始滑动时
        if sender.state == .changed {
            var point = sender.translation(in: self)
            point = sender.location(in: self)
            /// 左右的峰值
            let maxValue = (maximumValue - minimumValue) / 2
            /// 左右的宽度
            let priceWidth = (self.frame.size.width) / 2
            /// 滑动的距离
            let sliderWidth = point.x - priceWidth
            /// 滑动的值
            sliderValue = round(Double(sliderWidth * CGFloat(maxValue) / priceWidth))
            /// 滑动比例
            let scrollRatio = sliderWidth / self.frame.size.width
            
            if point.x >= 0 && point.x <= self.frame.size.width {
                //  右滑
                sliderBtn.snp.remakeConstraints { make in
                    make.centerX.equalToSuperview().offset(sliderValue / Double(maxValue) * self.frame.size.width / 2 )
                    make.size.equalTo(CGSize(width: 16, height: 16))
                    make.centerY.equalToSuperview()
                }
                
                if scrollRatio >= 0.49 {
                    sliderValue = Double(maximumValue)
                    sliderBtn.snp.remakeConstraints { make in
                        make.centerX.equalToSuperview().offset(self.frame.size.width / 2)
                        make.size.equalTo(CGSize(width: 16, height: 16))
                        make.centerY.equalToSuperview()
                    }
                } else if scrollRatio <= -0.49 {
                    sliderValue = Double(minimumValue)
                    sliderBtn.snp.remakeConstraints { make in
                        make.centerX.equalToSuperview().offset(-self.frame.size.width / 2)
                        make.size.equalTo(CGSize(width: 16, height: 16))
                        make.centerY.equalToSuperview()
                    }
                }
                if Int(sliderValue) >= minimumValue && Int(sliderValue) <= maximumValue {
                    sliderChangeBack?(Int(sliderValue))
                }
            }
        /// 滑动结束时
        } else if sender.state == .ended {
            if Int(sliderValue) >= minimumValue && Int(sliderValue) <= maximumValue {
                sliderEndBack?(Int(sliderValue))
            }
        } else if sender.state == .began {
            if Int(sliderValue) >= minimumValue && Int(sliderValue) <= maximumValue {
                sliderStartBack?(Int(sliderValue))
            }
        }
        
    }
}
