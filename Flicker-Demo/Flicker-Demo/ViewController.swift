//
//  ViewController.swift
//  Flicker-Demo
//
//  Created by 王潇 on 2023/9/18.
//

import UIKit

class ViewController: UIViewController {
    
    private var panelLoadAnimateView: PanelLoadAnimateView = PanelLoadAnimateView()
    
    private let kScreenWidth = UIScreen.main.bounds.size.width

    override func viewDidLoad() {
       super.viewDidLoad()
       
        view.addSubview(panelLoadAnimateView)
        panelLoadAnimateView.snp.makeConstraints { make in
            make.width.equalTo(kScreenWidth)
            make.height.equalTo(364)
            make.left.right.bottom.equalToSuperview()
        }
        panelLoadAnimateView.backgroundColor = .clear
   }

}

class ScanAnimationView: UIView {
    
    private let scanLayer = CALayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupScanLayer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupScanLayer()
    }
    
    private func setupScanLayer() {
        scanLayer.backgroundColor = UIColor.white.cgColor
        scanLayer.transform = CATransform3DMakeRotation(.pi/4, 0, 0, 1)
        scanLayer.opacity = 0.7
        layer.addSublayer(scanLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        scanLayer.frame = CGRect(x: 0, y: bounds.height, width: bounds.width, height: 0)
    }
    
    func startAnimation() {
        let animation = CABasicAnimation(keyPath: "bounds")
        animation.fromValue = NSValue(cgRect: CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height))
        animation.toValue = NSValue(cgRect: CGRect(x: bounds.width, y: 0, width: bounds.width, height: bounds.height))
        animation.duration = 1.6
        animation.repeatCount = .infinity
        animation.autoreverses = true
        scanLayer.add(animation, forKey: "scanAnimation")
    }
    
    func stopAnimation() {
        scanLayer.removeAnimation(forKey: "scanAnimation")
    }
}
