//
//  TestView.swift
//  Swift-hitTest-View
//
//  Created by 王潇 on 2021/9/28.
//

import UIKit

class TestView: UIView {
    
    private var hitView: UIView!
    
    private var coverView: UIView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension TestView {
    func setUI() {
        coverView = UIView()
        self.addSubview(coverView)
        coverView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 200, height: 200))
        }
        coverView.backgroundColor = UIColor.init(displayP3Red: 0, green: 0, blue: 0, alpha: 0.8)
//        coverView.isUserInteractionEnabled = true
        
        hitView = UIView()
        coverView.addSubview(hitView)
        hitView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        hitView.backgroundColor = UIColor.systemPink
//        hitView.isUserInteractionEnabled = false
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(click))
        
        coverView.addGestureRecognizer(gesture)
    }
    
    @objc func click() {
        print("点击")
    }
}

extension TestView {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let coverPoint = self.convert(point, to: coverView)
        if coverView.point(inside: coverPoint, with: event) {
            return coverView
        }
        return super.hitTest(point, with: event)
    }
}
