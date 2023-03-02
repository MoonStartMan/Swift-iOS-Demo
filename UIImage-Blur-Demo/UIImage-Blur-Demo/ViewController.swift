//
//  ViewController.swift
//  UIImage-Blur-Demo
//
//  Created by 王潇 on 2023/3/2.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    private var imageView: UIImageView = UIImageView()
    
    private var slider: UISlider = UISlider()
    
    private var sliderLabel: UILabel = UILabel()
    
    //原图
    private var originalImage: UIImage = {
        return UIImage(named: "image")
    }()!
     
    private var context: CIContext = {
        return CIContext(options: nil)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }

    private func setupView() {
        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.equalTo(100)
            make.height.equalTo(300)
            make.centerX.equalToSuperview()
        }
        imageView.image = UIImage(named: "image")
        imageView.contentMode = .scaleAspectFit
        
        view.addSubview(sliderLabel)
        sliderLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
        }
        sliderLabel.text = "0"
        sliderLabel.textColor = .black
        sliderLabel.font = .systemFont(ofSize: 30, weight: .bold)
        
        view.addSubview(slider)
        slider.snp.makeConstraints { make in
            make.top.equalTo(sliderLabel.snp.bottom).offset(30)
            make.left.equalTo(40)
            make.right.equalTo(-40)
            make.height.equalTo(30)
        }
        slider.maximumValue = 100
        slider.minimumValue = 0
        slider.addTarget(self, action: #selector(sliderValueChanged(sender:)), for: .valueChanged)
    }
    
    private func CIBloomImage(value: Float) -> UIImage {
        //获取原始图片
        let inputImage =  CIImage(image: originalImage)
        //使用高斯模糊滤镜
        let filter = CIFilter(name: "CIBloom")!
        filter.setValue(inputImage, forKey:kCIInputImageKey)
        //设置模糊半径值（越大越模糊）
        filter.setValue(Int(value), forKey: kCIInputRadiusKey)
        let outputCIImage = filter.outputImage!
        let rect = CGRect(origin: CGPoint.zero, size: originalImage.size)
        let cgImage = context.createCGImage(outputCIImage, from: rect)!
        return UIImage(cgImage: cgImage)
    }
    

    @objc func sliderValueChanged(sender: UISlider) {
        //获取原始图片
        let inputImage =  CIImage(image: CIBloomImage(value: sender.value))
        //使用高斯模糊滤镜
        let filter = CIFilter(name: "CIGaussianBlur")!
        filter.setValue(inputImage, forKey:kCIInputImageKey)
        //设置模糊半径值（越大越模糊）
        filter.setValue(Int(sender.value), forKey: kCIInputRadiusKey)
        sliderLabel.text = "\(Int(sender.value))"
        let outputCIImage = filter.outputImage!
        let rect = CGRect(origin: CGPoint.zero, size: originalImage.size)
        let cgImage = context.createCGImage(outputCIImage, from: rect)
        //显示生成的模糊图片
        imageView.image = UIImage(cgImage: cgImage!)
    }
}

