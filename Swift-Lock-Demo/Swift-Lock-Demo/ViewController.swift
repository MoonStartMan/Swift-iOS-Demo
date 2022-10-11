//
//  ViewController.swift
//  Swift-Lock-Demo
//
//  Created by 王潇 on 2022/10/11.
//

import UIKit

class ViewController: UIViewController {

    private var tickets: Int = 20
    
    private var lock: NSLock = NSLock()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let thread1 = Thread { [unowned self] in
            self.syncSaleTickets()
        }
        thread1.name = "售票点A"
        thread1.start()
        let thread2 = Thread { [unowned self] in
            self.syncSaleTickets()
        }
        thread2.name = "售票点B"
        thread2.start()
    }


    func synchronized<T>(_ lock: AnyObject, _ body: () throws -> T) rethrows -> T {
        objc_sync_enter(lock)
        defer { objc_sync_exit(lock) }
        return try body()
    }

    func syncSaleTickets() {
        while true {
            if lock.try() {
                if tickets > 0 {
                    print("\(Thread.current.name ?? ""): \(tickets)")
                    tickets -= 1
                } else {
                    print("票已卖完: \(tickets)")
                    break
                }
                lock.unlock()
            }
        }
    }
}
