//
//  ViewController.swift
//  panpelProtocol-Demo
//
//  Created by 王潇 on 2022/7/19.
//

import UIKit

class ViewController: UIViewController, EditViewControllerDelegate {

    private var label: UILabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        label.textColor = .black
        label.font = .systemFont(ofSize: 16.0, weight: .bold)
        label.textAlignment = .center
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditView" {
            //  通过seque的标识获得跳转目标
            let controller = segue.destination as! EditViewController
            //  设置代理
            controller.delegate = self
            controller.oldInfo = label.text
        }
    }

    func editInfo(controller: EditViewController, newInfo: String) {
        label.text = newInfo
//        //  关闭编辑页面
//        controller.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    func editInfoDidCancer(controller: EditViewController) {
//        //  关闭编辑页面
//        controller.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
