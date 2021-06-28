//
//  DealListViewController.swift
//  store-demo
//
//  Created by 王潇 on 2021/6/28.
//

import UIKit

class DealListViewController: BaseViewController, CommonListDelegate{
    func didSelectItem<Item>(_ item: Item) {
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let productList = CommonList<Deal, DealListCell>(frame: .zero)
        productList.items = FakeData.createDeals()
        view.addSubview(productList)
        productList.delegate = self
        productList.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.edges.equalToSuperview()
        }
    }
    
    

}
