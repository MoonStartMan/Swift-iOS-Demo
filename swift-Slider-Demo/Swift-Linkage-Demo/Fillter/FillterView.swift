//
//  FillterView.swift
//  Swift-Linkage-Demo
//
//  Created by 王潇 on 2021/8/25.
//

import UIKit

class FillterView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let sliderView = SliderView.init(frame: .zero)
        self.addSubview(sliderView)
        sliderView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(0)
            make.left.right.equalToSuperview()
            make.height.equalTo(60)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
