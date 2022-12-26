//
//  HuggingViewController.swift
//  AutoLayout-Demo
//
//  Created by 王潇 on 2022/12/26.
//

import UIKit
import SnapKit

class HuggingViewController: UIViewController {
    
    private var textLabel: UILabel = UILabel()
    
    private var rightLabel: UILabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.addSubview(textLabel)
        view.addSubview(rightLabel)
        
        textLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(100)
        }
        //  抗拉伸
//        textLabel.setContentHuggingPriority(.init(rawValue: 999), for: .horizontal)
        //  这时候 Label 控件的抗压缩约束优先级比右边约束优先级高，Autolayout 先满足 Lable 控件的固有内容 Size 的宽度，然后再满足左边和右边约束，表现出来就是 Lable 抗压缩特性变强了，它更倾向于显示它固有内容 Size，这时候被压缩的就是左边和右边的约束。
        textLabel.text = "You are not looking for"
        textLabel.textColor = .systemPink
        textLabel.font = .systemFont(ofSize: 16.0, weight: .bold)
        
        rightLabel.snp.makeConstraints { make in
            make.left.equalTo(textLabel.snp.right)
            make.right.equalTo(-50)
            make.centerY.equalToSuperview()
        }
        //  抗压缩
        rightLabel.setContentCompressionResistancePriority(.init(999), for: .horizontal)
        rightLabel.text = "哈哈哈哈哈哈"
        rightLabel.textColor = .blue
        rightLabel.font = .systemFont(ofSize: 16.0, weight: .bold)
    }

}
