//
//  ViewController.swift
//  Contacts-Demo
//
//  Created by 王潇 on 2023/5/18.
//

import UIKit
import ContactsUI
import SnapKit

/// 获取用户通讯录中的联系人
/// 通过获取通讯录信息,可以在应用在添加好友
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        //  1.创建联系人选择的控制器
//        let cpvc = CNContactPickerViewController()
//
//        //  2.设置代理
//        cpvc.delegate = self
//
//        //  3.弹出控制器
//        present(cpvc, animated: true)
//    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //  1. 获取授权状态
        let status = CNContactStore.authorizationStatus(for: .contacts)
        
        //  2. 判断当前授权状态
        guard status == .authorized else { return }
        
        //  3. 创建通讯录对象
        let store = CNContactStore()
        
        //  4. 从通讯录中获取所有联系人
        
        //  获取Fetch, 并且指定之后要获取联系人中的什么属性
        let keys = [CNContactFamilyNameKey, CNContactGivenNameKey, CNContactPhoneNumbersKey]
        
        //  创建请求对象 需要传入一个(keysToFetch: [CNKeyDescriptor]包含'CNKeyDescriptor'类型的数组)
        let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
        
        //  遍历所有联系人
        //  需要传入一个CNContactFetchRequest
        do {
            try store.enumerateContacts(with: request, usingBlock: { contact, stop in
                
                //  1. 获取姓名
                let lastName = contact.familyName
                let firstName = contact.givenName
                print("姓名: \(lastName)\(firstName)")
                
                //  2.获取电话号码
                let phoneNumbers = contact.phoneNumbers
//                for (index, phoneNumber) in phoneNumbers.enumerated() {
//                    let label = UILabel()
//                    view.addSubview(label)
//                    label.text = "联系人: \(lastName)\(firstName)" + "电话: \(phoneNumber.value.stringValue)"
//                    label.snp.remakeConstraints { make in
//                        make.top.equalTo(0 + index * 40)
//                        make.centerX.equalToSuperview()
//                    }
//                    label.font = .systemFont(ofSize: 12, weight: .semibold)
//                }
                for phoneNumber in phoneNumbers {
                    print("\(phoneNumbers)")
                }
            })
        } catch {
            print(error)
        }
    }
}

extension ViewController: CNContactPickerDelegate {
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        //  1.获取用户的姓名
        //  lastname --> familyName
        //  firstname --> givenName
        let lastname = contact.familyName
        let firstname = contact.givenName
        print("姓名:\(firstname) \(lastname)")

        //  2.获取用户电话号码(ABMultivalue)
        let phones = contact.phoneNumbers
        for phone in phones {
            let phoneLabel = phone.label
            let phoneValue = phone.value.stringValue
            print("phoneLabel: \(phoneLabel). phoneValue: \(phoneValue)")
        }
    }
}
