//
//  BannerView.swift
//  store-demo
//
//  Created by 王潇 on 2021/6/25.
//

import Foundation
import UIKit
import SnapKit

protocol BannerViewDataSource: AnyObject {
    func numberOfBanners(_ bannerView: BannerView) -> Int
    func ViewForBanner(_ bannerView: BannerView, index: Int, convertView: UIView) -> UIView
}

protocol BannerViewDelegate: AnyObject {
    func didSelectBanner(_ bannerView: BannerView, index: Int)
}

class BannerView: UIView, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var collectionView: UICollectionView?
    var flowLayout: UICollectionViewFlowLayout?
    
    var pageControl: UIPageControl?
    
    weak var dataSource: BannerViewDataSource!
    weak var delegate: BannerViewDelegate!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
    
}
