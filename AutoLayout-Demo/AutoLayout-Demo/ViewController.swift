//
//  ViewController.swift
//  AutoLayout-Demo
//
//  Created by 王潇 on 2022/12/21.
//

import UIKit

class ViewController: UIViewController {
    
    private var redView = UIView()
    
    private var greenView = UIView()
    
    private var blackView = UIView()
    
    private var view1 = UIView()
    
    private var view2 = UIView()
    
    private var view3 = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        /// 左上角红色View
//        redView.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(redView)
//        redView.backgroundColor = .systemRed
//
//        let redViewLeft = NSLayoutConstraint(item: redView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0)
//        let redViewWidth = NSLayoutConstraint(item: redView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 100)
//        let redViewTop = NSLayoutConstraint(item: redView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0)
//        let redViewHeight = NSLayoutConstraint(item: redView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 200)
//        redView.superview?.addConstraints([redViewLeft, redViewWidth, redViewTop, redViewHeight])
//
//        /// 全屏绿色View
//        greenView.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(greenView)
//        greenView.backgroundColor = .systemGreen
//        let greenViewLeft = NSLayoutConstraint(item: greenView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0)
//        let greenViewRight = NSLayoutConstraint(item: greenView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0)
//        let greenViewTop = NSLayoutConstraint(item: greenView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0)
//        let greenViewBottom = NSLayoutConstraint(item: greenView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
//        greenView.superview?.addConstraints([greenViewLeft, greenViewRight, greenViewTop, greenViewBottom])
//
//        /// 屏幕居中的黑色View
//        blackView.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(blackView)
//        blackView.backgroundColor = .black
//        let blackViewCenterX = NSLayoutConstraint(item: blackView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
//        let blackViewCenterY = NSLayoutConstraint(item: blackView, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0)
//        let blackViewWidth = NSLayoutConstraint(item: blackView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 100)
//        let blackViewHeight = NSLayoutConstraint(item: blackView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 100)
//        blackView.superview?.addConstraints([blackViewCenterX, blackViewCenterY, blackViewWidth, blackViewHeight])
        
        view.addSubview(view1)
        view1.translatesAutoresizingMaskIntoConstraints = false
        view1.backgroundColor = .systemCyan
        view.addSubview(view2)
        view2.translatesAutoresizingMaskIntoConstraints = false
        view2.backgroundColor = .systemBlue
        view.addSubview(view3)
        view3.translatesAutoresizingMaskIntoConstraints = false
        view3.backgroundColor = .systemPink
        
        let view1Left = NSLayoutConstraint(item: view1, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 20)
        let view1Top = NSLayoutConstraint(item: view1, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 64)
        let view1Height = NSLayoutConstraint(item: view1, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 200)
        let view1Width = NSLayoutConstraint(item: view1, attribute: .width, relatedBy: .equal, toItem: view2, attribute: .width, multiplier: 1, constant: 0)
        view1.superview?.addConstraints([view1Left, view1Top, view1Height, view1Width])
        
        let view3Right = NSLayoutConstraint(item: view3, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: -20)
        let view3Top = NSLayoutConstraint(item: view3, attribute: .top, relatedBy: .equal, toItem: view1, attribute: .top, multiplier: 1, constant: 0)
        let view3Height = NSLayoutConstraint(item: view3, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 200)
        let view3Width = NSLayoutConstraint(item: view3, attribute: .width, relatedBy: .equal, toItem: view1, attribute: .width, multiplier: 1, constant: 0)
        view3.superview?.addConstraints([view3Height, view3Top, view3Right, view3Width])
        
        let view2Left = NSLayoutConstraint(item: view2, attribute: .left, relatedBy: .equal, toItem: view1, attribute: .right, multiplier: 1, constant: 20)
        let view2Right = NSLayoutConstraint(item: view2, attribute: .right, relatedBy: .equal, toItem: view3, attribute: .left, multiplier: 1, constant: -20)
        let view2Height = NSLayoutConstraint(item: view2, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 200)
        let view2Top = NSLayoutConstraint(item: view2, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 64)
        view2.superview?.addConstraints([view2Left, view2Right, view2Height, view2Top])
    }


}

