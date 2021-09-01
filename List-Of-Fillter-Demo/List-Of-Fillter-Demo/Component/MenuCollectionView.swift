//
//  MenuCollectionView.swift
//  List-Of-Fillter-Demo
//
//  Created by 王潇 on 2021/9/1.
//

import UIKit

class MenuCollectionView: UIView, UICollectionViewDelegate, UICollectionViewDataSource {
    /// cellID
    private let cellIdentifier: String = "fillterCellID"
    /// cell的行间距
    private let minimumLineSpacingNum: CGFloat = 10
    /// 单个item的大小
    private let itemSize: CGSize = CGSize(width: 60, height: 30)
    /// 滤镜栏列表距离左侧按钮的距离
    private let leftMargin: CGFloat = 10
    /// 滤镜栏列表的高度
    private let collectionViewHeight: CGFloat = 40
    /// 按钮的大小
    private let btnSize: CGSize = CGSize(width: 30, height: 30)
    
    /// 清除按钮
    var clearBtn: UIButton!
    /// 滤镜列表
    var collectionView: UICollectionView!
    /// layout
    var layout: UICollectionViewFlowLayout!
    /// IndexPath
    var currentIndexPath: IndexPath? = IndexPath(item: -1, section: 0)

    override init(frame: CGRect) {
        super.init(frame: frame)
        uiConfig()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

/// MARK: collectionView UIConfig
extension MenuCollectionView {
    func uiConfig() {
        
        clearBtn = UIButton()
        self.addSubview(clearBtn)
        clearBtn.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(btnSize.width)
            make.height.equalTo(btnSize.height)
        }
        clearBtn.backgroundColor = .systemBlue
        clearBtn.isHidden = true
        
        layout = UICollectionViewFlowLayout()
        layout.itemSize = itemSize
        layout.minimumLineSpacing = minimumLineSpacingNum
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        self.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(clearBtn.snp.right).offset(leftMargin)
            make.right.equalToSuperview()
            make.height.equalTo(collectionViewHeight)
        }
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
    }
}

/// MARK: collectionView delegate
extension MenuCollectionView {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MenuCell
        cell.menuLabel.text = "\(indexPath.item + 1)"
        if currentIndexPath == indexPath {
            cell.changeActive(isActive: true)
        } else {
            cell.changeActive(isActive: false)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentIndexPath = indexPath
        collectionView.reloadData()
    }
}


/// MARK: btn点击事件
extension MenuCollectionView {
    @objc func clearSelect() {
        clearBtn.isHidden = true
    }
}
