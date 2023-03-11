//
//  ViewController.swift
//  iOS-Screen-Cursor
//
//  Created by 王潇 on 2023/3/9.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private var coverView: UIView = UIView()
    
    private var textLabel: UILabel = UILabel()
    
    private var openState: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupView()
        monitorScreen()
    }

    private func setupView() {
        view.addSubview(coverView)
        coverView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(300)
        }
        coverView.backgroundColor = .systemPink
        
        view.addSubview(textLabel)
        textLabel.snp.makeConstraints { make in
            make.top.equalTo(coverView.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
        }
        textLabel.font = .systemFont(ofSize: 30, weight: .bold)
        textLabel.textColor = .black
    }
    
    private func monitorScreen() {
        /// 截屏
        NotificationCenter.default.addObserver(self, selector: #selector(screenTask), name: UIApplication.userDidTakeScreenshotNotification, object: nil)
        /// 录屏
        NotificationCenter.default.addObserver(self, selector: #selector(screensCaptured), name: UIScreen.capturedDidChangeNotification, object: nil)
        //  如果正在捕获此屏幕(例如,录制/空中播放/镜像等,则为真)
        if UIScreen.main.isCaptured {
            screensCaptured()
        }
//        //  捕获的屏幕状态发生变化时,会发送UIScreenCapturedDidChange通知,监听该通知
//        NotificationCenter.default.addObserver(self, selector: #selector(screenshots), name: UIScreen.capturedDidChangeNotification, object: nil)
    }
    
    @objc func screensCaptured() {
        if openState {
            let alertVC = UIAlertController(title: "提示", message: "你目前正在录屏", preferredStyle: .alert)
            let action = UIAlertAction(title: "知道了", style: .default) { action in
                alertVC.dismiss(animated: true, completion: nil)
            }
            alertVC.addAction(action)
            present(alertVC, animated: true, completion: nil)
        }
        openState = !openState
    }
    
    @objc func screenTask() {
        let alertVC = UIAlertController(title: "提示", message: "你目前正在截屏", preferredStyle: .alert)
        let action = UIAlertAction(title: "知道了", style: .default) { action in
            alertVC.dismiss(animated: true, completion: nil)
        }
        alertVC.addAction(action)
        present(alertVC, animated: true, completion: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIApplication.userDidTakeScreenshotNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIScreen.capturedDidChangeNotification, object: nil)
    }

}

