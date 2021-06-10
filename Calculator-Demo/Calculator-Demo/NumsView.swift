//
//  NumsView.swift
//  Calculator-Demo
//
//  Created by 王潇 on 2021/6/8.
//

import UIKit
import SnapKit

class NumsView: UIView {

    //  数值显示视图
    var digitalView: UIView?
    //  数值label
    var digitalLabel: UILabel?
    //  用户输入表达式或者计算结果字符串
    var inputString = ""
    //  历史表达式字符串
    var historyString = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.digitalView = UIView(frame: .zero)
        self.digitalView?.backgroundColor = UIColor.black
        self.addSubview(self.digitalView!)
        self.digitalView?.snp.makeConstraints({ make in
            make.width.equalToSuperview()
            make.height.equalTo(300)
            make.top.left.equalToSuperview()
        })
        
        self.digitalLabel = UILabel(frame: .zero)
        self.digitalView?.addSubview(self.digitalLabel!)
        self.digitalLabel?.snp.makeConstraints({ make in
            make.height.equalTo(100)
            make.width.equalToSuperview()
            make.centerY.equalToSuperview().offset(0)
            make.top.equalToSuperview().offset(200)
        })
        self.digitalLabel?.text = "0"
        self.digitalLabel?.font = UIFont.systemFont(ofSize: 100)
        self.digitalLabel?.textColor = .white
        self.digitalLabel?.textAlignment = NSTextAlignment.right
        self.digitalLabel?.adjustsFontSizeToFitWidth = true
        
    }
    
    //  提供一个输入信息的接口
    func inputContent(content: String) {
        inputString.append(content)
        self.digitalLabel?.text = inputString
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
