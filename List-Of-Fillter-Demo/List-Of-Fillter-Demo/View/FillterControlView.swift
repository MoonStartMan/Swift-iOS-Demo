//
//  FillterControlView.swift
//  List-Of-Fillter-Demo
//
//  Created by 王潇 on 2021/9/1.
//

import UIKit

class FillterControlView: UIView {
    /// 清除闭包
    typealias clearBlock = () -> Void
    /// 确定闭包
    typealias determineBlock = () -> Void
    /// 按钮的边长
    let btnWidth: CGFloat = 40
    /// slider的最小值
    let sliderMinValue: Float = 0
    /// slider的最大值
    let sliderMaxValue: Float = 100
    /// slider的默认值
    let sliderDefalutValue: Float = 0
    /// slider滑动部分颜色
    let minimumColor = UIColor.init(red: 209 / 255.0, green: 255 / 255.0, blue: 24 / 255.0, alpha: 1.0)
    /// slider底色
    let maximumColor = UIColor.init(red: 204 / 255.0, green: 204 / 255.0, blue: 204 / 255.0, alpha: 1.0)
    /// slider滑块图片
    let sliderImage = UIImage(named: "fillterSliderBtn")
    /// slider距离按钮左右的距离
    let sliderMargin: CGFloat = 24
    /// 按钮距离父视图左右的距离
    let btnMargin: CGFloat = 16
    
    /// 清除按钮的点击事件
    var clearBack: clearBlock?
    /// 打钩点击事件
    var determineBack: determineBlock?
    
    /// 不可点击状态下的线条
    private var disableView: UIView!
    /// 滑动条
    private var slider: UISlider!
    /// 清除按钮
    private var clearBtn: FillterBtn!
    /// 确定按钮
    private var determineBtn: FillterBtn!
    /// 顶部数值视图
    private var valueView: FillterValueView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        /// 初始化为不可点击状态
        selectFillterChange(isSelectFillter: false)
        addClickEvent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension FillterControlView {
    func setUI() {
        clearBtn = FillterBtn(frame: .zero)
        self.addSubview(clearBtn)
        clearBtn.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.height.equalTo(btnWidth)
        }
        clearBtn.imageName = "fillterClearBtn"
        
        determineBtn = FillterBtn(frame: .zero)
        self.addSubview(determineBtn)
        determineBtn.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-btnMargin)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(btnWidth)
        }
        determineBtn.imageName = "fillterYesBtn"
        
        disableView = UIView(frame: .zero)
        self.addSubview(disableView)
        disableView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(clearBtn.snp.right).offset(sliderMargin)
            make.right.equalTo(determineBtn.snp.left).offset(-sliderMargin)
            make.height.equalTo(2)
        }
        disableView.backgroundColor = UIColor.init(red: 204 / 255.0, green: 204 / 255.0, blue: 204 / 255.0, alpha: 1.0)
        
        slider = UISlider(frame: .zero)
        self.addSubview(slider)
        slider.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(clearBtn.snp.right).offset(sliderMargin)
            make.right.equalTo(determineBtn.snp.left).offset(-sliderMargin)
            make.height.equalTo(16)
        }
        //  最小值
        slider.minimumValue = sliderMinValue
        //  最大值
        slider.maximumValue = sliderMaxValue
        //  设置默认值
        slider.setValue(sliderDefalutValue, animated: true)
        //  滑动条有值部分颜色
        slider.minimumTrackTintColor = minimumColor
        //  滑动条没有值部分颜色
        slider.maximumTrackTintColor = maximumColor
        //  响应值变化事件
        slider.addTarget(self, action: #selector(sliderValueChange), for: .valueChanged)
        //  响应滑动结束后的事件
        slider.addTarget(self, action: #selector(sliderValueEnd), for: .touchUpInside)
        //  修改控制器图片
        slider.setThumbImage(sliderImage, for: .normal)
        
        valueView = FillterValueView(frame: .zero)
        self.addSubview(valueView)
        valueView.snp.makeConstraints { make in
            make.left.equalTo(slider.snp.left).offset(-21)
            make.bottom.equalTo(slider.snp.top).offset(-8)
            make.width.equalTo(42)
            make.height.equalTo(26)
        }
        valueView.isHidden = true
    }
}


/// MARK: - Slider滑动
extension FillterControlView {
    //  MARK: - sliderValueChange
    @objc func sliderValueChange(slider: UISlider) {
        let value = Int(slider.value)
        let sliderWidth = slider.frame.size.width
        let priceWidth = sliderWidth / 100
        valueView.isHidden = false
        valueView.changeValue = value
        valueView.snp.updateConstraints { make in
            make.left.equalTo(slider.snp.left).offset(Int(CGFloat(value)*priceWidth) - 21)
        }
    }
    
    @objc func sliderValueEnd(slider: UISlider) {
        valueView.isHidden = true
    }
}

/// MARK: - 点击状态函数
extension FillterControlView {
    ///  点击滤镜菜单后的切换
    func selectFillterChange(isSelectFillter: Bool) {
        if isSelectFillter {
            clearBtn.isEnabled = true
            determineBtn.isEnabled = true
            disableView.isHidden = true
            slider.isHidden = false
        } else {
            clearBtn.isEnabled = false
            determineBtn.isEnabled = false
            disableView.isHidden = false
            slider.isHidden = true
            sliderDefault()
        }
    }
    
    ///  Slider数值恢复默认值
    func sliderDefault() {
        slider.setValue(sliderDefalutValue, animated: true)
    }
}

/// MARK: - 点击事件函数
extension FillterControlView {
    /// 给按钮添加点击事件
    func addClickEvent() {
        self.clearBtn.addTarget(self, action: #selector(clearClick), for: .touchUpInside)
        self.determineBtn.addTarget(self, action: #selector(determineClick), for: .touchUpInside)
    }
    
    /// 关键帧点击闭包
    @objc func clearClick() {
        clearBack?()
    }
    
    /// 确定点击闭包
    @objc func determineClick() {
        determineBack?()
    }
}
