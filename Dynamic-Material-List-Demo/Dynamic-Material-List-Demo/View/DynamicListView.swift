//
//  DynamicListView.swift
//  Dynamic-Material-List-Demo
//
//  Created by 王潇 on 2021/9/10.
//

import UIKit

/// cell的大小
private let itemSize: CGSize = CGSize(width: 78, height: 76)
/// CellID
private let cellID: String = "ChildCell"

class DynamicListView: UIView, UICollectionViewDelegate, UICollectionViewDataSource {
    typealias scrollBlock = (_ yPoint: CGFloat) -> Void

    var collectionView: UICollectionView!
    var layout: UICollectionViewFlowLayout!
    
    var scrollBack: scrollBlock?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension DynamicListView {
    func setUI() {
        layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = itemSize
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        self.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalToSuperview()
        }
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ChildCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.backgroundColor = .clear
        
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.red.cgColor
    }
}

extension DynamicListView {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? ChildCell else {
            fatalError()
        }
        cell.textString = "\(indexPath.item + 1)"
        return cell
    }
}

extension DynamicListView {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 0 && scrollView.contentOffset.y <= 100 {
            scrollBack?(scrollView.contentOffset.y)
            collectionView.contentOffset.y = 0
        }
    }
}
