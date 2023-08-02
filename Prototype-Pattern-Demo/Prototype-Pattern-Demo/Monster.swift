//
//  Monster.swift
//  Prototype-Pattern-Demo
//
//  Created by 王潇 on 2023/8/2.
//

import Foundation

public class Monster: Copying {
    public var health: Int
    public var level: Int
    
    public init(health: Int, level: Int) {
        self.health = health
        self.level = level
    }
    
    public required convenience init(_ monster: Monster) {
        self.init(health: monster.health, level: monster.level)
    }
}

extension Array where Element: Copying {
    public func deepCopy() -> [Element] {
        return map { $0.copy() }
    }
}
