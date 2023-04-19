//
//  UIControl+Extension.swift
//  Avatar
//
//  Created by yinpan on 2020/2/24.
//  Copyright © 2020 Pinguo Inc. All rights reserved.
//

import Foundation
import UIKit

class ClosureSleeve: NSObject {
    
    let closure: () -> Void

    init (_ closure: @escaping () -> Void) {
        self.closure = closure
    }
    
    @objc func invoke () {
        closure()
    }
}

extension UIControl {
    
    /// 闭包形式添加方法调用 ⚠️⚠️ 务必请注意循环引用问题
    /// - Parameters:
    ///   - controlEvents: 事件类型
    ///   - closure: 闭包
    func addAction(for controlEvents: UIControl.Event, _ closure: @escaping () -> Void) {
        let sleeve = ClosureSleeve(closure)
        addTarget(sleeve, action: #selector(ClosureSleeve.invoke), for: controlEvents)
        objc_setAssociatedObject(self, String(format: "[%d]", arc4random()), sleeve, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
    }
    
}
