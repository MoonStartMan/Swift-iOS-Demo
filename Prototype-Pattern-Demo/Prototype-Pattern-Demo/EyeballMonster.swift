//
//  EyeballMonster.swift
//  Prototype-Pattern-Demo
//
//  Created by 王潇 on 2023/8/2.
//

import Foundation

// EyeballMonster 为 Monster 子类，同时添加了 redness 属性。
public class EyeballMonster: Monster {
    public var redness = 0
    
    //  在初始化方法为新增的属性赋值
    public init(health: Int, level: Int, redness: Int) {
        self.redness = redness
        super.init(health: health, level: level)
    }
    
    public required convenience init(_ prototype: Monster) {
        let eyeballMonster = prototype as! EyeballMonster
        self.init(health: eyeballMonster.health, level: eyeballMonster.level, redness: eyeballMonster.redness)
    }
    
}
