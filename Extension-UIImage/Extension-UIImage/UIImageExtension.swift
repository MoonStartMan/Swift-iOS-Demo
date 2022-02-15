//
//  UIImageExtension.swift
//  Extension-UIImage
//
//  Created by 王潇 on 2022/2/14.
//

import UIKit

// MARK: 颜色转UIImage
extension UIImage {
    
    public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1.0, height: 1.0)) {
        UIGraphicsBeginImageContextWithOptions(size, true, UIScreen.main.scale)
        defer {
            UIGraphicsEndImageContext()
        }
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(CGRect(origin: CGPoint.zero, size: size))
        context?.setShouldAntialias(true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        guard let cgImage = image?.cgImage else {
            self.init()
            return nil
        }
        self.init(cgImage: cgImage)
    }
    
}

// MARK: 图片设置圆角
extension UIImage {
    
    public func roundImage(byRoundingCorners: UIRectCorner = UIRectCorner.allCorners, cornerRadi: CGFloat) -> UIImage? {
        return roundImage(byRoundingCorners: byRoundingCorners, cornerRadii: CGSize(width: cornerRadi, height: cornerRadi))
    }
    
    public func roundImage(byRoundingCorners: UIRectCorner = UIRectCorner.allCorners, cornerRadii: CGSize) -> UIImage? {
        
        let imageRect = CGRect(origin: CGPoint.zero, size: size)
        /// UIGraphicsBeginImageContextWithOptions???
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        defer {
            UIGraphicsEndImageContext()
        }
        let context = UIGraphicsGetCurrentContext()
        guard context != nil else {
            return nil
        }
        context?.setShouldAntialias(true)
        let bezierPath = UIBezierPath(roundedRect: imageRect, byRoundingCorners: byRoundingCorners, cornerRadii: cornerRadii)
        bezierPath.close()
        bezierPath.addClip()
        self.draw(in: imageRect)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
}

// MARK: 图片缩放
extension UIImage {
    
    public func scaleTo(size targetSize: CGSize) -> UIImage? {
        let srcSize = self.size
        if __CGSizeEqualToSize(srcSize, targetSize) {
            return self
        }
        let scaleRatio = targetSize.width / srcSize.width
        var dstSize = CGSize(width: targetSize.width, height: targetSize.height)
        let orientation = self.imageOrientation
        /// CGAffineTransform.identity???
        var transform = CGAffineTransform.identity
        switch orientation {
        case .up:
            transform = CGAffineTransform.identity
        case .upMirrored:
            transform = CGAffineTransform(translationX: srcSize.width, y: 0.0)
            transform = transform.scaledBy(x: -1.0, y: 1.0)
        case .down:
            transform = CGAffineTransform(translationX: srcSize.width, y: srcSize.height)
            transform = transform.scaledBy(x: 1.0, y: CGFloat(M_PI))
        case .downMirrored:
            transform = CGAffineTransform(translationX: 0.0, y: -1.0)
        case .leftMirrored:
            dstSize = CGSize(width: dstSize.height, height: dstSize.width)
            transform = CGAffineTransform(translationX: srcSize.height, y: srcSize.width)
            transform = transform.scaledBy(x: -1.0, y: 1.0)
            transform = transform.rotated(by: CGFloat(3.0) * CGFloat(M_PI_2))
        case .left:
            dstSize = CGSize(width: dstSize.height,height: dstSize.width)
            transform = CGAffineTransform(translationX: 0.0,y: srcSize.width)
            transform = transform.rotated(by: CGFloat(3.0) * CGFloat(M_PI_2))
        case .rightMirrored:
            dstSize = CGSize(width: dstSize.height,height: dstSize.width)
            transform = CGAffineTransform(scaleX: -1.0,y: 1.0)
            transform = transform.rotated(by:  CGFloat(M_PI_2))
        default:
            dstSize = CGSize(width: dstSize.height,height: 0.0)
            transform = transform.rotated(by: CGFloat(M_PI_2))
        }
        
        UIGraphicsBeginImageContextWithOptions(dstSize, true, scale)
        defer {
            UIGraphicsEndImageContext()
        }
        let context = UIGraphicsGetCurrentContext()
        
        guard context != nil else {
            return nil
        }
        context?.setShouldAntialias(true)
        if orientation == UIImage.Orientation.right || orientation == UIImage.Orientation.left {
            context?.scaleBy(x: -scaleRatio,y: scaleRatio)
            context?.translateBy(x: -srcSize.height,y: 0)
        }
        else {
            context?.scaleBy(x: scaleRatio,y: -scaleRatio)
            context?.translateBy(x: 0,y: -srcSize.height)
        }
        context?.concatenate(transform)
        guard let cgImage = self.cgImage else {
            return nil
        }
        context?.draw(cgImage,in: CGRect(x: 0,y: 0,width: srcSize.width,height: srcSize.height))
        return UIGraphicsGetImageFromCurrentImageContext()!
    }
    
    public func scaleTo(fitSize targetSize: CGSize,scaleIfSmaller: Bool = false) -> UIImage? {
        let srcSize = self.size
        if __CGSizeEqualToSize(srcSize,targetSize) {
            return self
        }
        
        let orientation = self.imageOrientation
        var dstSize = targetSize
        switch orientation {
        case .left,.right,.leftMirrored,.rightMirrored:
            dstSize = CGSize(width: dstSize.height,height: dstSize.width)
        default:
            break
        }
        if !scaleIfSmaller && (srcSize.width < dstSize.width) && (srcSize.height < dstSize.height) {
            dstSize = srcSize
        }
        else {
            let wRatio = dstSize.width / srcSize.width
            let hRatio = dstSize.height / srcSize.height
            dstSize = wRatio < hRatio ?
            CGSize(width: dstSize.width,height: srcSize.height * wRatio) :
            CGSize(width: srcSize.width * wRatio,height: dstSize.height)
        }
        return self.scaleTo(size: dstSize)
    }
}

// MARK: 通过String生成二维码

extension UIImage {
    public static func generateQRImage(QRCodeString: String, logo: UIImage?, size: CGSize = CGSize(width: 50, height: 50)) -> UIImage? {
        guard let data = QRCodeString.data(using: .utf8, allowLossyConversion: false) else {
            return nil
        }
        let imageFilter = CIFilter(name: "CIQRCodeGenerator")
        imageFilter?.setValue(data, forKey: "inputMessage")
        imageFilter?.setValue("H", forKey: "inputCorrectionLevel")
        let ciImage = imageFilter?.outputImage
        
        //  创建颜色滤镜
        let colorFilter = CIFilter(name: "CIFalseColor")
        colorFilter?.setDefaults()
        colorFilter?.setValue(ciImage, forKey: "inputImage")
        colorFilter?.setValue(CIColor(red: 0, green: 0, blue: 0), forKey: "inputColor0")
        colorFilter?.setValue(CIColor(red: 1, green: 1, blue: 1), forKey: "inputColor1")
        
        //  返回二维码图片
        let qrImage = UIImage(ciImage: (colorFilter?.outputImage)!)
        let imageRect = size.width > size.height ?
        CGRect(x: (size.width - size.height) / 2, y: 0, width: size.height, height: size.height) :
        CGRect(x: 0,y: (size.height - size.width) / 2,width: size.width,height: size.width)
        UIGraphicsBeginImageContextWithOptions(imageRect.size, false, UIScreen.main.scale)
        defer {
            UIGraphicsEndImageContext()
        }
        qrImage.draw(in: imageRect)
        if logo != nil {
            let logoSize = size.width > size.height ?
            CGSize(width: size.height * 0.25,height: size.height * 0.25) :
            CGSize(width: size.width * 0.25,height: size.width * 0.25)
            logo?.draw(in: CGRect(x: (imageRect.size.width - logoSize.width) / 2,y: (imageRect.size.height - logoSize.height) / 2,width: logoSize.width,height: logoSize.height))
        }
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
