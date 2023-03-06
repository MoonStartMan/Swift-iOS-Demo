//
//  ViewController.swift
//  iOS-Blur-Demo
//
//  Created by 王潇 on 2023/3/4.
//

import UIKit
import Accelerate
import SnapKit

class ViewController: UIViewController {
    
    private var imageView: UIImageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupView()
    }

    private func setupView() {
        
        imageView.image = setCoreImageBlur(image: UIImage(named: "demo")!, blurLevel: 20)
//        imageView.image = setVImage(image: UIImage(named: "demo")!, blur: 0.8)
        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.left.equalTo(40)
            make.right.equalTo(-40)
            make.centerY.equalToSuperview()
        }
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
    }
    
    /// CoreImage实现模糊效果
    private func setCoreImageBlur(image: UIImage, blurLevel: CGFloat) -> UIImage {
        let ciImage = CIImage(image: image)
        
        let filter = CIFilter(name: "CIGaussianBlur")!
        filter.setValue(ciImage, forKey: kCIInputImageKey)
        
        filter.setValue(blurLevel, forKey: kCIInputRadiusKey)
        let outputCIImage = filter.outputImage!
        let rect = CGRect(origin: CGPoint.zero, size: image.size)
        let createCgImage = CIContext(options: nil).createCGImage(outputCIImage, from: rect)!
        return UIImage(cgImage: createCgImage)
    }
    
    /// vImage实现模糊效果
//    private func setVImage(image: UIImage, blur: CGFloat) -> UIImage {
//        var blur = blur
//        if blur < 0.0 || blur > 1.0 {
//            blur = 0.5
//        }
//        var boxSize = Int(blur * 40)
//        boxSize = boxSize - (boxSize % 2) + 1
//        let img = image.cgImage
//
//        var inBuffer = vImage_Buffer()
//        var outBuffer = vImage_Buffer()
//        var error: vImage_Error!
//
//        //  从CGImage中获取数据
//        let inProvider = image.cgImage?.dataProvider
//        let inBitmapData = inProvider?.data
//
//        //  设置从CGImage获取对象的属性
//        inBuffer.width = UInt(img!.width)
//        inBuffer.height = UInt(img!.height)
//        inBuffer.rowBytes = img!.bytesPerRow
//        inBuffer.data = UnsafeMutableRawPointer(mutating: CFDataGetBytePtr(inBitmapData))
//        let pixelBuffer = malloc(img!.bytesPerRow * img!.height)
//
//        outBuffer.data = pixelBuffer
//        outBuffer.width = vImagePixelCount(img!.width)
//        outBuffer.height = vImagePixelCount(img!.height)
//        outBuffer.rowBytes = img!.bytesPerRow
//        /// 抗锯齿效果
//        let piexBluffer2 = malloc(img!.bytesPerRow * img!.height)
//
//        var outBuffer2 = vImage_Buffer()
//        outBuffer2.data = piexBluffer2
//        outBuffer2.width = vImagePixelCount(img!.width)
//        outBuffer2.height = vImagePixelCount(img!.height)
//        outBuffer2.rowBytes = img!.bytesPerRow
//
//        error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, nil, 0, 0, UInt32(boxSize), UInt32(boxSize), nil, UInt32(kvImageEdgeExtend))
//
//        let colorSpace = CGColorSpaceCreateDeviceRGB()
//        let ctx = CGContext(data: outBuffer.data, width: Int(outBuffer.width), height: Int(outBuffer.height), bitsPerComponent: 8, bytesPerRow: outBuffer.rowBytes, space: colorSpace, bitmapInfo: CGImageAlphaInfo.noneSkipLast.rawValue)
//
//        let imageRef = ctx!.makeImage()
//        let returnImage = UIImage(cgImage: imageRef!)
//
//        return returnImage
//    }
}

