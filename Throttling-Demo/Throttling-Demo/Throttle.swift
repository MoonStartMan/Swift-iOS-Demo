//
//  Throttle.swift
//  Throttling-Demo
//
//  Created by 王潇 on 2023/7/27.
//

import UIKit

/// 节流
class Throttle {
    
    private let label: String
    private let interval: TimeInterval
    private let queue: DispatchQueue
    private var workItem: DispatchWorkItem?
    private var lock: DispatchSemaphoreWrapper
    private var lastTime: Date = Date()
    
    /// intervalu: 单位毫秒
    init(label: String = "Debouncer", interval: TimeInterval = 0.5) {
        self.label = label
        self.interval = interval
        self.queue = DispatchQueue(label: label)
        self.lock = DispatchSemaphoreWrapper(value: 1)
    }
    
    func call(_ callback: @escaping (() -> ())) {
        self.lock.sync {
            self.workItem?.cancel()
            self.workItem = DispatchWorkItem { [weak self] in
                self?.lastTime = Date()
                callback()
            }
            if let workItem = self.workItem {
                let new = Date()
                let delay = new.timeIntervalSince1970 - lastTime.timeIntervalSince1970 > interval ? DispatchTimeInterval.milliseconds(0) : DispatchTimeInterval.milliseconds(Int(interval * 1000))
                self.queue.asyncAfter(deadline: .now() + delay, execute: workItem)
            }
        }
    }
    
}
