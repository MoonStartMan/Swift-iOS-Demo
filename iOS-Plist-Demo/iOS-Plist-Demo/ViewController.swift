//
//  ViewController.swift
//  iOS-SnapKit-Demo
//
//  Created by 王潇 on 2023/1/29.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    private var contentView: UIView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        var tipsDataDictionary: [String: Any] {
            guard let categoryListPath = Bundle.main.url(forResource: "ColorArray", withExtension: "plist") else {
                print("找不到plist")
                return [:]
            }
            do {
                let listData = try Data(contentsOf: categoryListPath)
                do {
                    let listDictionary = try PropertyListSerialization.propertyList(from: listData, options: [], format: nil) as! [String: Any]
                    return listDictionary
                } catch {
                    fatalError("plist数据转换失败")
                }
            } catch {
                fatalError("文件路径不存在!")
            }
            return [:]
        }
        
        /// 读取
        for (index, item) in tipsDataDictionary.enumerated() {
            let colorView = UIView()
            view.addSubview(colorView)
            colorView.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(60 + index * 60)
                make.left.equalToSuperview().offset(10)
                make.width.height.equalTo(50)
            }
            colorView.backgroundColor = .hex(item.value as! HexString)
        }
        
        PlistManager.defaltManager.set(value: 2, forKey: "id", plistName: "MyPlist")
        print(PlistManager.defaltManager["MyPlist"])
        print(PlistManager.defaltManager["MyPlist","data"].dictionaryValue)
        
    }

}

extension Dictionary {
    /// 字典转Json字符串
    func toJsonString() -> String? {
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: .sortedKeys) else {
            return nil
        }
        guard let str = String(data: data, encoding: .utf8) else {
            return nil
        }
        return str
    }
}
