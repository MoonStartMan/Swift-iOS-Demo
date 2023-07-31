//
//  ViewController.swift
//  Throttling-Demo
//
//  Created by 王潇 on 2023/7/27.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    let throttle = Throttle(label: "123", interval: 0.1)
    let debouncer = Debouncer(label: "123", interval: 2000)
    
    private var slider: UISlider = UISlider()
    
    private var textLabel: UILabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        view.addSubview(slider)
        slider.snp.makeConstraints { make in
            make.left.equalTo(36)
            make.right.equalTo(-36)
            make.centerY.equalToSuperview()
            make.height.equalTo(40)
        }
        slider.addTarget(self, action: #selector(sliderValueChange(sender:)), for: .valueChanged)
        
        view.addSubview(textLabel)
        textLabel.snp.makeConstraints { make in
            make.top.equalTo(slider.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        textLabel.textAlignment = .left
        textLabel.font = .systemFont(ofSize: 16.0, weight: .bold)
        textLabel.textColor = .black
    }
    
    @objc func sliderValueChange(sender: UISlider) {
        throttle.call { [weak self] in
            DispatchQueue.main.async {
                self?.textLabel.text = "\(sender.value)"
            }
        }
    }
}

