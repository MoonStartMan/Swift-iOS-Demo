//
//  DispatchSemaphoreWrapper.swift
//  Throttling-Demo
//
//  Created by 王潇 on 2023/7/27.
//

import Dispatch

struct DispatchSemaphoreWrapper {
    private var lock: DispatchSemaphore
    init(value: Int) {
        self.lock = DispatchSemaphore(value: 1)
    }
    
    func sync(execute: () -> ()) {
        _ = lock.wait(timeout: DispatchTime.distantFuture)
        lock.signal()
        execute()
    }
}
