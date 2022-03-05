//
//  ExtensionString.swift
//  Group-Demo
//
//  Created by 王潇 on 2022/3/4.
//

import UIKit

extension String {
    public func widthWith(font: UIFont) -> CGFloat {
        let str = self as NSString
        return str.size(withAttributes: [NSAttributedString.Key.font : font]).width
    }
}
