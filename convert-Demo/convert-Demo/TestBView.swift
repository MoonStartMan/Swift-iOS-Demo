//
//  TestBView.swift
//  convert-Demo
//
//  Created by 王潇 on 2022/2/14.
//

import UIKit

class TestBView: UIView {
    
    var presonBView: TestBPersonView = TestBPersonView()
    
    var currentPoint: CGPoint = CGPoint(x: 0, y: 0) {
        didSet {
            presonBView.snp.remakeConstraints { make in
                make.top.equalToSuperview().offset(UIScreen.main.bounds.origin.y -  currentPoint.y)
                make.width.height.equalTo(24)
                make.left.equalTo(currentPoint.x / 2)
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(presonBView)
        presonBView.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.centerX.centerY.equalToSuperview()
        }
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
