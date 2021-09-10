//
//  ViewController.swift
//  Dynamic-Material-List-Demo
//
//  Created by 王潇 on 2021/9/10.
//

import UIKit

class ViewController: UIViewController {

    var dynamicListView: DynamicListView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dynamicListView = DynamicListView()
        self.view.addSubview(dynamicListView)
        dynamicListView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-44)
            make.left.right.equalToSuperview()
            make.height.equalTo(215)
        }
        
        dynamicListView.scrollBack = { [weak self] yPoint in
            guard let self = self else {
                return
            }
            let height = self.dynamicListView.frame.size.height
            self.dynamicListView.snp.updateConstraints { make in
                make.height.equalTo( height + yPoint)
            }
        }
        
//        let handDrag = UIPanGestureRecognizer(target: self, action: #selector(Drag))
//        dynamicListView.addGestureRecognizer(handDrag)
    }
    
//    @objc func Drag(sender: UIPanGestureRecognizer) {
//        var Point = sender.translation(in: self.view)
//        Point = sender.location(in: self.view)
//        if Point.y <= UIScreen.main.bounds.size.height-215 && Point.y >= UIScreen.main.bounds.size.height - 415 {
//            dynamicListView.snp.updateConstraints { make in
//                make.height.equalTo(215 + UIScreen.main.bounds.size.height - 215 - Point.y)
//            }
//        }
//    }

}
