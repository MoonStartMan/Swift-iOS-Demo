//
//  ViewController.swift
//  CoreAnimation-Demo
//
//  Created by 王潇 on 2023/3/6.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private var calayerView: CALayerView = CALayerView()
    
    private var cgaffineTransFromView: CGAffineTransformView = CGAffineTransformView()
    
    private var cashapeLayerView: CAShapeLayerView = CAShapeLayerView()
    
    private var reflectionView: ReflectionView = ReflectionView()
    
    private var cascrollView: CAScrollLayerView = CAScrollLayerView()
    
    private var catileLayerView: CATiledLayerView = CATiledLayerView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setCATiledLayerView()
    }
}

extension ViewController {
    /// CALayer Demo
    func DoCALayerView() {
        view.addSubview(calayerView)
        calayerView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(100)
        }
        
        calayerView.setContents()
    }
    
    /// CGAffineTransform Demo
    func DoCGAffineTransformView() {
        view.addSubview(cgaffineTransFromView)
        cgaffineTransFromView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(100)
        }
    }
    
    /// CAShapeLayerView
    func DoDrawShapeLayer() {
        view.addSubview(cashapeLayerView)
        cashapeLayerView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(100)
        }
    }
    
    /// ReflectionView
    func setReflectionView() {
        view.addSubview(reflectionView)
        reflectionView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(100)
        }
    }
    
    /// CAScrollView
    func setCAScrollView() {
        view.addSubview(cascrollView)
        cascrollView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(200)
        }
    }
    
    /// CATiledLayerView
    func setCATiledLayerView() {
        view.addSubview(catileLayerView)
        catileLayerView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(200)
        }
    }
}
