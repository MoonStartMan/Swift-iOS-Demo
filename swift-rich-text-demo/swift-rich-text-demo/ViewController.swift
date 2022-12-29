//
//  ViewController.swift
//  swift-rich-text-demo
//
//  Created by 王潇 on 2022/12/29.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private var textLabel1: UILabel = UILabel()
    
    private var textLabel2: UILabel = UILabel()
    
    private var textLabel3: UILabel = UILabel()
    
    private var textLabel4: UILabel = UILabel()
    
    private var textLabel5: UILabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupView()
    }

    private func setupView() {
        view.addSubview(textLabel1)
        view.addSubview(textLabel2)
        view.addSubview(textLabel3)
        view.addSubview(textLabel4)
        view.addSubview(textLabel5)
        
        /// 字体上色
        textLabel1.snp.makeConstraints { make in
            make.top.equalTo(200)
            make.centerX.equalToSuperview()
        }
        let textString1 = "风萧萧兮易水寒 壮士一去兮不复还"
        let attStr1 = NSMutableAttributedString(string: textString1)
        attStr1.addAttribute(.foregroundColor, value: UIColor.orange, range: NSRange(location: 0, length: 7))
        attStr1.addAttribute(.foregroundColor, value: UIColor.systemPink, range: NSRange(location: 8, length: 8))
        textLabel1.attributedText = attStr1
        
        /// 字体大小
        textLabel2.snp.makeConstraints { make in
            make.top.equalTo(textLabel1.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        let textString2 = "设置字体大小"
        let attStr2 = NSMutableAttributedString(string: textString2)
        attStr2.addAttribute(.font, value: UIFont.systemFont(ofSize: 28, weight: .bold), range: NSRange(location: 0, length: 6))
        textLabel2.attributedText = attStr2
        
        /// 字体背景色
        textLabel3.snp.makeConstraints { make in
            make.top.equalTo(textLabel2.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        let textString3 = "我是带背景色的文字"
        let attStr3 = NSMutableAttributedString(string: textString3)
        attStr3.addAttribute(.backgroundColor, value: UIColor.systemTeal, range: NSRange(location: 0, length: 9))
        textLabel3.attributedText = attStr3
        
        /// 字体阴影
        textLabel4.snp.makeConstraints { make in
            make.top.equalTo(textLabel3.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        let text4Shadow = NSShadow()
        text4Shadow.shadowColor = UIColor.red
        text4Shadow.shadowOffset = CGSize(width: 2, height: 2)
        let textString4 = "我是带有阴影的字体"
        let attStr4 = NSMutableAttributedString(string: textString4)
        attStr4.addAttributes([NSAttributedString.Key.foregroundColor: UIColor.systemBlue, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .bold), NSAttributedString.Key.shadow: text4Shadow], range: NSRange(location: 0, length: 9))
        textLabel4.attributedText = attStr4
        
        /// 下划线
        textLabel5.snp.makeConstraints { make in
            make.top.equalTo(textLabel4.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        let textString5 = "这是一个有下划线的文字"
        let attStr5 = NSMutableAttributedString(string: textString5)
        attStr5.addAttributes([NSAttributedString.Key.foregroundColor: UIColor.purple, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .bold), NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single], range: NSRange(location: 0, length: 11))
        textLabel5.attributedText = attStr5
    }
}

