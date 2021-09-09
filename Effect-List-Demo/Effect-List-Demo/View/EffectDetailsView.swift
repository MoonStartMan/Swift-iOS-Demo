//
//  EffectMenuView.swift
//  Effect-List-Demo
//
//  Created by 王潇 on 2021/9/8.
//

import UIKit
/// cellID
private let cellID = "effectDetailsCellID"
/// cell普通状态下的大小
private let normalItemSize: CGSize = CGSize(width: 54, height: 75)
/// cell点击状态下的大小
private let activeItemSize: CGSize = CGSize(width: 60, height: 80)
/// cell之间的横向间距
private let minimumLineSpacingNum: CGFloat = 8


class EffectDetailsView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate {
    /// 详情collectionView
    private var detailsCollectionView: UICollectionView!
    /// layout
    private var layout: UICollectionViewFlowLayout!
    /// 记录当前的indexPath,初始化为不选中
    var currentIndexPath: IndexPath? = IndexPath(item: -1, section: 0)

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        uiConfig()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

// MARK: - UIConfig
extension EffectDetailsView {
    func uiConfig() {
        layout = UICollectionViewFlowLayout()
        layout.itemSize = normalItemSize
        layout.minimumLineSpacing = 8
        layout.scrollDirection = .horizontal
        detailsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        self.addSubview(detailsCollectionView)
        detailsCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        detailsCollectionView.backgroundColor = .clear
        detailsCollectionView.showsHorizontalScrollIndicator = false
        detailsCollectionView.delegate = self
        detailsCollectionView.dataSource = self
        detailsCollectionView.register(EffectDetailsCell.self, forCellWithReuseIdentifier: cellID)
    }
}

// MARK: - CollectionViewDelegate
extension EffectDetailsView {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = detailsCollectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? EffectDetailsCell else {
            fatalError()
        }
        if currentIndexPath == indexPath {
            cell.changeActive(isActive: true)
        } else {
            cell.changeActive(isActive: false)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentIndexPath = indexPath
        self.detailsCollectionView.reloadData()
        self.detailsCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if currentIndexPath == indexPath {
            return activeItemSize
        } else {
            return normalItemSize
        }
    }
}
