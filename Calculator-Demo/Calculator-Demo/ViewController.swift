//
//  ViewController.swift
//  Calculator-Demo
//
//  Created by 王潇 on 2021/5/25.
//

import UIKit
import SnapKit

class ViewController: UIViewController{
    
    //  背景视图
    var backgroundView: UIView?
    
    var numsView: NumsView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.black
        
        //  顶部数值展示视图
        numsView = NumsView(frame: .zero)
        self.view.addSubview(numsView!)
        numsView?.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(300)
            make.top.equalTo(0)
            make.left.equalTo(0)
        }
        
        //  底部展示图
        let layout = UICollectionViewFlowLayout.init()
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .vertical
        let bottomView = BottomCollectionView(frame: .zero, collectionViewLayout: layout)
        self.view.addSubview(bottomView)
        bottomView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(self.view.frame.size.height - 310)
            make.top.equalTo(numsView!.snp.bottom).offset(10)
            make.left.equalTo(0)
        }
        
        bottomView.bottomDelegate = self
    }
}

extension ViewController: CalculateDelegate{
    func showValue(value: String) {
        numsView?.digitalLabel?.text = value
    }
}
