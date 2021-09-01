//
//  FillterDetailsCollectionView.swift
//  List-Of-Fillter-Demo
//
//  Created by 王潇 on 2021/9/1.
//

import UIKit
import SnapKit

class FillterDetailsCollectionView: UIView, UICollectionViewDelegate, UICollectionViewDataSource {
    /// CellID
    private let cellIdentifier: String = "FillterDetailCellID"
    /// cell的行间距
    private let minimumLineSpacingNum: CGFloat = 10
    /// 单个item的大小
    private let itemSize: CGSize = CGSize(width: 60, height: 84)
    /// IndexPath
    var currentIndexPath: IndexPath? = IndexPath(item: -1, section: 0)
    
    var collectionView: UICollectionView!
    var layout: UICollectionViewFlowLayout!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        uiConfig()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

/// MARK: - UIConfig
extension FillterDetailsCollectionView {
    func uiConfig() {
        layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = minimumLineSpacingNum
        layout.itemSize = itemSize
        layout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        self.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(FillterDetailCell.self, forCellWithReuseIdentifier: cellIdentifier)
    }
}

/// MARK: - UICollectionViewDelegate
extension FillterDetailsCollectionView {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! FillterDetailCell
        if currentIndexPath == indexPath {
            cell.changeActive(isActive: true)
        } else {
            cell.changeActive(isActive: false)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentIndexPath = indexPath
        self.collectionView.reloadData()
    }
}
