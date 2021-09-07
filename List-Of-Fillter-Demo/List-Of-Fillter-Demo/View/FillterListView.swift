//
//  FillterListView.swift
//  List-Of-Fillter-Demo
//
//  Created by 王潇 on 2021/9/1.
//

import UIKit

class FillterListView: UIView {
    /// 清除闭包
    typealias clearBlock = () -> Void
    
    /// 滤镜列表数据
    var fillterListModel: [FillterListModel] = [] {
        didSet {
            menuCollectionView.menuModel = fillterListModel
            /// 判断越界
            menuCollectionView.currentIndexPath = IndexPath(item: 0, section: 0)
        }
    }
    /// 滤镜详情列表数据
    private var detailModel: [FillterListModelItem] = [] {
        didSet {
            fillterCollectionView.fillterDetailsModel = detailModel
        }
    }
    /// 滤镜详情的model
    var detailItemModel: FillterListModelItem?
    
    /// 滤镜控件
    private var fillterControView: FillterControlView!
    /// 菜单列表
    private var menuCollectionView: MenuCollectionView!
    /// 详情列表
    private var fillterCollectionView: FillterDetailsCollectionView!
    /// 距离父视图的左右距离
    private let margin: CGFloat = 16
    
    /// 清除点击事件
    var clearClick: (() -> Void)?
    /// 确定点击事件
    var determineClick: (() -> Void)?
    
    /// 点击清除事件
    var clearBlock: clearBlock?

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
            make.right.equalToSuperview()
            make.height.equalTo(20)
        }
        
        /// 菜单列表点击的回调
        menuCollectionView.callBack = { (index: Int) -> Void in
            self.detailModel = self.fillterListModel[index].fillterList
            self.fillterControView.selectFillterChange(isSelectFillter: false)
            self.fillterCollectionView.clearState()
        }
        
        /// 详情列表
        fillterCollectionView = FillterDetailsCollectionView(frame: .zero)
        self.addSubview(fillterCollectionView)
        fillterCollectionView.snp.makeConstraints { make in
            make.top.equalTo(menuCollectionView.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(margin)
            make.right.equalToSuperview()
            make.height.equalTo(84)
        }
        
        /// 滤镜详情列表点击的回调
        fillterCollectionView.callBack = {
            self.fillterControView.selectFillterChange(isSelectFillter: true)
            self.detailItemModel = self.fillterCollectionView.fillterDetailItemModel
            self.fillterControView.sliderDefault()
        }
        
        addClickEvent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension FillterListView {
    /// 给四个按钮添加对应的点击事件以及block
    func addClickEvent() {
        /// 清除点击事件
        fillterControView.clearBack = {
            self.clearClick?()
            self.fillterControView.selectFillterChange(isSelectFillter: false)
            self.fillterCollectionView.clearState()
        }
        /// 确定点击事件
        fillterControView.determineBack = {
            self.determineClick?()
        }
    }
}
