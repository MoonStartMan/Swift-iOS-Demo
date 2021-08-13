//
//  ViewController.swift
//  Swift-Touch-Demo
//
//  Created by 王潇 on 2021/8/13.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    /// 文字Label
    var textLabel: UILabel!
    /// 底部展示label
    var bottomLabel: UILabel!
    /// 外部View
    var coverView: UIView!
    /// drakgrayView
    var drakgrayView: UIView!
    /// orangeView
    var orangeView: UIView!
    /// X坐标
    var point: (CGFloat, CGFloat) = (0, 0) {
        didSet {
            textLabel.text = "当前坐标 (\(ceil(point.0)), \(ceil(point.1)))"
        }
    }
    /// 文字部分
    var labelMessage: (CGFloat, CGFloat) = (0, 0) {
        didSet {
            bottomLabel.text = "两点之间的距离为: \(ceil(labelMessage.0)), 两点之间的角度为: \(ceil(labelMessage.1))"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }

}

extension ViewController {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        switch touches.first?.view {
            case coverView: coverViewBackGround()
            case drakgrayView: drakgrayViewBackGround()
            case orangeView: orangeViewBackGround()
            default: defaultViewBackGround()
        }
    }
    
    func coverViewBackGround() {
        self.view.backgroundColor = coverView.backgroundColor
    }
    
    func drakgrayViewBackGround() {
        self.view.backgroundColor = drakgrayView.backgroundColor
    }
    
    func orangeViewBackGround() {
        self.view.backgroundColor = orangeView.backgroundColor
    }
    
    func defaultViewBackGround() {
        self.view.backgroundColor = .white
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let t: UITouch = touch as! UITouch
            point.0 = t.location(in: view).x
            point.1 = t.location(in: view).y
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.count == 2 {
            /// 获取触摸点
            let first = (touches as NSSet).allObjects[0] as! UITouch
            let second = (touches as NSSet).allObjects[1] as! UITouch
            /// 获取触摸点坐标
            let firstPoint = first.location(in: view)
            let secondPoint = second.location(in: view)
            /// 计算两点间的距离
            let deltaX = secondPoint.x - firstPoint.x
            let deltaY = secondPoint.y - firstPoint.y
            labelMessage.0 = sqrt(deltaX*deltaX + deltaY * deltaY)
            /// 计算两点间的角度
            let height = secondPoint.y - firstPoint.y
            let width = firstPoint.x - secondPoint.x
            let rads = atan(height/width);
            labelMessage.1 = CGFloat(180.0 * Double(rads) / .pi)
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("点击取消")
    }
}

extension ViewController {
    
    func setUI() {
        //  支持多点触摸
        view.isMultipleTouchEnabled = true
        
        textLabel = UILabel()
        view.addSubview(textLabel)
        textLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.centerX.equalToSuperview()
            make.height.equalTo(20)
        }
        textLabel.textColor = .black
        textLabel.font = .systemFont(ofSize: 14, weight: .bold)
        textLabel.text = "当前坐标 (\(point.0), \(point.1))"
        
        coverView = UIView()
        view.addSubview(coverView)
        coverView.backgroundColor = .red
        coverView.snp.makeConstraints { make in
            make.left.equalTo(50)
            make.right.equalTo(-50)
            make.top.equalTo(200)
            make.bottom.equalTo(-200)
        }
        coverView.layer.cornerRadius = 10
        coverView.layer.masksToBounds = true
        
        drakgrayView = UIView()
        view.addSubview(drakgrayView)
        drakgrayView.backgroundColor = .darkGray
        drakgrayView.snp.makeConstraints { make in
            make.left.equalTo(coverView).offset(50)
            make.right.equalTo(coverView).offset(-50)
            make.top.equalTo(coverView).offset(100)
            make.bottom.equalTo(coverView).offset(-100)
        }
        drakgrayView.layer.cornerRadius = 10
        drakgrayView.layer.masksToBounds = true
        
        orangeView = UIView()
        drakgrayView.addSubview(orangeView)
        orangeView.backgroundColor = .orange
        orangeView.snp.makeConstraints { make in
            make.left.equalTo(drakgrayView).offset(30)
            make.right.equalTo(drakgrayView).offset(-30)
            make.top.equalTo(drakgrayView).offset(50)
            make.bottom.equalTo(drakgrayView).offset(-50)
        }
        orangeView.layer.cornerRadius = 10
        orangeView.layer.masksToBounds = true
        
        bottomLabel = UILabel()
        view.addSubview(bottomLabel)
        bottomLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-50)
            make.centerX.equalToSuperview()
            make.height.equalTo(20)
        }
        bottomLabel.textColor = .black
        bottomLabel.font = .systemFont(ofSize: 14, weight: .bold)
        bottomLabel.text = "两点之间的距离为: \(ceil(labelMessage.0)), 两点之间的角度为: \(ceil(labelMessage.1))"
    }
    
}
