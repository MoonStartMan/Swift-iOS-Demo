//
//  Color.swift
//  Calculator-Demo
//
//  Created by 王潇 on 2021/6/9.
//

import Foundation
import UIKit

extension UIColor {
    func asImage(_ size: CGSize) -> UIImage? {
        
        var resultImage: UIImage? = nil
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, UIScreen.main.scale)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            
            return resultImage
        }
        
        context.setFillColor(self.cgColor)
        context.fill(rect)
        resultImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return resultImage
        
    }
}
