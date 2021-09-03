//
//  MenuCollectionView.swift
//  List-Of-Fillter-Demo
//
//  Created by 王潇 on 2021/9/1.
//

import UIKit

class MenuCollectionView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    /// 闭包
    typealias fillterMenuClickBlock = (_ index: Int) -> Void
    /// cellID
    private let cellIdentifier: String = "fillterCellID"
    /// cell的行间距
    private let minimumLineSpacingNum: CGFloat = 10
    /// 单个item的最小大小
    private let itemSize: CGSize = CGSize(width: 10, height: 12)
    /// 滤镜栏列表距离左侧按钮的距离
    private let leftMargin: CGFloat = 10
    /// 滤镜栏列表的高度
    private let collectionViewHeight: CGFloat = 40
    /// 按钮的大小
    private let btnSize: CGSize = CGSize(width: 30, height: 30)
    
    /// 滤镜菜单的Model
    var menuModel: [FillterListModel] = []
    
    /// 点击传递闭包
    var callBack: fillterMenuClickBlock?
    
    /// 清除按钮
    var clearBtn: UIButton!
    /// 滤镜列表
    var collectionView: UICollectionView!
    /// layout
    var layout: UICollectionViewFlowLayout!
    /// IndexPath
    var currentIndexPath: IndexPath? = IndexPath(item: 0, section: 0)

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
        clearBtn.setImage(UIImage(named: "fillterClearBtn"), for: .normal)
        
        layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = itemSize
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
        return menuModel.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MenuCell
        /// FIXME
        cell.menuLabel.text = menuModel[indexPath.item].fillterTitle
        if currentIndexPath == indexPath {
            cell.changeActive(isActive: true)
        } else {
            cell.changeActive(isActive: false)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentIndexPath = indexPath
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        if callBack != nil {
            callBack!(indexPath.item)
        }
        collectionView.reloadData()
    }
}


/// MARK: btn点击事件
extension MenuCollectionView {
    @objc func clearSelect() {
        clearBtn.isHidden = true
    }
}
