//
//  ViewController.swift
//  Low-Battery-Demo
//
//  Created by 王潇 on 2023/1/5.
//

import UIKit

class ViewController: UIViewController {
    
    private let processInfo = ProcessInfo()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let device = UIDevice.current
        device.isBatteryMonitoringEnabled = true
        
        /// 电池状态获取
        let state = device.batteryState
        let stateArray = NSArray(objects: "未开启监视电池状态", "电池未充电状态", "电池充电状态", "电池充电完成")
        print("电池状态:\(stateArray.object(at: state.rawValue))")
        
        /// 电池状态监听
        NotificationCenter.default.addObserver(self, selector: #selector(didChangBatteryState(notification:)), name: UIDevice.batteryStateDidChangeNotification, object: device)
        
        /// 电池电量获取
        let level = device.batteryLevel
        print("电池电量: \(level * 100)")
        
        /// 电池电量监听
        NotificationCenter.default.addObserver(self, selector: #selector(didChangeBatteryLevel(notification:)), name: UIDevice.batteryLevelDidChangeNotification, object: device)
        
        /// 检测低电量
        checkAndMonitorPowerMode()
        
        /// 低电量模式切换
        NotificationCenter.default.addObserver(self, selector: #selector(didChangePowerMode(notification:)), name: Notification.Name.NSProcessInfoPowerStateDidChange, object: nil)
    }
    
    /// 电池状态监听方法
    @objc func didChangBatteryState(notification: Notification) {
        
    }
    
    /// 电池电量监听方法
    @objc func didChangeBatteryLevel(notification: Notification) {
        
    }
    
    /// 低电量模式监听方法
    @objc func didChangePowerMode(notification: Notification) {
        if processInfo.isLowPowerModeEnabled {
            print("打开了低电量模式")
        } else {
            print("关闭了低电量模式")
        }
    }

    /// 低电量模式检测
    func checkAndMonitorPowerMode() {
        if processInfo.isLowPowerModeEnabled {
            print("处于低电量模式中")
        } else {
            print("没有处于低电量模式中")
        }
    }
    
}

