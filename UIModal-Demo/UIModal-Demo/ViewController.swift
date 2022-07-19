//
//  ViewController.swift
//  UIModal-Demo
//
//  Created by 王潇 on 2022/7/13.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    private var fullScreenBtn: UIButton = UIButton()
    private var overFullScreenBtn: UIButton = UIButton()
    private var currentContextBtn: UIButton = UIButton()
    private var overCurrentContextBtn: UIButton = UIButton()
    private var pageSheetBtn: UIButton = UIButton()
    private var formSheetBtn: UIButton = UIButton()
    private var customBtn: UIButton = UIButton()
    private var popoverBtn: UIButton = UIButton()
    
    private var btnArrayName: [String] = ["FullScreen", "PageSheet", "FormSheet", "CurrentContext", "Custom", "OverFullScreen", "PopOver", "None"]
    private var btnArray: [UIButton] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        btnArray.append(fullScreenBtn)
        btnArray.append(overFullScreenBtn)
        btnArray.append(currentContextBtn)
        btnArray.append(overCurrentContextBtn)
        btnArray.append(pageSheetBtn)
        btnArray.append(formSheetBtn)
        btnArray.append(customBtn)
        btnArray.append(popoverBtn)
        
        let kScrrenWidth: CGFloat = UIScreen.main.bounds.size.width
        let priceMargin: CGFloat = 20.0
        let priceWidth: CGFloat = (kScrrenWidth - 100) / 4.0
        var addCount: Int = 0
        
        for (index, item) in btnArray.enumerated() {
            if index % 4 == 0 {
                addCount = 0
            }
            view.addSubview(item)
            item.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(100 + Int(index / 4) * 40)
                make.left.equalToSuperview().offset(priceWidth * CGFloat(addCount) + priceMargin * CGFloat(addCount + 1))
                make.width.equalTo(priceWidth)
                make.height.equalTo(30)
            }
            addCount += 1
            item.setTitleColor(.white, for: .normal)
            item.backgroundColor = .black
            item.layer.cornerRadius = 15
            item.layer.masksToBounds = true
            item.titleLabel?.adjustsFontSizeToFitWidth = true
            item.setTitle(btnArrayName[index], for: .normal)
            item.addAction(UIAction(handler: { action in
                switch index {
                case 0:
                    self.fullScreenStyle()
                case 1:
                    self.pageSheetStyle()
                case 2:
                    self.formSheetStyle()
                case 3:
                    self.currentContextStyle()
                case 4:
                    self.customStyle()
                case 5:
                    self.overFullScreenStyle()
                case 6:
                    self.overCurrentContextStyle()
                case 7:
                    self.popoverStyle()
                case 8:
                    self.noneStyle()
                default:
                    break
                }
            }), for: .touchUpInside)
        }
        
    }
    
    private func fullScreenStyle() {
        let testVC = TestViewController()
        testVC.modalPresentationStyle = .fullScreen
        self.navigationController?.present(testVC, animated: true, completion: nil)
    }
    
    private func pageSheetStyle() {
        let testVC = TestViewController()
        testVC.modalPresentationStyle = .pageSheet
        self.navigationController?.present(testVC, animated: true, completion: nil)
    }
    
    private func formSheetStyle() {
        let testVC = TestViewController()
        testVC.modalPresentationStyle = .formSheet
        self.navigationController?.present(testVC, animated: true, completion: nil)
    }
    
    private func currentContextStyle() {
        let testVC = TestViewController()
        testVC.modalPresentationStyle = .currentContext
        self.navigationController?.present(testVC, animated: true, completion: nil)
    }
    
    private func customStyle() {
        let testVC = TestViewController()
        testVC.modalPresentationStyle = .custom
        self.navigationController?.present(testVC, animated: true, completion: nil)
    }
    
    private func overFullScreenStyle() {
        let testVC = TestViewController()
        testVC.modalPresentationStyle = .overFullScreen
        self.navigationController?.present(testVC, animated: true, completion: nil)
    }
    
    private func overCurrentContextStyle() {
        let testVC = TestViewController()
        testVC.modalPresentationStyle = .overCurrentContext
        self.navigationController?.present(testVC, animated: true, completion: nil)
    }
    
    private func popoverStyle() {
        let testVC = TestViewController()
        testVC.modalPresentationStyle = .popover
        self.navigationController?.present(testVC, animated: true, completion: nil)
    }
    
    private func noneStyle() {
        let testVC = TestViewController()
        testVC.modalPresentationStyle = .none
        self.navigationController?.present(testVC, animated: true, completion: nil)
    }
}

