//
//  HomeViewController.swift
//  store-demo
//
//  Created by 王潇 on 2021/6/25.
//

import UIKit
import Kingfisher

class HomeViewController: BaseViewController, BannerViewDataSource, CommonListDelegate{
    func didSelectItem<Item>(_ item: Item) {
        if let product = item as? Product {
            let detailVC = DetailViewController()
            detailVC.product = product
            detailVC.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        hidesBottomBarWhenPushed = false
    }
    
    func numberOfBanners(_ bannerView: BannerView) -> Int {
        return FakeData.createBanners().count
    }
    
    func ViewForBanner(_ bannerView: BannerView, index: Int, convertView: UIView?) -> UIView {
        if let view = convertView as? UIImageView {
            view.kf.setImage(with: URL(string: FakeData.createBanners()[index]))
            return view
        } else {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.kf.setImage(with: URL(string: FakeData.createBanners()[index]))
            return imageView
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let bannerView = BannerView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 176))
        bannerView.autoScrollInterval = 2
        bannerView.isInfinite = true
        bannerView.dataSource = self
        view.addSubview(bannerView)
        
        let productList = CommonList<Product, ProductCell>(frame: .zero)
        productList.items = FakeData.createProducts()
        view.addSubview(productList)
        productList.delegate = self
        productList.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(bannerView.snp.bottom).offset(5)
        }
    }

}
