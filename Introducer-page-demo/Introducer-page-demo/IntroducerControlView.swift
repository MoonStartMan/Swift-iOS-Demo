//
//  IntroducerControlView.swift
//  Introducer-page-demo
//
//  Created by 王潇 on 2022/11/15.
//

import UIKit

class IntroducerControlView: UIView {
    //  左右间距
    private let separationDistance: CGFloat = 10.0
    
    private let itemWidth: CGFloat = 8.0
    
    private let itemHeight: CGFloat = 8.0
    
    private var layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    private var collectionView: UICollectionView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = CGSize(width: itemWidth, height: itemHeight)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
