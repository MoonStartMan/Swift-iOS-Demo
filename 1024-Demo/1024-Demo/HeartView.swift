//
//  HeartView.swift
//  1024-Demo
//
//  Created by 王潇 on 2022/10/24.
//

import UIKit

/// 循环次数
var loopIndex: Int = 0
/// 循环时间
var timeInterval: TimeInterval = 0.2
/// 切换时间
var switchTimeInterval: TimeInterval = 1.0
// 熄灭颜色
let extinctColor = UIColor.white
// 点亮颜色
let lightingColor = UIColor.red

class HeartView: UIView {
    
    // 圆半径
    let R: CGFloat = 75
    
    // 绘制路径
    var pathArray: [UIBezierPath] = []
    
    // 所有的view
    var allArray: [UIView] = []
    
    // 左边
    var leftArray: [UIView] = []
    
    // 右边
    var rightArray: [UIView] = []
    
    // 左上边
    var leftUpArray: [UIView] = []
     
    // 左下边
    var leftDownArray: [UIView] = []
    
    // 右上边
    var rightUpArray: [UIView] = []
     
    // 右下边
    var rightDownArray: [UIView] = []

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        let centerX = self.width * 0.5
        let centerY = self.height * 0.5
        
        // (centerX ,centerY + sqrt(2)R)
        // (centerX - sqrt(2)R ,centerY)
        // (centerX + sqrt(2)R ,centerY)
        // (centerX - sqrt(2)R * 0.5 ,centerY - sqrt(2)R * 0.5)
        // (centerX + sqrt(2)R * 0.5 ,centerY - sqrt(2)R * 0.5)
        
        let lLine = UIBezierPath()
        lLine.move(to: CGPoint(x: centerX, y: centerY + sqrt(2) * R))
        lLine.addLine(to: CGPoint(x: centerX - sqrt(2) * R, y: centerY))
        
        let lArc = UIBezierPath(arcCenter: CGPoint(x: centerX - sqrt(2) * R * 0.5, y: centerY - sqrt(2) * R * 0.5), radius: R, startAngle: CGFloat(Double.pi * 0.75), endAngle: CGFloat(Double.pi * 1.75), clockwise: true)
        
        let rArc = UIBezierPath(arcCenter: CGPoint(x: centerX + sqrt(2) * R * 0.5, y: centerY - sqrt(2) * R * 0.5), radius: R, startAngle: CGFloat(Double.pi * 1.25), endAngle: CGFloat(Double.pi * 2.25), clockwise: true)
        
        let rLine = UIBezierPath()
        rLine.move(to: CGPoint(x: centerX + sqrt(2) * R, y: centerY))
        rLine.addLine(to: CGPoint(x: centerX, y: centerY + sqrt(2) * R))
        
        pathArray.append(lLine)
        pathArray.append(lArc)
        pathArray.append(rArc)
        pathArray.append(rLine)
        
        let rightCenter = CGPoint(x: centerX + sqrt(2) * R * 0.5, y: centerY - sqrt(2) * R * 0.5)
        let leftCenter = CGPoint(x: centerX - sqrt(2) * R * 0.5, y: centerY - sqrt(2) * R * 0.5)
        
        // 右上
        for i in 0..<8 {
            let view = UIView()
            view.backgroundColor = extinctColor
            self.addSubview(view)
            view.layer.cornerRadius = 8
            view.layer.masksToBounds = true
            view.size = CGSize(width: 16, height: 16)
            view.center = getPointCenter(center: rightCenter, angle: CGFloat(-20 + i * 20))
            rightUpArray.append(view)
        }
        
        // 右下
        for b in 0..<8 {
            let view = UIView()
            view.backgroundColor = extinctColor
            self.addSubview(view)
            view.layer.cornerRadius = 8
            view.layer.masksToBounds = true
            view.size = CGSize(width: 16, height: 16)
            let offsetX: CGFloat = CGFloat(b) * (CGFloat(sqrt(2) * R) / 7) + 10.0
            view.center = CGPoint(x: centerX + offsetX, y: centerY + (CGFloat(sqrt(2) * R) - offsetX))
            rightDownArray.append(view)
        }
        
        // 左上
        for j in 0..<8 {
            let view = UIView()
            view.backgroundColor = extinctColor
            self.addSubview(view)
            view.layer.cornerRadius = 8
            view.layer.masksToBounds = true
            view.size = CGSize(width: 16, height: 16)
            view.center = getPointCenter(center: leftCenter, angle: CGFloat(60 + j * 20))
            leftUpArray.append(view)
        }
        
        // 左下
        for a in 0..<8 {
            let view = UIView()
            view.backgroundColor = extinctColor
            self.addSubview(view)
            view.layer.cornerRadius = 8
            view.layer.masksToBounds = true
            view.size = CGSize(width: 16, height: 16)
            let offsetX: CGFloat = CGFloat(a) * (CGFloat(sqrt(2) * R) / 7) + 10.0
            view.center = CGPoint(x: centerX - offsetX, y: centerY + (CGFloat(sqrt(2) * R) - offsetX))
            leftDownArray.append(view)
        }
        
        // 顺时针360
        rightUpArray = rightUpArray.reversed()
        rightDownArray = rightDownArray.reversed()
        leftUpArray = leftUpArray.reversed()
        allArray = rightUpArray + rightDownArray + leftDownArray + leftUpArray
        
        // 逆时针180
        let leftUpArr: [UIView] = leftUpArray.reversed()
        let leftDownArr: [UIView] = leftDownArray.reversed()
        leftArray = leftUpArr + leftDownArr
        
        // 顺时针180
        rightArray = rightUpArray + rightDownArray
    }
    
    func getPointCenter(center: CGPoint, angle: CGFloat) -> CGPoint {
        let x = 75 * cosf(Float(angle * CGFloat(Double.pi) / 180))
        let y = 75 * sinf(Float(angle * CGFloat(Double.pi) / 180))
        return CGPoint(x: center.x + CGFloat(x), y: center.y - CGFloat(y))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        
        for path in self.pathArray {
            UIColor.red.set()
            path.lineWidth = 1
            path.lineCapStyle = .round
            path.lineJoinStyle = .round
            path.stroke()
        }
    }
}
