//
//  ViewController.swift
//  AlertViewController-Demo
//
//  Created by 王潇 on 2023/5/4.
//

import UIKit
import StoreKit
import WebKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //弹出消息框
        let alertController = ImageAlertViewController(title: "标题", message: "副标题", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "确定", style: .default, handler: { action in
            self.gotoAppStore()
        })
        alertController.imageName = "image"
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
        alertController.setLabelStyle(controller: alertController, title: "标题", message: "副标题")
        
        alertController.setActionImage(action: cancelAction, imageName: "common_alert_close")
        alertController.setActionColor(action: cancelAction, color: .brown)
        
        alertController.setActionImage(action: okAction, imageName: "common_alert_confirm")
        alertController.setActionColor(action: okAction, color: .darkGray)
    }

    func gotoAppStore() {
        /// 输入APPID地址
        let urlString = ""
        if let url = URL(string: urlString) {
            //根据iOS系统版本，分别处理
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: { (success) in

                })
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()


    }
}

