//
//  Copying.swift
//  Prototype-Pattern-Demo
//
//  Created by 王潇 on 2023/8/2.
//

import Foundation

public protocol Copying: class {
    //  声明 required initializer
    init(_ prototype: Self)
}

extension Copying {
    //  通常不直接调用初始化器,而是调用 copy() 方法
    public func copy() -> Self {
        return type(of: self).init(self)
    }
}
