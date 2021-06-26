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
    weak var delegate: BannerViewDelegate?
    
    var autoScrollInterval: Float = 0
    //  是否允许无限轮播
    var isInfinite: Bool = true
    //  计时器
    var timer: Timer?
    
    static var cellID = "bannerViewCellID"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        flowLayout = UICollectionViewFlowLayout()
        flowLayout?.headerReferenceSize = .zero
        flowLayout?.footerReferenceSize = .zero
        flowLayout?.minimumLineSpacing = 0
        flowLayout?.minimumInteritemSpacing = 0
        flowLayout?.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        flowLayout?.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height), collectionViewLayout: flowLayout!)
        
        pageControl = UIPageControl()
        self.setupViews()
    }
    
    func setupViews() {
        collectionView?.backgroundColor = .white
        collectionView?.isPagingEnabled = true
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.contentInsetAdjustmentBehavior = .never
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: BannerView.cellID)
        collectionView?.dataSource = self
        collectionView?.delegate = self
        
        self.addSubview(collectionView!)
        self.addSubview(pageControl!)
        
        collectionView?.snp.makeConstraints({ make in
            make.edges.equalToSuperview()
        })
        
        pageControl?.snp.makeConstraints({ make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-15)
        })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let pageNumber = dataSource.numberOfBanners(self)
        if isInfinite {
            if pageNumber == 1 {
                return 1
            } else {
                return pageNumber + 2
            }
        } else {
            return pageNumber
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerView.cellID, for: indexPath)
        var index = indexPath.row
        if isInfinite {
            let pageNumber = dataSource.numberOfBanners(self)
            if pageNumber > 1 {
                if indexPath.row == 0 {
                    index = pageNumber - 1
                }
            }
        }
    }
    
    
}
