//
//  LoginViewController.swift
//  store-demo
//
//  Created by 王潇 on 2021/6/25.
//

import UIKit
import SnapKit

protocol ValidatesPhoneNumber {
    func validatePhoneNumber(_ phoneNumber: String) -> Bool
}

protocol ValidatesPassword {
    func validatePassword(_ password: String) -> Bool
}

extension ValidatesPhoneNumber {
    func validatePhoneNumber(_ phoneNumber: String) -> Bool {
        if phoneNumber.count != 11 {
            return false
        }
        return true
    }
}

extension ValidatesPassword {
    func validatePassword(_ password: String) -> Bool {
        if password.count < 6 || password.count > 12 {
            return false
        }
        return true
    }
}

class LoginViewController: BaseViewController, ValidatesPhoneNumber, ValidatesPassword{

    var phoneTextField: UITextField?
    var passwordTextfield: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let logoView = UIImageView(image: R.image.logo())
        view.addSubview(logoView)
        logoView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.centerX.equalToSuperview()
        }
        
        let phoneIconView = UIImageView(image: R.image.icon_phone())
        phoneTextField = UITextField()
        phoneTextField?.leftView = phoneIconView
        phoneTextField?.leftViewMode = .always
        phoneTextField?.layer.borderColor = UIColor.hexColor(0x333333).cgColor
        phoneTextField?.layer.borderWidth = 1
        phoneTextField?.textColor = UIColor.hexColor(0x333333)
        phoneTextField?.layer.cornerRadius = 5
        phoneTextField?.layer.masksToBounds = true
        phoneTextField?.placeholder = "请输入手机号"
        view.addSubview(phoneTextField!)
        phoneTextField?.snp.makeConstraints({ make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(logoView.snp.bottom).offset(20)
            make.height.equalTo(50)
        })
        
        let passwordIconView = UIImageView(image: R.image.icon_pwd())
        passwordTextfield = UITextField()
        passwordTextfield?.leftView = passwordIconView
        passwordTextfield?.leftViewMode = .always
        passwordTextfield?.layer.borderColor = UIColor.hexColor(0x333333).cgColor
        passwordTextfield?.layer.borderWidth = 1
        passwordTextfield?.textColor = UIColor.hexColor(0x333333)
        passwordTextfield?.layer.cornerRadius = 5
        passwordTextfield?.layer.masksToBounds = true
        passwordTextfield?.placeholder = "请输入密码"
        passwordTextfield?.isSecureTextEntry = true
        view.addSubview(passwordTextfield!)
        passwordTextfield?.snp.makeConstraints{ make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(phoneTextField!.snp.bottom).offset(15)
            make.height.equalTo(50)
        }
        
        let loginButton = UIButton(type: .custom)
        loginButton.setTitle("登录", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        loginButton.setBackgroundImage(UIColor.hexColor(0xf8892e).toImage(), for: .normal)
        loginButton.layer.cornerRadius = 5
        loginButton.layer.masksToBounds = true
        view.addSubview(loginButton)
        loginButton.snp.makeConstraints{ make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(passwordTextfield!.snp.bottom).offset(20)
            make.height.equalTo(50)
        }
        
        loginButton.addTarget(self, action: #selector(didClickLoginButton), for: .touchUpInside)
    }
    
    @objc func didClickLoginButton() {
        if validatePhoneNumber(phoneTextField?.text ?? "") && validatePassword(passwordTextfield?.text ?? "") {
            
        } else {
            showToast()
        }
    }
    
    func showToast() {
        let alertVC = UIAlertController(title: "提示", message: "用户名或者密码错误", preferredStyle: .alert)
        present(alertVC, animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            alertVC.dismiss(animated: true, completion: nil)
        }
    }

}
