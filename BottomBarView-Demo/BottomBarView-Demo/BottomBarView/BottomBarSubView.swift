//
//  BottomBarSubView.swift
//  BottomBarView-Demo
//
//  Created by 王潇 on 2022/2/28.
//

import UIKit
import SnapKit

private let itemSize: CGSize = CGSize(width: 32, height: 46)

class BottomBarSubView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private var collectionView: UICollectionView!
    
    private var layout: UICollectionViewFlowLayout!
    
    private var totalWidth: CGFloat = 0.0
    
    private var count: Int = 0
    
    private var itemWidth: CGFloat = 0
    
    var bottomBarArray: [BottomBarBtnType] = [] {
        didSet {
            var bottomItemArray: [BottomBarCellModel] = []
            for item in bottomBarArray {
                switch item {
                case .edit:
                    bottomItemArray.append(BottomBarCellModel(imageName: "edit", titleName: "Edit"))
                case .transform:
                    bottomItemArray.append(BottomBarCellModel(imageName: "transfrom", titleName: "Transfrom"))
                case .preset:
                    bottomItemArray.append(BottomBarCellModel(imageName: "preset", titleName: "Preset"))
                case .blend:
                    bottomItemArray.append(BottomBarCellModel(imageName: "blend", titleName: "Blend"))
                case .group:
                    bottomItemArray.append(BottomBarCellModel(imageName: "group", titleName: "Group"))
                case .ingroup:
                    bottomItemArray.append(BottomBarCellModel(imageName: "ingroup", titleName: "Ingroup"))
                case .ungroup:
                    bottomItemArray.append(BottomBarCellModel(imageName: "ungroup", titleName: "Ungroup"))
                case .fade:
                    bottomItemArray.append(BottomBarCellModel(imageName: "fade_in_fade_out", titleName: "Fade"))
                }
            }
            bottomBarMenuArray = bottomItemArray
        }
    }
    
    private var bottomBarMenuArray: [BottomBarCellModel] = [] {
        didSet {
            updateItemWidth()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = itemSize
        layout.scrollDirection = .horizontal
        
        itemWidth = (UIScreen.main.bounds.size.width - itemSize.width * CGFloat(bottomBarMenuArray.count)) / CGFloat(bottomBarMenuArray.count + 1)
        layout.minimumLineSpacing = itemWidth
        layout.sectionInset = UIEdgeInsets(top: 0, left: itemWidth, bottom: 0, right: 0)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-34)
        }
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(BottomBarSubCell.self, forCellWithReuseIdentifier: NSStringFromClass(BottomBarSubCell.self))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateItemWidth() {
        itemWidth = (UIScreen.main.bounds.size.width - itemSize.width * CGFloat(bottomBarMenuArray.count)) / CGFloat(bottomBarMenuArray.count + 1)
        layout.minimumLineSpacing = itemWidth
        layout.sectionInset = UIEdgeInsets(top: 0, left: itemWidth, bottom: 0, right: 0)
        collectionView.reloadData()
    }
    
}

extension BottomBarSubView {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bottomBarMenuArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(BottomBarSubCell.self), for: indexPath) as? BottomBarSubCell else {
            fatalError()
        }
        cell.model = bottomBarMenuArray[indexPath.item]
        return cell
    }
    
}
