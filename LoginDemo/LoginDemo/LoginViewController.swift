//
//  LoginViewController.swift
//  LoginDemo
//
//  Created by 王潇 on 2022/9/6.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {
    
    private var bingoLabel: UILabel = UILabel()
    
    private var userTextField: UITextField = UITextField()
    
    private var passwordTextField: UITextField = UITextField()
    
    private var loginBtn: UIButton = UIButton()
    
    private var loginBotommLabel: UILabel = UILabel()
    
    private var loginBottomBtn: UIButton = UIButton()
    
    private var loginTap: UITapGestureRecognizer?
    
    private var registerTap: UITapGestureRecognizer?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
        viewAddTarget()
    }

    private func setupView() {
        view.addSubview(bingoLabel)
        view.addSubview(userTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginBtn)
        view.addSubview(loginBotommLabel)
        view.addSubview(loginBottomBtn)
        
        title = "登录页"
        
        bingoLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(300)
            make.left.right.equalToSuperview()
        }
        bingoLabel.textColor = .systemRed
        bingoLabel.font = .systemFont(ofSize: 16)
        bingoLabel.textAlignment = .center
        
        userTextField.snp.makeConstraints { make in
            make.top.equalTo(bingoLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(30)
        }
        userTextField.placeholder = "请输入用户名"
        userTextField.layer.borderColor = UIColor.black.cgColor
        userTextField.layer.borderWidth = 1
        userTextField.layer.cornerRadius = 15
        userTextField.font = .systemFont(ofSize: 12)
        userTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        userTextField.leftViewMode = .always
        userTextField.clearButtonMode = .whileEditing
        userTextField.delegate = self
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(userTextField.snp.bottom).offset(20)
            make.left.equalTo(userTextField.snp.left)
            make.right.equalTo(userTextField.snp.right)
            make.height.equalTo(30)
        }
        passwordTextField.placeholder = "请输入密码"
        passwordTextField.layer.borderColor = UIColor.black.cgColor
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.cornerRadius = 15
        passwordTextField.font = .systemFont(ofSize: 12)
        passwordTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        passwordTextField.leftViewMode = .always
        passwordTextField.clearButtonMode = .whileEditing
        passwordTextField.isSecureTextEntry = true
        passwordTextField.delegate = self
        
        loginBtn.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
        loginBtn.setTitle("登录", for: .normal)
        loginBtn.layer.cornerRadius = 20
        loginBtn.layer.masksToBounds = true
        loginBtn.setTitleColor(.white, for: .normal)
        loginBtn.backgroundColor = .systemBlue
        loginBtn.titleLabel?.font = .systemFont(ofSize: 14)
        
        loginBotommLabel.snp.makeConstraints { make in
            make.top.equalTo(loginBtn.snp.bottom).offset(20)
            make.centerX.equalToSuperview().offset(-30)
        }
        loginBotommLabel.text = "还没有账号"
        loginBotommLabel.font = .systemFont(ofSize: 14)
        loginBotommLabel.textColor = .black
        loginBotommLabel.textAlignment = .center
        
        loginBottomBtn.snp.makeConstraints { make in
            make.centerY.equalTo(loginBotommLabel.snp.centerY)
            make.width.equalTo(60)
            make.height.equalTo(14)
            make.left.equalTo(loginBotommLabel.snp.right).offset(10)
        }
        loginBottomBtn.setTitle("去注册", for: .normal)
        loginBottomBtn.setTitleColor(.systemBlue, for: .normal)
        loginBottomBtn.titleLabel?.font = .systemFont(ofSize: 14)
    }
    
    private func viewAddTarget() {
        loginTap = UITapGestureRecognizer(target: self, action: #selector(loginClick))
        registerTap = UITapGestureRecognizer(target: self, action: #selector(registerClick))
        
        if let loginTap = loginTap,
           let registerTap = registerTap {
            loginBtn.addGestureRecognizer(loginTap)
            loginBottomBtn.addGestureRecognizer(registerTap)
        }
    }
    
    @objc func loginClick() {
        self.navigationController?.pushViewController(SuccessViewController(), animated: false)
    }

    @objc func registerClick() {
        self.navigationController?.pushViewController(RegisterViewController(), animated: false)
    }
}

extension LoginViewController: UITextFieldDelegate {
    /// 点击return收回键盘
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    /// 点击其他地方收回键盘
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        userTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
}

extension LoginViewController {
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "SuccessViewController" {
            let username = userTextField.text ?? ""
            if username.isEmpty {
                bingoLabel.text = "请输入用户名"
                return false
            }
            
            let password = passwordTextField.text ?? ""
            if password.isEmpty {
                bingoLabel.text = "请输入密码"
                return false
            }
            
            bingoLabel.text = nil
        }
        return true
    }
    
}
