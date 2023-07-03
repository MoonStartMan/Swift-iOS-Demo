//
//  SliderView.swift
//  StackView-Demo
//
//  Created by 王潇 on 2023/6/29.
//

import UIKit

class SliderView: UIView {
    
    private let textLabel: UILabel = UILabel()
    
    private let slider: UISlider = UISlider()
    
    var textContent: String? {
        didSet {
            if let textContent = textContent {
                textLabel.text = textContent
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .brown
        
        addSubview(textLabel)
        textLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(16)
        }
        textLabel.textColor = .black
        textLabel.font = .systemFont(ofSize: 14.0, weight: .bold)
        
        addSubview(slider)
        slider.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(textLabel.snp.right).offset(16)
            make.right.equalTo(-16)
            make.width.lessThanOrEqualTo(100)
        }
        slider.maximumValue = 100
        slider.minimumValue = 0
        slider.value = 50
        slider.minimumTrackTintColor = .red
        slider.maximumTrackTintColor = .gray
        slider.thumbTintColor = .blue
        slider.addTarget(self, action: #selector(sliderValueChanged(sender:)), for: .valueChanged)
        slider.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @objc func sliderValueChanged(sender: UISlider) {
        let value = sender.value
    }
}
