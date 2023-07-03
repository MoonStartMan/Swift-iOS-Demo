//
//  BottomStackView.swift
//  StackView-Demo
//
//  Created by 王潇 on 2023/6/28.
//

import UIKit

class BottomStackView: UIStackView {
    
    private let topSliderView: SliderView = SliderView()
    
    private let centerSliderView: SliderView = SliderView()
    
    private let bottomSliderView: SliderView = SliderView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addArrangedSubview(topSliderView)
        addArrangedSubview(centerSliderView)
        addArrangedSubview(bottomSliderView)
        
        topSliderView.textContent = "topSliderValue"
        centerSliderView.textContent = "centerSliderValue"
        bottomSliderView.textContent = "bottomSliderValue"
    }
}
