//
//  ViewController.swift
//  UISegmentedControl-Demo
//
//  Created by 王潇 on 2022/1/18.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private var currentIndex = 0

    private var currentTextString = ""
    
    private lazy var control: UISegmentedControl = {
        let items = ["选项1", "选项2", "选项3"]
        let control = UISegmentedControl(items: items)
        //  默认选中第一项
        control.selectedSegmentIndex = 0
        //  添加值改变监听
        control.addTarget(self, action: #selector(segementDidchange), for: .valueChanged)
        return control
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.addSubview(control)
        
        control.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(30)
            make.centerY.equalToSuperview()
        }
        
        //  选择控件中选项的添加和删除
        
        //  添加文字选项
        control.insertSegment(withTitle: "新增选项", at: 1, animated: true)
        //  添加图片选项
        control.insertSegment(with: UIImage(named: "icon"), at: 1, animated: true)
        //  移除选项
        control.removeSegment(at: 1, animated: true)
        //  修改选项颜色(包括图片选项)
        control.tintColor = .red
        //  修改选项文字
        control.setTitle("swift", forSegmentAt: 1)
        //  修改选项图片
        //  (1)下面代码图片会自动变成蓝色
        control.setImage(UIImage(named: "icon"), forSegmentAt: 2)
        //  (2)使用下面代码,图标保留原来的颜色
        control.setImage(UIImage(named: "icon")?.withRenderingMode(.alwaysOriginal), forSegmentAt: 2)
        //  修改选项内容偏移位置
        control.setContentOffset(CGSize(width: 10, height: 7), forSegmentAt: 1)
    }

    @objc func segementDidchange(_ segmented: UISegmentedControl) {
        //  获得选项的索引
        currentIndex = segmented.selectedSegmentIndex
        //  获得选择的文字
        currentTextString = segmented.titleForSegment(at: segmented.selectedSegmentIndex) ?? ""
    }

}

