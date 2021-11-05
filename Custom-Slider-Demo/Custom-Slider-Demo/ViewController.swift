//
//  ViewController.swift
//  Custom-Slider-Demo
//
//  Created by 王潇 on 2021/8/27.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let slider = MSSlider(frame: .zero)
        self.view.addSubview(slider)
        slider.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(200)
            make.width.equalTo(300)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
        }
        
        let label = UILabel()
        self.view.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalTo(slider.snp.bottom).offset(20)
            make.width.equalTo(300)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
        }

        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .black
        label.text = "0"
        label.textAlignment = .center

        /// slider Value变化的值
        slider.sliderChange = { (value: Int) -> Void in
            label.text = "\(value)"
        }
        slider.cornerRadius = 5 /// 设置slider的圆角
        slider.sliderHeight = 30    /// 设置slider的高度
        slider.sliderSize = CGRect(x: 0, y: 0, width: 20, height: 20)   /// 设置滑块的大小
        slider.bgColor = .red   /// 设置slider的背景色
        slider.processColor = .blue /// 设置slider进度条部分的背景色
        slider.thumbImage = UIImage(named: "slider-block")  /// 设置slider滑块的图片
        slider.thumbColor = .systemGray4 ///    设置滑块的颜色
        slider.minimumValue = -100  /// 设置最小值
        slider.maximumValue = 100   /// 设置最大值
        slider.sliderProcess = 50
    }


}

