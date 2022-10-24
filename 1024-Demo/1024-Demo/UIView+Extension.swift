//
//  UIView+Extension.swift
//  XJSwiftKit
//
//  Created by Mr.Yang on 2021/10/13.
//

import UIKit

// MARK: - 坐标
extension UIView {
    
    /// 横坐标
    var x: CGFloat {
        get {
            return self.frame.origin.x
        }
        set(newValue) {
            var rect = self.frame
            rect.origin.x = newValue
            self.frame = rect
        }
    }
    
    /// 纵坐标
    var y: CGFloat {
        get {
            return self.frame.origin.y
        }
        set(newValue) {
            var rect = self.frame
            rect.origin.y = newValue
            self.frame = rect
        }
    }
    
    /// 顶端间距
    var top: CGFloat {
        get {
            return self.frame.origin.y
        }
        set(newValue) {
            var rect = self.frame
            rect.origin.y = newValue
            self.frame = rect
        }
    }
    
    /// 底端间距
    var bottom: CGFloat {
        get {
            return (self.frame.origin.y + self.frame.size.height)
        }
        set(newValue) {
            var rect = self.frame
            rect.origin.y = (newValue - self.frame.size.height)
            self.frame = rect
        }
    }
    
    /// 宽度
    var width: CGFloat {
        get {
            return self.frame.size.width
        }
        set(newValue) {
            var rect = self.frame
            rect.size.width = newValue
            self.frame = rect
        }
    }
    
    /// 高度
    var height: CGFloat {
        get {
            return self.frame.size.height
        }
        set(newValue)
        {
            var rect = self.frame
            rect.size.height = newValue
            self.frame = rect
        }
    }
    
    /// Size
    var size: CGSize {
        get {
            return self.frame.size
        }
        set {
            var rect = self.frame
            rect.size = newValue
            self.frame = rect
        }
    }
    
    /// centerX
    var centerX: CGFloat {
        get {
            return self.center.x
        }
        set {
            var center = self.center
            center.x = newValue
            self.center = center
        }
    }
    
    /// centerY
    var centerY: CGFloat {
        get {
            return self.center.y
        }
        set {
            var center = self.center
            center.y = newValue
            self.center = center
        }
    }
}
