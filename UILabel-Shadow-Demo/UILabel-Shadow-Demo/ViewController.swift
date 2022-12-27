//
//  ViewController.swift
//  UILabel-Shadow-Demo
//
//  Created by 王潇 on 2022/12/26.
//

import UIKit

class ViewController: UIViewController {
    
    private var textLabel: UILabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.addSubview(textLabel)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let textLabelCenterX = NSLayoutConstraint(item: textLabel, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
        let textLabelTop = NSLayoutConstraint(item: textLabel, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 200)
        textLabel.superview?.addConstraints([textLabelTop, textLabelCenterX])
        textLabel.font = .systemFont(ofSize: 30)
        textLabel.text = "添加阴影"
        
        let shadow = NSShadow()
        shadow.shadowBlurRadius = 6
        shadow.shadowOffset = CGSize(width: -3, height: 5)
        shadow.shadowColor = UIColor.orange
        let attr = NSMutableAttributedString(string: "添加阴影")
        attr.addAttributes([NSAttributedString.Key.shadow: shadow], range: NSRange(location: 0, length: attr.length))
        
        /// 约束创建 避免UILabel还没出来
        textLabel.sizeToFit()
        textLabel.textColor = UIColor(patternImage: getGradientImage(size: textLabel.bounds.size))
    }
    
    /// 生成渐变色图片
    func getGradientImage(size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        guard let context = UIGraphicsGetCurrentContext() else { return UIImage() }
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        /// 设置渐变色
        let gradientRef = CGGradient(colorsSpace: colorSpace, colors: [UIColor.black.cgColor, UIColor.white.cgColor] as CFArray, locations: nil)!
        let startPoint = CGPoint(x: size.width / 2, y: 0)
        let endPoint = CGPoint(x: size.width / 2, y: size.height)
        context.drawLinearGradient(gradientRef, start: startPoint, end: endPoint, options: CGGradientDrawingOptions(arrayLiteral: .drawsBeforeStartLocation,.drawsAfterEndLocation))
        let gradientImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return gradientImage ?? UIImage()
    }


}

