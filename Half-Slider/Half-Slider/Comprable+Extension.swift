//
//  Comprable+Extension.swift
//  Half-Slider
//
//  Created by 王潇 on 2022/4/6.
//

import Foundation

extension Comparable {
    
    /// 确保在范围值在之间
    ///
    ///     let value = -1.clamped(to: 0...3)
    ///     print(value)
    ///     // Prints "0"
    ///
    /// - Parameter limits: 闭区间
    func clamped(to limits: ClosedRange<Self>) -> Self {
        return min(max(self, limits.lowerBound), limits.upperBound)
    }
    
    /// 确保在范围之间
    ///
    ///     let value = 5.clamped(min: 3, max: 4)
    ///     print(value)
    ///     // Prints "4"
    ///
    /// - Parameter minValue: 最小值
    /// - Parameter maxValue: 最大值
    func clamped(min minValue: Self, max maxValue: Self) -> Self {
        return min(max(self, minValue), maxValue)
    }
    
    /// 是否在范围内
    /// - Parameter range: 范围
    func isIn(range: ClosedRange<Self>) -> Bool {
        return isWithin(lower: range.lowerBound, upper: range.upperBound)
    }
    
    /// 是否在范围内
    /// - Parameter lower: 最小值
    /// - Parameter upper: 最大值
    func isWithin(lower: Self, upper: Self) -> Bool {
        return lower <= self && self <= upper && lower <= upper
    }
    
}
