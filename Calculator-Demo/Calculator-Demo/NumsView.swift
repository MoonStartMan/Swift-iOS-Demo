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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.digitalView = UIView(frame: .zero)
        self.digitalView?.backgroundColor = UIColor.black
        self.addSubview(self.digitalView!)
        self.digitalView?.snp.makeConstraints({ make in
            make.width.equalToSuperview()
            make.height.equalTo(200)
            make.top.left.equalToSuperview()
        })
        
        self.digitalLabel = UILabel(frame: .zero)
        self.digitalView?.addSubview(self.digitalLabel!)
        self.digitalLabel?.snp.makeConstraints({ make in
            make.height.equalTo(100)
            make.width.equalToSuperview()
            make.centerY.equalToSuperview().offset(0)
        })
        self.digitalLabel?.text = "0"
        self.digitalLabel?.font = UIFont.systemFont(ofSize: 100)
        self.digitalLabel?.textColor = .white
        self.digitalLabel?.textAlignment = NSTextAlignment.right
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
