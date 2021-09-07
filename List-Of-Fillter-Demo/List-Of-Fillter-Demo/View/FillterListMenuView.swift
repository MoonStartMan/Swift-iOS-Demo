//
//  MenuCollectionView.swift
//  List-Of-Fillter-Demo
//
//  Created by 王潇 on 2021/9/1.
//

import UIKit

/// cellID
fileprivate let cellIdentifier: String = "fillterCellID"
/// cell的行间距
fileprivate let minimumLineSpacingNum: CGFloat = 10
/// 滤镜栏列表距离左侧按钮的距离
fileprivate let leftMargin: CGFloat = 10
/// 滤镜栏列表的高度
fileprivate let collectionViewHeight: CGFloat = 40
/// 按钮的大小
fileprivate let btnSize: CGSize = CGSize(width: 30, height: 30)

class FillterListMenuView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    /// 索引闭包
    typealias fillterMenuClickBlock = (_ index: Int) -> Void
    /// 滤镜菜单的Model
    var menuModel: [FillterListModel] = []
    /// 点击传递索引闭包
    var callBack: fillterMenuClickBlock?
    /// 滤镜列表
    var collectionView: UICollectionView!
    /// layout
    var layout: UICollectionViewFlowLayout!
    /// IndexPath
    var currentIndexPath: IndexPath? = IndexPath(item: 0, section: 0) {
        didSet {
            if let indexPath = currentIndexPath {
                callBack?(indexPath.item)
                collectionView.reloadData()
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        uiConfig()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

/// MARK: collectionView UIConfig
extension FillterListMenuView {
    func uiConfig() {
        layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = minimumLineSpacingNum
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        self.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(collectionViewHeight)
        }
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(FillterMenuCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
    }
}

/// MARK: collectionView delegate
extension FillterListMenuView {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! FillterMenuCell
        cell.model = menuModel[indexPath.item]
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
    }
    
    /// 设置每个cell的大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let str = menuModel[indexPath.item].fillterTitle
        let width = textAutoWidth(str: str, height: 20, font: .systemFont(ofSize: 12.0))
        return CGSize(width: width + 5, height: 20)
    }
}

extension FillterListMenuView {
    func textAutoWidth(str: String, height:CGFloat, font:UIFont) ->CGFloat{
        let string = str
        let origin = NSStringDrawingOptions.usesLineFragmentOrigin
        let lead = NSStringDrawingOptions.usesFontLeading
        let rect = string.boundingRect(with:CGSize(width:0, height: height), options: [origin,lead], attributes: [NSAttributedString.Key.font:font], context:nil)
        return rect.width
    }
}

