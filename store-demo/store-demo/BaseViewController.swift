//
//  BaseViewController.swift
//  store-demo
//
//  Created by 王潇 on 2021/6/25.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.hexColor(0xf2f4f7);
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.hexColor(0x333333)]
        edgesForExtendedLayout = UIRectEdge(rawValue: 0)
    }

}
