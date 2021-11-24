//
//  ViewController.swift
//  Text-Demo
//
//  Created by 王潇 on 2021/11/24.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    var textLabel: UILabel!
    
    var linkLabel: UILabel!
    
    var linkLabel2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //  方法1.已有具体 label ,给定宽度限制,计算 label 的高度
        textLabel = UILabel()
        self.view.addSubview(textLabel)
        textLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(200)
            make.left.equalToSuperview().offset(100)
            make.right.equalToSuperview().offset(-100)
            make.height.equalTo(50)
        }
        textLabel.layoutIfNeeded()
        textLabel.textColor = .white
        textLabel.font = .systemFont(ofSize: 16, weight: .bold)
        let width = textLabel.frame.size.width
        textLabel.backgroundColor = .red
        textLabel.text = "A\nB\nC\nD\nE\nF\nG\nH\nI\nH"
        textLabel.numberOfLines = 0
        textLabel.textAlignment = .center
        let size = textLabel.sizeThatFits(CGSize(width: width, height: CGFloat(MAXFLOAT)))
        textLabel.snp.remakeConstraints { make in
            make.top.equalToSuperview().offset(200)
            make.left.equalToSuperview().offset(100)
            make.right.equalToSuperview().offset(-100)
            make.height.equalTo(size.height)
        }
        
        //  方法2.已知字符串和字号(+1),通过NSString
        linkLabel = UILabel()
        self.view.addSubview(linkLabel)
        linkLabel.snp.makeConstraints { make in
            make.top.equalTo(textLabel.snp.bottom).offset(50)
            make.left.equalToSuperview().offset(100)
            make.right.equalToSuperview().offset(-100)
            make.height.equalTo(0)
        }
        
        let priceStr = String(format: "¥ %@", "10000")
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
        let linkSize = priceStr.size(withAttributes: attributes)
        let attStr = NSMutableAttributedString(string: priceStr)
        
        linkLabel.attributedText = attStr
        
        linkLabel.snp.remakeConstraints { make in
            make.top.equalTo(textLabel.snp.bottom).offset(50)
            make.left.equalToSuperview().offset(100)
            make.right.equalToSuperview().offset(-100)
            make.height.equalTo(linkSize.height)
        }
        linkLabel.numberOfLines = 0
        linkLabel.textAlignment = .center
        linkLabel.backgroundColor = .red
        linkLabel.textColor = .white
        
        //  方法3.已知字符串,字号(+1)和宽度限制,通过 NSString 的 boundingRectWithSize 方法计算
        linkLabel2 = UILabel()
        self.view.addSubview(linkLabel2)
        linkLabel2.snp.makeConstraints { make in
            make.top.equalTo(linkLabel.snp.bottom).offset(50)
            make.left.equalToSuperview().offset(100)
            make.right.equalToSuperview().offset(-100)
            make.height.equalTo(0)
        }
        linkLabel2.numberOfLines = 0
        linkLabel2.textAlignment = .center
        linkLabel2.backgroundColor = .red
        linkLabel2.textColor = .white
        let priceStr2 = String(format: "¥ %@", "20000")
        let attributes2 = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
        let linkSize2 = priceStr2.size(withAttributes: attributes2)
        let attStr2 = NSMutableAttributedString(string: priceStr2)
        linkLabel2.attributedText = attStr2
        linkLabel2.snp.remakeConstraints { make in
            make.top.equalTo(linkLabel.snp.bottom).offset(50)
            make.left.equalToSuperview().offset(100)
            make.right.equalToSuperview().offset(-100)
            make.height.equalTo(linkSize2.height)
        }
        
        /// 添加下划线
        let textStr = NSAttributedString(string: priceStr, attributes: [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue])
        textLabel.attributedText = textStr
    }
}

