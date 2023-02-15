//
//  MSMultiEffectToggleView.swift
//  Aries
//
//  Created by 王潇 on 2023/2/14.
//

import UIKit
import SnapKit

class MSMultiEffectToggleView: UIView {
    
    private var currentIndex: Int = 0
    /// 记录第一次进来
    private var firstIn: Bool = true
    
    var selectBlock: ((_ current: Int) -> Void)?
    
    private lazy var toggleModels: [MSToggleItemModel] = {
       return [
        MSToggleItemModel(image: "effect_icon", name: "快乐", index: 0),
        MSToggleItemModel(image: "filter_icon", name: "自信", index: 1)
       ]
    }()
    
    private var coverView: UIView = {
        let view = UIView()
        return view
    }()
    
    private var slidingBlockView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 20
        view.backgroundColor = .hex("#FFFFFF", 0.9)
        return view
    }()
    
    private var visualEffectView: UIVisualEffectView!
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 90.0, height: 40.0)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0.0
        layout.minimumInteritemSpacing = 1.0
        return layout
    }()
    
    private var collectionView: UICollectionView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(coverView)
        coverView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let blurEffect = UIBlurEffect(style: .systemMaterialLight)
        visualEffectView = UIVisualEffectView(effect: blurEffect)
        coverView.addSubview(visualEffectView)
        visualEffectView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        visualEffectView.layer.masksToBounds = true
        visualEffectView.layer.cornerRadius = 23
        
        coverView.addSubview(slidingBlockView)
        slidingBlockView.snp.makeConstraints { make in
            make.top.left.equalTo(3)
            make.bottom.equalTo(-3)
            make.width.equalTo(90)
        }
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        coverView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.left.equalTo(3)
            make.bottom.right.equalTo(-3)
        }
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.layer.masksToBounds = true
        collectionView.layer.cornerRadius = 20
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MSMultiEffectToggleCell.self, forCellWithReuseIdentifier: NSStringFromClass(MSMultiEffectToggleCell.self))
    }
}

extension MSMultiEffectToggleView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return toggleModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(MSMultiEffectToggleCell.self), for: indexPath) as? MSMultiEffectToggleCell else {
            fatalError()
        }
        cell.model = toggleModels[indexPath.row]
        if currentIndex == cell.model?.index {
            cell.setActive(active: true, ifLayout: !firstIn)
        } else {
            cell.setActive(active: false, ifLayout: !firstIn)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if currentIndex == indexPath.item {
            return
        }
        firstIn = false
        currentIndex = indexPath.item
        selectBlock?(currentIndex)
        if let tempCell = collectionView.cellForItem(at: indexPath) as? MSMultiEffectToggleCell {
            var cellX: CGFloat = 0.0
            var translatePosition: CGFloat = 0.0
            //  左点击
            if currentIndex == 0 {
                cellX = tempCell.frame.origin.x
                translatePosition = tempCell.frame.origin.x + 3
            } else {
                //  右滑
                cellX = tempCell.frame.origin.x + 6
                translatePosition = tempCell.frame.origin.x + 3
            }
            UIView.animate(withDuration: 0.1) {
                self.slidingBlockView.snp.remakeConstraints { make in
                    make.left.equalTo(cellX)
                    make.width.equalTo(90)
                    make.top.equalTo(3)
                    make.bottom.equalTo(-3)
                }
                self.layoutIfNeeded()
            } completion: { finish in
                if finish {
                    UIView.animate(withDuration: 0.2, delay: 0.1) {
                        self.slidingBlockView.snp.remakeConstraints { make in
                            make.left.equalTo(translatePosition)
                            make.width.equalTo(90)
                            make.top.equalTo(3)
                            make.bottom.equalTo(-3)
                        }
                        self.layoutIfNeeded()
                        collectionView.reloadData()
                    }
                }
            }
        }
    }
    
}

struct MSToggleItemModel {
    var image: String
    var name: String
    var index: Int
}
