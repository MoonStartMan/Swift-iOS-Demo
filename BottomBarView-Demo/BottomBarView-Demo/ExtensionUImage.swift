//
//  ExtensionUImage.swift
//  BottomBarView-Demo
//
//  Created by 王潇 on 2022/3/2.
//

import UIKit


extension UIImage {
    func withAlpha(_ a: CGFloat) -> UIImage {
            return UIGraphicsImageRenderer(size: size, format: imageRendererFormat).image { (_) in
                draw(in: CGRect(origin: .zero, size: size), blendMode: .normal, alpha: a)
            }
        }
}
