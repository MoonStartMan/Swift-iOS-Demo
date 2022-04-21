//
//  EditColorView.swift
//  swift-picture-color-demo
//
//  Created by 王潇 on 2022/4/18.
//

import UIKit

class EditColorView: UIView {
    
    private var contentImageView: UIImageView!
    
    private var editColorControlView: EditColorControlView!
    
    private var currentColor: UIColor? {
        didSet {
            
        }
    }
    
    var currentImage: UIImage? {
        didSet {
            if let image = currentImage {
                contentImageView.image = image
                contentImageView.contentMode = .scaleAspectFill
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    private func setupUI() {
        contentImageView = UIImageView()
        addSubview(contentImageView)
        contentImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        editColorControlView = EditColorControlView()
        addSubview(editColorControlView)
        editColorControlView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(80)
        }
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(touchMove(pan:)))
        editColorControlView.addGestureRecognizer(pan)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(touchClick(tap:)))
        self.addGestureRecognizer(tap)
        
        firstInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func touchClick(tap: UITapGestureRecognizer) {
        let location = tap.location(in: self)
        var x = location.x,
            y = location.y
        x = min(max(0, x), self.frame.size.width)
        y = min(max(0, y), self.frame.size.height)
        editColorControlView.center = CGPoint(x: x, y: y)
        if let image = currentImage,
           let color = cxg_getPointColor(withImage: image, point: CGPoint(x: x, y: y)) {
            editColorControlView.updateColor(color: color)
            currentColor = color
        }
        if tap.state == .ended || tap.state == .cancelled || tap.state == .ended {
            autoDismiss()
        }
    }
    
    @objc func touchMove(pan: UIPanGestureRecognizer) {
        let location = pan.location(in: self)
        var x = location.x,
            y = location.y
        x = min(max(0, x), self.frame.size.width)
        y = min(max(0, y), self.frame.size.height)
        editColorControlView.center = CGPoint(x: x, y: y)
        if pan.state == .changed {
            if let image = currentImage,
               let color = cxg_getPointColor(withImage: image, point: CGPoint(x: x, y: y)) {
                editColorControlView.updateColor(color: color)
                currentColor = color
            }
        } else if pan.state == .ended || pan.state == .cancelled || pan.state == .failed {
            autoDismiss()
        } else if pan.state == .began {
            NSObject.cancelPreviousPerformRequests(withTarget: self)
        }
    }
    
    func cxg_getPointColor(withImage image: UIImage, point: CGPoint) -> UIColor? {
        guard CGRect(origin: CGPoint(x: 0, y: 0), size: image.size).contains(point) else {
            return nil
        }
        let pointX = trunc(point.x);
        let pointY = trunc(point.y);
        let width = image.size.width;
        let height = image.size.height;
        let colorSpace = CGColorSpaceCreateDeviceRGB();
        var pixelData: [UInt8] = [255, 255, 255]
        pixelData.withUnsafeMutableBytes { pointer in
            if let context = CGContext(data: pointer.baseAddress, width: 1, height: 1, bitsPerComponent: 8, bytesPerRow: 4, space: colorSpace, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue), let cgImage = image.cgImage {
                context.setBlendMode(.copy)
                context.translateBy(x: -pointX, y: pointY - height)
                context.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))
            }
        }
        let red = CGFloat(pixelData[0]) / CGFloat(255.0)
        let green = CGFloat(pixelData[1]) / CGFloat(255.0)
        let blue = CGFloat(pixelData[2]) / CGFloat(255.0)
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
    
    func firstInit() {
        super.layoutIfNeeded()
        let origin = editColorControlView.frame.origin
        if let image = currentImage,
           let color = cxg_getPointColor(withImage: image, point: origin) {
            editColorControlView.updateColor(color: color)
        }
    }
    
    func autoDismiss() {
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        perform(#selector(dismissView), with: nil, afterDelay: 0.5)
    }
    
    @objc func dismissView() {
        self.removeFromSuperview()
    }
}
