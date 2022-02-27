//
//  ColorPickerView.swift
//  ColorPicker-Demo
//
//  Created by 王潇 on 2022/2/17.
//

import UIKit
import SnapKit

class ColorPickerView: UIView {
    /// 调整View
    private var adjustColorView: AdujustColorView = AdujustColorView()
    /// 色相View
    private var scrollView: HueGradientView = HueGradientView()
    /// 透明度View
    private var alphaView: AplhaScrollView = AplhaScrollView()
    /// 颜色数值View
    private var colorValueView: ColorValueView = ColorValueView()
    
    var currentColor: UIColor?

    override init(frame: CGRect) {
        super.init(frame: frame)
        initColor(color: UIColor.blue)
        
        addSubview(adjustColorView)
        adjustColorView.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-8)
            make.height.equalTo(201)
        }
        adjustColorView.layer.cornerRadius = 8
        adjustColorView.layer.masksToBounds = true
        adjustColorView.layer.borderWidth = 0.5
        adjustColorView.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.06).cgColor
        adjustColorView.adjustBack = { [weak self] (saturation, brightness) in
            guard let self = self else { return }
            self.updateAllColor(color: nil, alpha: nil, saturation: saturation, brightness: brightness)
        }
        
        addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(adjustColorView.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-8)
            make.height.equalTo(16)
        }
        scrollView.layer.cornerRadius = 10
        scrollView.layer.masksToBounds = true
        scrollView.layer.borderWidth = 0.5
        scrollView.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.06).cgColor
        scrollView.huegradientBack = { [weak self] (color) in
            guard let self = self else { return }
            self.updateAllColor(color: color, alpha: nil, saturation: nil, brightness: nil)
        }
        
        addSubview(alphaView)
        alphaView.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-8)
            make.height.equalTo(16)
        }
        alphaView.layer.cornerRadius = 10
        alphaView.layer.masksToBounds = true
        alphaView.layer.borderWidth = 0.5
        alphaView.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.06).cgColor
        alphaView.aplhaBack = { [weak self] (alphaValue) in
            guard let self = self else { return }
            self.updateAllColor(color: nil, alpha: alphaValue, saturation: nil, brightness: nil)
        }
        
        addSubview(colorValueView)
        colorValueView.snp.makeConstraints { make in
            make.top.equalTo(alphaView.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-8)
            make.bottom.equalToSuperview().offset(-8)
        }
        colorValueView.layer.cornerRadius = 8
        colorValueView.layer.masksToBounds = true
        colorValueView.layer.borderWidth = 0.5
        colorValueView.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.06).cgColor
        colorValueView.colorValueBack = { [weak self] (colorValue) in
            guard let self = self else { return }
            self.updateAllColor(color: colorValue, alpha: nil, saturation: nil, brightness: nil)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initColor(color: UIColor) {
        adjustColorView.currentColor = color
        scrollView.currentHue = color.hsba.hue
        alphaView.updateColor(color: color)
        colorValueView.currentColor = color
        currentColor = color
    }
    
    private func colorAddAphla(color: UIColor, alpha: CGFloat) -> UIColor {
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var alphaValue: CGFloat = 0.0
        color.getRed(&red, green: &green, blue: &blue, alpha: &alphaValue)
        var array: [CGFloat] = []
        array.append(red)
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    private func updateAllColor(color: UIColor?, alpha: CGFloat?, saturation: CGFloat?, brightness: CGFloat?) {
        if let colorValue = color {
            adjustColorView.currentColor = colorValue
            scrollView.colorValue = colorValue
            alphaView.updateColor(color: colorValue)
            colorValueView.currentColor = colorValue
            currentColor = colorValue
        }
        
        if let alphaValue = alpha {
            alphaView.currentAlpha = alphaValue
            colorValueView.currentAlpha = alphaValue
            colorValueView.currentColor = colorAddAphla(color: colorValueView.currentColor, alpha: alphaValue)
        }
        
        if let saturationValue = saturation,
           let brightnessValue = brightness {
                let lastColor = colorValueView.currentColor
                let hue = lastColor.hsba.hue / 360
            let newColor = UIColor(hue: hue, saturation: saturationValue, brightness: brightnessValue, alpha: 1)
                colorValueView.currentColor = newColor
                currentColor = newColor
        }
    }
    
}
