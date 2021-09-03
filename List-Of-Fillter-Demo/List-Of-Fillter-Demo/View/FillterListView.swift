//
//  FillterListView.swift
//  List-Of-Fillter-Demo
//
//  Created by 王潇 on 2021/9/1.
//

import UIKit

class FillterListView: UIView {
    /// 滤镜列表数据
    var fillterListModel: [FillterListModel] = [] {
        didSet {
            menuCollectionView.menuModel = fillterListModel
        }
    }
    /// 滤镜详情列表数据
    var detailModel: [FillterListModelItem] = [] {
        didSet {
            fillterCollectionView.fillterDetailsModel = detailModel
        }
    }
    /// 滤镜控件
    private var fillterControView: FillterControlView!
    /// 菜单列表
    private var menuCollectionView: MenuCollectionView!
    /// 详情列表
    private var fillterCollectionView: FillterDetailsCollectionView!
    /// 距离父视图的左右距离
    private let margin: CGFloat = 16

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        /// 顶部控制栏
        fillterControView = FillterControlView(frame: .zero)
        self.addSubview(fillterControView)
        fillterControView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(margin)
            make.right.equalToSuperview().offset(-margin)
            make.height.equalTo(40)
        }
        
        /// 菜单列表
        menuCollectionView = MenuCollectionView(frame: .zero)
        self.addSubview(menuCollectionView)
        menuCollectionView.snp.makeConstraints { make in
            make.top.equalTo(fillterControView.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(margin)
            make.right.equalToSuperview().offset(-margin)
            make.height.equalTo(20)
        }
        
        
        
        menuCollectionView.callBack = { (index: Int) -> Void in
            self.detailModel = self.fillterListModel[index].fillterList
            self.fillterCollectionView.collectionView.reloadData()
        }
        
        /// 详情列表
        fillterCollectionView = FillterDetailsCollectionView(frame: .zero)
        self.addSubview(fillterCollectionView)
        fillterCollectionView.snp.makeConstraints { make in
            make.top.equalTo(menuCollectionView.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(margin)
            make.right.equalToSuperview().offset(-margin)
            make.height.equalTo(84)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
