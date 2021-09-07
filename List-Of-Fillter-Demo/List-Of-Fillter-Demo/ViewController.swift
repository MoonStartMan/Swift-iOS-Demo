//
//  ViewController.swift
//  List-Of-Fillter-Demo
//
//  Created by 王潇 on 2021/9/1.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        
        var fillerListView: FillterListView!
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        fillerListView = FillterListView(frame: .zero)
        self.view.addSubview(fillerListView)
        fillerListView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(215)
        }
        
        fillerListView.clearClick = {
            print("点击了清除")
        }
        
        fillerListView.determineClick = {
            print("点击了确定")
        }
        
        ObtainData()
        
        /// 获取数据
        func ObtainData() {
            let path = Bundle.main.path(forResource: "FillterMockData", ofType: "json") ?? ""
            let url = URL(fileURLWithPath: path)
            
            do {
                let data = try Data(contentsOf: url)
                let jsonData = try JSONDecoder().decode([FillterListModel].self, from: data)
                fillerListView.fillterListModel = jsonData
            } catch let error as Error? {
                print("读取本地数据出现错误!",error ?? "")
            }
        }
        
    }
}
