//
//  ColorValueView.swift
//  ColorPicker-Demo
//
//  Created by 王潇 on 2022/2/19.
//

import UIKit

class ColorValueView: UIView, UITextFieldDelegate {
    typealias colorValueBlock = (_ colorValue: UIColor) -> Void
    
    private var inputTextField: UITextField = UITextField()
    
    private var colorView: UIView = UIView()
    
    var currentColor: UIColor = .clear {
        didSet {
            colorView.backgroundColor = currentColor
            inputTextField.text = currentColor.hexColor
        }
    }
    /// 外部传入修改色值修改透明度
    var currentAlpha: CGFloat? {
        didSet {
            if let alpha = currentAlpha {
                let hexColorValue = currentColor.hexColor
                var cString: String = hexColorValue.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
                
                if cString.hasPrefix("#") {
                    cString.remove(at: cString.startIndex)
                }
                
                var rgbValue: UInt64 = 0
                Scanner(string: cString).scanHexInt64(&rgbValue)
                
                let color = UIColor(
                    red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                    green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                    blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                    alpha: CGFloat(alpha)
                )
                colorView.backgroundColor = color
            }
        }
    }
    
    var colorValueBack: colorValueBlock?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(inputTextField)
        inputTextField.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(8)
            make.right.top.bottom.equalToSuperview()
        }
        
        addSubview(colorView)
        colorView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.bottom.right.equalToSuperview().offset(-4)
            make.width.height.equalTo(32)
        }
        colorView.layer.cornerRadius = 4
        colorView.layer.masksToBounds = true
        
        inputTextField.textColor = .black
        inputTextField.font = .systemFont(ofSize: 12, weight: .bold)
        inputTextField.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func isHexColor(_ hexStr: String) -> Bool {
            let expression = "^#([0-9a-fA-F]{6})$"
            let regx = try? NSRegularExpression.init(pattern: expression, options: .caseInsensitive)
            if let regexArray = regx?.matches(in: hexStr, options: .reportCompletion, range: NSMakeRange(0, hexStr.count)) {
                for result in regexArray {
                    if result.range.location == 0 && result.range.length == 7 {
                        return true
                    }
                }
            }
            
            return false
        }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //  限制只能输入带#的7位数
        if let text = textField.text {
            let newText = (text as? NSString)?.replacingCharacters(in: range, with: string)
            if newText?.count ?? 0 > 7 {
                return false
            }
            if let nText = newText {
                let result = isHexColor(nText)
                if result {
                    let color = UIColor.hexColor(hex: nText)
                    currentColor = color
                    colorValueBack?(color)
                }
            }
        }
        return true
    }
    
}
