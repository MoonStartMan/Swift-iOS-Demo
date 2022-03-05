//
//  GroupMenuView.swift
//  Group-Demo
//
//  Created by 王潇 on 2022/3/4.
//

import UIKit
import SnapKit

/// 左右总长度
private let totalMargin: CGFloat = 16

/// 文字左右边距总长度
private let textLabelMargin: CGFloat = 16

class GroupMenuView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    typealias cellClickBlock = (_ value: Int) -> Void
    /// 最大宽度
    private let maxWidth: CGFloat = UIScreen.main.bounds.size.width - 32.0
    /// 外层View
    private var coverView: UIView = UIView()
    /// 主编辑外层按钮
    private var coverMainEditBtnView: UIView = UIView()
    /// 主编辑按钮
    private var mainEditBtn: UIButton = UIButton()
    /// layout
    private var layout: UICollectionViewFlowLayout!
    /// 滑动菜单
    private var collectionView: UICollectionView!
    /// 编辑按钮长度
    private var mainBtnWidth: CGFloat = 0.0
    /// 当前是第几层
    var currentLevel: Int = 0 {
        didSet {
            if currentLevel <= 5 {
                textArray.removeAll()
                resetUI(level: currentLevel)
            }
        }
    }
    
    var cellClickBack: cellClickBlock?
    
    private var currentIndexPath: IndexPath?
    
    /// 临时存放文字的数组
    private var textArray: [String] = []

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(coverView)
        coverView.snp.remakeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.height.equalTo(48)
            make.width.equalTo(0)
        }
        coverView.backgroundColor = .white
        coverView.layer.cornerRadius = 14
        coverView.layer.masksToBounds = true
        
        coverView.addSubview(coverMainEditBtnView)
        coverMainEditBtnView.addSubview(mainEditBtn)
        
        mainBtnWidth = "Main".widthWith(font: .systemFont(ofSize: 10, weight: .bold))
        
        coverMainEditBtnView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.left.equalToSuperview().offset(4)
            make.height.equalTo(40)
            make.width.equalTo(mainBtnWidth + totalMargin)
        }
        coverMainEditBtnView.backgroundColor = .white
        
        mainEditBtn.backgroundColor = UIColor(red: 0.969, green: 0.969, blue: 0.969, alpha: 1)
        mainEditBtn.setTitle("Main", for: .normal)
        mainEditBtn.setTitleColor(.black, for: .normal)
        mainEditBtn.titleLabel?.font = .systemFont(ofSize: 10, weight: .bold)
        mainEditBtn.layer.cornerRadius = 13
        mainEditBtn.layer.masksToBounds = true
        mainEditBtn.snp.remakeConstraints { make in
            make.top.left.bottom.equalToSuperview()
            make.width.equalTo(mainBtnWidth + totalMargin)
        }
        mainEditBtn.addTarget(self, action: #selector(editMainClick), for: .touchUpInside)
        
        layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        coverView.addSubview(collectionView)
        collectionView.snp.remakeConstraints { make in
            make.left.equalTo(coverMainEditBtnView.snp.right).offset(4)
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(40)
        }
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(GroupMenuCell.self, forCellWithReuseIdentifier: NSStringFromClass(GroupMenuCell.self))
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    func resetUI(level: Int) {
        
        /// 总长的宽度
        var totalWidth: CGFloat = mainBtnWidth + totalMargin
        
        /// 当前该展示的宽度
        var currentWidth: CGFloat = 0.0
        
        for i in 0..<level {
            textArray.append("Group\(i + 1)")
        }
        
        for item in textArray {
            let width = item.widthWith(font: .systemFont(ofSize: 10, weight: .bold)) + 16 + textLabelMargin
            totalWidth += width
        }
        
        if totalWidth > maxWidth {
            coverView.snp.remakeConstraints { make in
                make.top.equalToSuperview()
                make.left.equalToSuperview().offset(16)
                make.right.equalToSuperview().offset(-16)
                make.height.equalTo(48)
            }
        } else {
            currentWidth = totalWidth
            coverView.snp.remakeConstraints { make in
                make.top.equalToSuperview()
                make.left.equalToSuperview().offset(16)
                make.height.equalTo(48)
                make.width.equalTo(currentWidth)
            }
        }
        
        collectionView.snp.remakeConstraints { make in
            make.left.equalTo(coverMainEditBtnView.snp.right).offset(4)
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(40)
        }
        
        collectionView.setNeedsLayout()
        collectionView.layoutIfNeeded()
        collectionView.scrollToItem(at: IndexPath(item: currentLevel - 1, section: 0), at: .centeredHorizontally, animated: false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func editMainClick() {
        textArray.removeAll()
        currentLevel = 0
    }
    
    override func layoutSubviews() {
        let shadowPath0 = UIBezierPath(roundedRect: mainEditBtn.bounds, cornerRadius: 14)
        let layer0 = CALayer()
        layer0.shadowPath = shadowPath0.cgPath
        layer0.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.06).cgColor
        layer0.shadowOpacity = 1
        layer0.shadowRadius = 4
        layer0.shadowOffset = CGSize(width: 3, height: 0)
        layer0.bounds = mainEditBtn.bounds
        layer0.position = mainEditBtn.center
        mainEditBtn.layer.addSublayer(layer0)
    }
    
}

extension GroupMenuView {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return textArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(GroupMenuCell.self), for: indexPath) as? GroupMenuCell else {
            fatalError()
        }
        cell.textString = textArray[indexPath.item]
        if currentIndexPath == IndexPath(item: indexPath.item, section: 0) {
            cell.changeState(isActive: true)
        } else {
            cell.changeState(isActive: false)
        }
        cell.menuClickBack = cellClickBack
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentIndexPath = IndexPath(item: indexPath.item, section: 0)
        cellClickBack?(indexPath.item + 1)
        currentLevel = indexPath.item
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = textArray[indexPath.item].widthWith(font: .systemFont(ofSize: 10, weight: .bold)) + 16 + 16
        return CGSize(width: width, height: 40)
    }
}
