//
//  ViewController.swift
//  jurisdiction-Demo
//
//  Created by 王潇 on 2022/12/27.
//

import UIKit
import Foundation
import AVFoundation
import Photos

@objc enum PhotoAuthStatus: Int {
    // 拒绝
    case denied = 1
    // 同意部分
    case limited = 2
    // 同意
    case authorized = 3
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        checkAudioStatus()
        AVCaptureDevice.requestAccess(for: .audio) { granted in
            granted ? print("麦克风允许") : print("麦克风不允许")
        }
//        requestPhotoAuth { status in
//            print("\(status)")
//        }
        
    }

    func checkAudioStatus() {
        var authStatus = AVCaptureDevice.authorizationStatus(for: .audio)
        switch authStatus {
        case .notDetermined:
            authStatus = .notDetermined
        case .restricted:
            authStatus = .restricted
        case .denied:
            authStatus = .denied
        case .authorized:
            authStatus = .authorized
        default:
            break
        }
    }
    
    /// 获取相册权限
    func requestPhotoAuth(_ complete: @escaping ((_ status: PhotoAuthStatus) -> Void)) {
        if #available(iOS 14.0, *) {
            PHPhotoLibrary.requestAuthorization(for: .readWrite) { (status) in
                if status == .authorized {
                    complete(.authorized)
                } else if status == .limited {
                    complete(.limited)
                } else {
                    complete(.denied)
                }
            }
        } else {
            PHPhotoLibrary.requestAuthorization { (status) -> Void in
                if status == .authorized {
                    complete(.authorized)
                } else {
                    complete(.denied)
                }
            }
        }
    }

}

