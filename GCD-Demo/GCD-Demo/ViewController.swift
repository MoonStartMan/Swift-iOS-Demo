//
//  ViewController.swift
//  GCD-Demo
//
//  Created by 王潇 on 2022/10/9.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// 串行队列中嵌套其他队列的同步任务
        //        let seriaQueue = DispatchQueue(label: "串行队列嵌套同步任务")
        //        let seriaQueue2 = DispatchQueue(label: "串行队列嵌套同步任务2")
        //        seriaQueue.sync {
        //            print("同步函数执行======")
        //            seriaQueue2.sync {
        //                print("串行队列中嵌套其他队列的同步任务===")
        //            }
        //        }
        
        //        dispath_later(2) {
        //            print("dispatch_after 延迟执行任务======", Thread.current, Data())
        //        }
        
        /// makeTimerSource()直接创建
        //GCD定时器
        var timer = DispatchSource.makeTimerSource()
        /**
         @param : deadline  延迟时间（多久时间以后开始执行）
         @param : repeating 重复执行时间 DispatchTimeInterval类型时间
         @param ：leeway 误差时间 0： 表示没有误差
         */
        timer.schedule(deadline: DispatchTime.now(), repeating: DispatchTimeInterval.seconds(Int(2)), leeway: DispatchTimeInterval.microseconds(0))
        //没有设置重复时间的默认是执行一次
        //timer?.schedule(deadline: DispatchTime.now())
        timer.setEventHandler {
            print("定时器处理器执行block=====",Thread.current)
            
        }
        //执行定时器
        timer.resume()
    }
    
    /// 同步任务(串行队列)
    func simpleSQueue() -> Void {
        let queue = DispatchQueue(label: "test")
        //  同步执行队列
        queue.sync {
            for i in 1...3 {
                print("同步执行队列---😝", i)
            }
        }
        //  同步主队列执行
        for j in 100...103 {
            print("同步主队列---😭", j)
        }
    }
    
    //    func testSyncInSeriaQueue() -> Void {
    //        let seriaQueue = DispatchQueue(label: "sync")
    //        /// 异步执行
    //        seriaQueue.async {
    //            for i in 1...3 {
    //                print("异步执行队列---👁👁 current Thread====", i, Thread.current)
    //            }
    //            seriaQueue.sync {
    //                print("串行队列中添加本队列的同步任务=====")
    //            }
    //        }
    //
    //        print("end test")
    //    }
    
    /// 并行队列中嵌套本队列的同步任务
    func testAsyncInConcurrent() -> Void {
        let concurrentQueue = DispatchQueue(label: "testAsync", attributes: [.concurrent])
        concurrentQueue.async {
            print("异步执行函数======")
            
            concurrentQueue.sync {
                print("同步函数执行======")
            }
        }
    }
    
    /// 并行队列中新增异步任务
    func testAsyncInConcurrent2() {
        let concurrentQueue = DispatchQueue(label: "并行队列中新增异步任务", attributes: [.concurrent])
        concurrentQueue.async {
            print("并行队列中 增加异步任务")
        }
    }
    
    /// 串行队列嵌套本队列的异步任务
    func testAsyncTaskNestedInSameSerialQueue() -> Void {
        let serialQueue = DispatchQueue(label: "串行队列嵌套本队列的异步任务")
        serialQueue.sync {
            print("串行队列中 同步任务 =====", Thread.current)
            
            serialQueue.async {
                print("串行队列中嵌套本队列的异步任务 =====", Thread.current)
            }
        }
    }
    
    /// 栅栏任务
    func barrir() -> Void {
        let queue = DispatchQueue(label: "queueBarrir", attributes: [.concurrent])
        let task = DispatchWorkItem(qos: DispatchQoS.default, flags: DispatchWorkItemFlags.barrier) {
            print("实现栅栏任务")
        }
        
        queue.async {
            print("任务1========", Thread.current)
        }
        
        queue.async {
            print("任务2========", Thread.current)
        }
        
        queue.async(execute: task)
        
        queue.async {
            print("任务3========", Thread.current)
        }
        
        queue.async {
            print("任务4========", Thread.current)
        }
        
        /// 迭代任务
        DispatchQueue.concurrentPerform(iterations: 10) { (index) in
            print("current thread======", Thread.current, index)
        }
        
        /// 迭代任务也可以放在指定的队列中
        DispatchQueue.global().async {
            DispatchQueue.concurrentPerform(iterations: 5) { (index) in
                print("current thread======", Thread.current, index)
            }
        }
    }
    
    /// 延迟任务
    func dispath_later(_ time: TimeInterval, block: @escaping () -> ()) -> Void {
        print("任务在\(time)秒后执行", Date())
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now(), execute: block)
    }
    
    /// 添加任务到指定任务组
    func group() -> Void {
        let queueGroup = DispatchGroup()
        
        let queue = DispatchQueue.global()
        
        queue.async(group: queueGroup, execute: DispatchWorkItem(block: {
            print("任务1------", Thread.current)
        }))
        
        queue.async(group: queueGroup, execute: DispatchWorkItem(block: {
            print("任务2------", Thread.current)
        }))
        
        queue.async(group: queueGroup, execute: DispatchWorkItem(block: {
            print("任务3------", Thread.current)
        }))
        
        queue.async(group: queueGroup, execute: DispatchWorkItem(block: {
            print("任务4------", Thread.current)
        }))
        
        queue.async(group: queueGroup, execute: DispatchWorkItem(block: {
            print("任务5------", Thread.current)
        }))
        
        queueGroup.notify(queue: DispatchQueue.main) {
            print("任务组中所有的任务都完成了,可以执行下步操作-------")
        }
    }
    
    /// 使用Group.enter() Group.leave() 配对方法,表示任务加入任务组
    func group2() -> Void {
        let queueGroup = DispatchGroup()
        
        let queue = DispatchQueue.global()
        
        queueGroup.enter()
        queue.async {
            print("任务1------", Thread.current)
            queueGroup.leave()
        }
        
        queueGroup.enter()
        queue.async {
            print("任务2------", Thread.current)
            queueGroup.leave()
        }
        
        queueGroup.notify(queue: DispatchQueue.main) {
            print("任务组中所有的任务都完成了,可以执行下步操作------")
        }
    }
    
    /// 任务通知
    func group3() -> Void {
        let queueGroup = DispatchGroup()
        
        let queue = DispatchQueue.global()
        
        queueGroup.enter()
        queue.async {
            print("任务1------", Thread.current)
            queueGroup.leave()
        }
        
        queueGroup.enter()
        queue.async {
            print("任务2------", Thread.current)
            queueGroup.leave()
        }
        
        queueGroup.wait()
        
        /// wait方法中还可以指定具体时间,它表示等待不超过这个时间,如果任务组在指定时间内完成任务则立即恢复当前线程,否则将等待到时间结束后再恢复当前线程
        /// 等待2秒
        queueGroup.wait(timeout: DispatchTime.now() + 2)
        
        print("任务组中所有的任务都完成了, 可以执行下步操作------")
    }
}

extension URLSession {
    /// 如果任务是由系统或第三方的API创建的,由于无法获取到对应的队列,只能用URLSession的addDataTask方法加入任务组中
    func addDataTask(to group: DispatchGroup, with request: URLRequest, completionHadnler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        group.enter() // 进入任务组
        return dataTask(with: request) { (data, response, error) in
            completionHadnler(data, response, error)
            group.leave()
        }
    }
}

/// 队列的挂起和唤醒
class SuspendAndResum: NSObject {
    /// 创建一个并发队列
    let concurentQueue = DispatchQueue(label: "队列的挂起和唤醒", attributes: [.concurrent])
    /// 挂起的次数
    var suspendCount = 0
    
    // MARK: -- 队列方法
    func suspendQueue() -> Void {
        print("suspend queue start test")
        concurentQueue.async {
            print("任务1concurrentQueue.async ======", Thread.current)
        }
        concurentQueue.async {
            print("任务2concurrentQueue.async ======", Thread.current)
        }
        
        /// 添加栅栏任务
        let workeItem = DispatchWorkItem(qos: DispatchQoS.unspecified, flags: DispatchWorkItemFlags.barrier) {
            print("add barrire =======", Thread.current)
            self.safeSuspend(self.concurentQueue)
        }
        concurentQueue.async(execute: workeItem)
        
        concurentQueue.async {
            print("任务3concurrentQueue.async ======", Thread.current)
        }
        
        concurentQueue.async {
            print("任务4concurrentQueue.async ======", Thread.current)
        }
        
        print("suspend queue end test")
    }
    
    /// 唤醒队列测试方法
    func resumeQueue() -> Void {
        self.safeResume(concurentQueue)
    }
    
    /// 安全挂起
    /// - Parameter queue: <#queue description#>
    func safeSuspend(_ queue: DispatchQueue) -> Void {
        /// 记录挂起次数
        suspendCount += 1
        queue.suspend()
        print("任务挂起了")
    }
    
    /// 安全唤醒
    /// - Parameter queue: <#queue description#>
    func safeResume(_ queue: DispatchQueue) -> Void {
        if suspendCount == 1 {
            queue.resume()
            suspendCount = 0
            print("任务唤醒了")
        } else if suspendCount < 1 {
            print("唤醒任务次数过多------")
        } else {
            queue.resume()
            suspendCount -= 1
            print("唤醒次数不够,还需要\(suspendCount)次唤醒")
        }
    }
}

/// DispatchSource
class DispatchSourceTest: NSObject {
    var filePath: String = "\(NSTemporaryDirectory())"
    var counter = 0
    let queueGloble = DispatchQueue.global()
    
    override init() {
        super.init()
    }
    
    func startObserve(closure: @escaping () -> Void) -> Void {
        let fileURL = URL(fileURLWithPath: filePath)
        let monitoredDirectoryFileDescriptor = open(fileURL.path, O_EVTONLY)
        let source = DispatchSource.makeFileSystemObjectSource(
            fileDescriptor: monitoredDirectoryFileDescriptor,
            eventMask: .write, queue: queueGloble)
        source.setEventHandler(handler: closure)
        source.setCancelHandler {
            close(monitoredDirectoryFileDescriptor)
        }
        source.resume()
    }
    
    func changeFile() {
        DispatchSourceTest.createFile(name: "DispatchSourceTest.md", filePath: NSTemporaryDirectory())
        counter += 1
        let text = "\(counter)"
        try! text.write(toFile: "\(filePath)/DispatchSourceTest.md", atomically: true, encoding: String.Encoding.utf8)
        print("file writed.")
    }
    
    static func createFile(name: String, filePath: String){
        let manager = FileManager.default
        let fileBaseUrl = URL(fileURLWithPath: filePath)
        let file = fileBaseUrl.appendingPathComponent(name)
        print("文件: \(file)")
        
        // 写入 "hello world"
        let exist = manager.fileExists(atPath: file.path)
        if !exist {
            let data = Data(base64Encoded:"aGVsbG8gd29ybGQ=" ,options:.ignoreUnknownCharacters)
            let createSuccess = manager.createFile(atPath: file.path,contents:data,attributes:nil)
            print("文件创建结果: \(createSuccess)")
        }
    }
    
    /// 带参数创建
    func dispatchTimer2() -> Void {
        //GCD定时器
        var timer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.global())
        timer.schedule(deadline: DispatchTime.now(), repeating: DispatchTimeInterval.seconds(Int(2)), leeway: DispatchTimeInterval.microseconds(0))
        timer.setEventHandler {
            print("定时器处理器执行block=====",Thread.current)
            
        }
        timer.resume()
        
    }
    
    func dispatchTimer3() -> Void {
        //GCD定时器
        var timer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.main)
        
        timer.schedule(deadline: DispatchTime.now(), repeating: DispatchTimeInterval.seconds(Int(2)), leeway: DispatchTimeInterval.microseconds(0))
        timer.setEventHandler {
            print("定时器处理器执行block=====",Thread.current)
            
        }
        timer.resume()
    }
}
