//
//  ViewController.swift
//  RunTime-RunLoop
//
//  Created by 王潇 on 2023/7/4.
//

import UIKit

class ViewController: UIViewController {

    var timer: Timer?
    
    var currentNum: Int = 0
    
    var isPlay: Bool = false
    
    private var button = UIButton(type: .system)
    
    private var timeLabel: UILabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //  创建一个按钮
        button.frame = CGRect(x: 100, y: 100, width: 200, height: 50)
        button.setTitle("Start Timer", for: .normal)
        button.addTarget(self, action: #selector(startTimer), for: .touchUpInside)
        view.addSubview(button)
        
        view.addSubview(timeLabel)
        timeLabel.frame = CGRect(x: 0, y: 150, width: UIScreen.main.bounds.width, height: 40)
        timeLabel.textColor = .black
        timeLabel.font = .systemFont(ofSize: 40, weight: .bold)
        timeLabel.textAlignment = .center
    }

    @objc func startTimer() {
        if !isPlay {
            //  创建一个定时器
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerHandler(timer: )), userInfo: nil, repeats: true)
            
            //  将定时器添加到当前RunLoop中,并设置RunLoop的运行模式为默认模式
            RunLoop.current.add(timer!, forMode: .default)
            isPlay = !isPlay
        } else {
            timer?.invalidate()
            timer = nil
            isPlay = !isPlay
        }
        button.setTitle(isPlay ? "Stop Timer" : "Start Timer", for: .normal)
    }

    @objc func timerHandler(timer: Timer) {
        currentNum += 1
        timeLabel.text = "\(currentNum)"
    }
}

