//
//  ViewController.swift
//  iOS-Get-System-Information
//
//  Created by 王潇 on 2023/3/15.
//

import UIKit
import CoreTelephony
import SystemConfiguration

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
       print("\( ViewController.getNetWorkType())")
    }
    
    private static var notReachable: String {
        get {
            return "notReachable"
        }
    }
    
    /// 获取网络类型
    private static func getNetWorkType() -> String {
        var zeroAddress = sockaddr_storage()
        bzero(&zeroAddress, MemoryLayout<sockaddr_storage>.size)
        zeroAddress.ss_len = __uint8_t(MemoryLayout<sockaddr_storage>.size)
        zeroAddress.ss_family = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) { address in
                SCNetworkReachabilityCreateWithAddress(nil, address)
            }
        }
        guard let defaultRouteReachability = defaultRouteReachability else {
            return notReachable
        }
        var flags = SCNetworkReachabilityFlags()
        let didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags)
        
        guard didRetrieveFlags == true,
              (flags.contains(.reachable) && !flags.contains(.connectionRequired)) == true else {
            return notReachable
        }
        
        if flags.contains(.connectionRequired) {
            return notReachable
        } else if flags.contains(.isWWAN) {
            return cellularType()
        } else {
            return "WiFi"
        }
    }

    /// 获取蜂窝数据类型
    private static func cellularType() -> String {
        let info = CTTelephonyNetworkInfo()
        var status: String?
        
        if #available(iOS 12.0, *) {
            guard let dict = info.serviceCurrentRadioAccessTechnology,
                  let firstKey = dict.keys.first,
                  let statusTemp = dict[firstKey] else {
                return notReachable
            }
            status = statusTemp
        } else {
            guard let statusTemp = info.currentRadioAccessTechnology else {
                return notReachable
            }
            status = statusTemp
        }
        
        if #available(iOS 14.1, *) {
            if status == CTRadioAccessTechnologyNR || status == CTRadioAccessTechnologyNRNSA {
                return "5G"
            }
        }
        
        switch status {
        case CTRadioAccessTechnologyGPRS,
            CTRadioAccessTechnologyEdge,
        CTRadioAccessTechnologyCDMA1x:
            return "2G"
        case CTRadioAccessTechnologyWCDMA,
            CTRadioAccessTechnologyHSDPA,
            CTRadioAccessTechnologyHSUPA,
            CTRadioAccessTechnologyeHRPD,
            CTRadioAccessTechnologyCDMAEVDORev0,
            CTRadioAccessTechnologyCDMAEVDORevA,
        CTRadioAccessTechnologyCDMAEVDORevB:
            return "3G"
        case CTRadioAccessTechnologyLTE:
            return "4G"
        default:
            return notReachable
        }
    }
    
    /// 获取系统版本
    private func getDeviceSystemVersion() -> String {
        return UIDevice.current.systemVersion
    }
    
    /// 获取系统名称
    private func getDeviceSystemName() -> String {
        return UIDevice.current.systemName
    }
    
    /// 获取系统设备名字
    private func getDeviceModel() -> String {
        return UIDevice.current.model
    }
    
    /// 获取系统名称
    private func getDeviceLocalizedModel() -> String {
        return UIDevice.current.localizedModel
    }
    
    /// 获取设备名称 和 xxx的iphone
    private func getDeviceUserName() -> String {
        return UIDevice.current.name
    }
    
    /// 获取总的内存
    private func getDeviceDiskTotalSize() -> String {
        return ""
    }
    
    /// 获取可用的内存
    private func getDeviceAvalibleDiskSize() -> String {
        return ""
    }
    
    /// 获取运营商
    private func getDeviceSupplier() -> String {
        return deviceSupplier()
    }
    
    /// 获取当前设备IP
    private func getDeviceIP() -> String {
        return deviceIP()
    }
    
    /// 获取CPU核数类型
    private func getDeviceCpuCount() -> Int {
        return 0
    }
    
    /// 获取CPU类型
    private func getDeviceCpuType() -> String {
        return ""
    }
    
    /// 获取设备名称
    private func getDeviceName() -> String {
        return ""
    }
}

extension ViewController {
    /// 获取运营商
    func deviceSupplier() -> String {
        let info = CTTelephonyNetworkInfo()
        var supplier: String = ""
        if #available(iOS 12.0, *) {
            if let carriers = info.serviceSubscriberCellularProviders {
                if carriers.keys.count == 0 {
                    return "无手机卡"
                } else {/// 获取运营商信息
                    for (index, carrier) in carriers.values.enumerated() {
                        guard carrier.carrierName != nil else { return "无手机卡" }
                        /// 查看运营商信息 通过CTCarrier类
                        if index == 0 {
                            supplier = carrier.carrierName!
                        } else {
                            supplier = supplier + "," + carrier.carrierName!
                        }
                    }
                    return supplier
                }
            } else {
                return "无手机卡"
            }
        } else {
            if let carrier = info.subscriberCellularProvider {
                guard carrier.carrierName != nil else { return "无手机卡"}
                return carrier.carrierName!
            } else {
                return "无手机卡"
            }
        }
    }
    
    /// 获取当前设备IP
    private func deviceIP() -> String {
        var addresses = [String]()
        var ifaddr: UnsafeMutablePointer<ifaddrs>? = nil
        if getifaddrs(&ifaddr) == 0 {
            var ptr = ifaddr
            while (ptr != nil) {
                let flags = Int32(ptr!.pointee.ifa_flags)
                var addr = ptr!.pointee.ifa_addr.pointee
                if (flags & (IFF_UP|IFF_RUNNING|IFF_LOOPBACK)) == (IFF_UP|IFF_RUNNING) {
                    if addr.sa_family == UInt8(AF_INET) || addr.sa_family == UInt8(AF_INET6) {
                        var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                        if (getnameinfo(&addr, socklen_t(addr.sa_len), &hostname, socklen_t(hostname.count), nil, socklen_t(0), NI_NUMERICHOST)) == 0 {
                            if let address = String(validatingUTF8: hostname) {
                                addresses.append(address)
                            }
                        }
                    }
                }
                ptr = ptr!.pointee.ifa_next
            }
            freeifaddrs(ifaddr)
        }
        if let ipStr = addresses.first {
            return ipStr
        } else {
            return ""
        }
    }
    
    /// 获取CPU核数类型
    func deviceCpuCount() -> Int {
        var ncpu: UInt = UInt(0)
        var len: size_t = MemoryLayout.size(ofValue: ncpu)
        sysctlbyname("cpu", &ncpu, &len, nil, 0)
        return Int(ncpu)
    }
    
    /// 获取磁盘总大小
    func getTotalDiskSize(_ bytes: Int64) -> String {
        let formatter = ByteCountFormatter()
        formatter.allowedUnits = ByteCountFormatter.Units.useMB
        formatter.countStyle = ByteCountFormatter.CountStyle.decimal
        formatter.includesUnit = false
        return formatter.string(fromByteCount: bytes) as String
    }
}
