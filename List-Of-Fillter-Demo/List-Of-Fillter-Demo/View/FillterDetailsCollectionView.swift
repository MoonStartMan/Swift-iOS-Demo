//
//  FillterDetailsCollectionView.swift
//  List-Of-Fillter-Demo
//
//  Created by 王潇 on 2021/9/1.
//

import UIKit
import SnapKit

class FillterDetailsCollectionView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    /// 点击滤镜的闭包
    typealias fillterClickBlock = () -> Void
    /// 滤镜详情Model
    var fillterDetailsModel: [FillterListModelItem] = []
    /// 滤镜详情单个的model
    var fillterDetailItemModel: FillterListModelItem? = nil
    /// CellID
    private let cellIdentifier: String = "FillterDetailCellID"
    /// cell的行间距
    private let minimumLineSpacingNum: CGFloat = 10
    /// 单个item的大小
    private let itemSize: CGSize = CGSize(width: 54, height: 70)
    /// 激活状态的item大小
    private let activeItemSize: CGSize = CGSize(width: 60, height: 80)
    /// IndexPath
    var currentIndexPath: IndexPath? = IndexPath(item: -1, section: 0)
    
    /// 闭包返回值
    var callBack: fillterClickBlock?
    
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
        return fillterDetailsModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! FillterDetailCell
        if currentIndexPath == indexPath {
            cell.changeActive(isActive: true)
        } else {
            cell.changeActive(isActive: false)
        }
        cell.model = fillterDetailsModel[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentIndexPath = indexPath
        self.collectionView.reloadData()
        if indexPath.item < fillterDetailsModel.count - 1 {
            let newIndexPath = IndexPath(item: indexPath.item + 1, section: indexPath.section)
            collectionView.scrollToItem(at: newIndexPath, at: .centeredHorizontally, animated: true)
        }
        /// 获取单个滤镜的model
        fillterDetailItemModel = fillterDetailsModel[indexPath.item]
        callBack?()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if currentIndexPath == indexPath {
            return activeItemSize
        } else {
            return itemSize
        }
    }
}

extension FillterDetailsCollectionView {
    /// 清除滤镜选中态
    func clearState() {
        currentIndexPath = IndexPath(item: -1, section: 0)
        collectionView.reloadData()
    }
}
