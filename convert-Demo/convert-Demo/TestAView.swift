//
//  TestView.swift
//  convert-Demo
//
//  Created by 王潇 on 2022/2/14.
//

import UIKit
import SnapKit

class TestAView: UIView {
    
    private var presonAView: TestAPersonView = TestAPersonView()
    
    private var bView: TestBView = TestBView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(presonAView)
        presonAView.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.centerX.centerY.equalToSuperview()
        }
        backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
        
        addSubview(bView)
        
        presonAView.clickBtn.addTarget(self, action: #selector(showView), for: .touchUpInside)
    }
    
    @objc func showView() {
        let point = presonAView.convert(presonAView.center, to: bView.presonBView)
        bView.currentPoint = point
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
