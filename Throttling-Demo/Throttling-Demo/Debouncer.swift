//
//  Debouncer.swift
//  Throttling-Demo
//
//  Created by 王潇 on 2023/7/27.
//

import UIKit
import Dispatch

/// 防抖
class Debouncer {
    
    private let label: String
    private let interval: Int
    private let queue: DispatchQueue
    private var workItem: DispatchWorkItem?
    private var lock: DispatchSemaphoreWrapper
    
    /// interval: 单位毫秒
    init(label: String = "Debouncer", interval: Int = 500) {
        self.label = label
        self.interval = interval
        self.queue = DispatchQueue(label: label)
        self.lock = DispatchSemaphoreWrapper(value: 1)
    }
    
    func call(_ callback: @escaping(() -> ())) {
        self.lock.sync {
            self.workItem?.cancel()
            self.workItem = DispatchWorkItem {
                callback()
            }
            
            if let workItem = self.workItem {
                self.queue.asyncAfter(deadline: .now() + DispatchTimeInterval.microseconds(interval), execute: workItem)
            }
        }
    }
}
