//
//  ViewController.swift
//  MovingViewDemo
//
//  Created by 王潇 on 2022/9/11.
//

import UIKit

class ViewController: UIViewController, MovingViewProtocol {
    
    private var drawMarqueeView0: MovingView!
    private var drawMarqueeView1: MovingView!
    private var drawMarqueeView2: MovingView!
    private var drawMarqueeView3: MovingView!
    
    func drawMarqueeView(drawMarqueeView: MovingView, animationDidStopFinished: Bool) {
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        drawMarqueeView0 = MovingView.init(frame: CGRect.init(x: 0, y: 104, width: UIScreen.main.bounds.size.width, height: 20.0))
        drawMarqueeView0.delegate = self
        drawMarqueeView0.speed = 1
        drawMarqueeView0.backgroundColor = UIColor.clear
        drawMarqueeView0.moveType = .bottom
        drawMarqueeView0.speedType = .normal
        self.view.addSubview(drawMarqueeView0)
        drawMarqueeView0.addContentView(view: self.createLabelWithText(text: "哈哈哈哈", color: UIColor.black))
        drawMarqueeView0.startAnimation()

        drawMarqueeView1 = MovingView.init(frame: CGRect.init(x: 0, y: 144, width: UIScreen.main.bounds.size.width, height: 20.0))
        drawMarqueeView1.delegate = self
        drawMarqueeView1.speed = 1
        drawMarqueeView1.backgroundColor = UIColor.clear
        drawMarqueeView1.moveType = .right
        drawMarqueeView1.speedType = .normal
        self.view.addSubview(drawMarqueeView1)
        drawMarqueeView1.addContentView(view: self.createLabelWithText(text: "哈哈哈哈哈哈", color: UIColor.black))
        drawMarqueeView1.startAnimation()
        
        drawMarqueeView2 = MovingView.init(frame: CGRect.init(x: 0, y: 184, width: UIScreen.main.bounds.size.width, height: 20.0))
        drawMarqueeView2.delegate = self
        drawMarqueeView2.speed = 1
        drawMarqueeView2.backgroundColor = UIColor.clear
        drawMarqueeView2.moveType = .left
        drawMarqueeView2.speedType = .normal
        self.view.addSubview(drawMarqueeView2)
        drawMarqueeView2.addContentView(view: self.createLabelWithText(text: "哈哈哈哈哈哈", color: UIColor.black))
        drawMarqueeView2.startAnimation()
        
        drawMarqueeView3 = MovingView.init(frame: CGRect.init(x: 0, y: 224, width: UIScreen.main.bounds.size.width, height: 20.0))
        drawMarqueeView3.delegate = self
        drawMarqueeView3.speed = 1
        drawMarqueeView3.backgroundColor = UIColor.clear
        drawMarqueeView3.moveType = .top
        drawMarqueeView3.speedType = .normal
        self.view.addSubview(drawMarqueeView3)
        drawMarqueeView3.addContentView(view: self.createLabelWithText(text: "哈哈哈哈哈哈", color: UIColor.black))
        drawMarqueeView3.startAnimation()
    }
    
    /// 创建AmationView的子视图, 这里我放置的是Label
    func createLabelWithText(text: NSString, color: UIColor) -> UILabel {
        let font: UIFont = UIFont.systemFont(ofSize: 12)
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 20))
        label.font = font
        label.text = text as String
        label.textColor = color
        label.sizeToFit()
        label.textAlignment = .center
        return label
    }


}

