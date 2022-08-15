//
//  ViewController.swift
//  panpelProtocol-Demo
//
//  Created by 王潇 on 2022/7/16.
//

import UIKit
import SnapKit

class EditViewController: UIViewController, UITextFieldDelegate {
    
    var textField: UITextField = UITextField()
    
    weak var delegate: EditViewControllerDelegate?
    
    var sendBtn: UIButton = UIButton()
    
    var oldInfo: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(200)
            make.width.equalTo(200)
            make.centerX.equalToSuperview()
            make.height.equalTo(30)
        }
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.cornerRadius = 15
        textField.layer.masksToBounds = true
        textField.placeholder = "输入传值内容"
        textField.font = .systemFont(ofSize: 12.0)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        textField.delegate = self
        
        if let info = oldInfo {
            textField.text = info
        }
        
        view.addSubview(sendBtn)
        sendBtn.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
        sendBtn.setTitle("传递信息", for: .normal)
        sendBtn.setTitleColor(.black, for: .normal)
        sendBtn.titleLabel?.font = .systemFont(ofSize: 12.0, weight: .bold)
        sendBtn.layer.cornerRadius = 15
        sendBtn.layer.masksToBounds = true
        sendBtn.layer.borderColor = UIColor.black.cgColor
        sendBtn.layer.borderWidth = 1.0
        sendBtn.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        done(textField)
    }
    
    func done(_ sender: AnyObject) {
        delegate?.editInfo(controller: self, newInfo: textField.text!)
    }
    
    func cancel(_ sender: AnyObject) {
        delegate?.editInfoDidCancer(controller: self)
    }
    
    @objc func sendMessage() {
        guard let delegate = delegate, let vc = delegate as? UIViewController else {
            return
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
