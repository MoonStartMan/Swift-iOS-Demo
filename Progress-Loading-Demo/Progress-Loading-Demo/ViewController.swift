//
//  ViewController.swift
//  Progress-Loading-Demo
//
//  Created by 王潇 on 2021/9/6.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    var circle: CircleView!
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        circle = CircleView(frame: .zero)
        self.view.addSubview(circle)
        circle.snp.makeConstraints { make in
            make.width.height.equalTo(200)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        circle.progerssColor = .systemPink
        circle.progerssBackgroundColor = .systemTeal
        
        addTimer()
        
    }
    
    func addTimer() {
        timer = Timer(timeInterval: 0.05, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        RunLoop.main.add(timer, forMode: .common)
    }
    
    @objc func timerAction() {
        circle.progress += 1
        circle.setProgress(progress: circle.progress)
        
        if (circle.progress >= 100) {
            removeTimer()
            print("完成")
        }
    }
    
    func removeTimer() {
        timer.invalidate()
        timer = nil
    }
}
