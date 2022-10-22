//
//  MenuView.swift
//  swift-drawer-menu-demo
//
//  Created by 王潇 on 2022/10/17.
//

import UIKit
import SnapKit

class MenuView: UIView {
    
    weak var delegate: MenuViewProtocol?
    
    private var textLabel: UILabel = UILabel()
    
    private var arrowIcon: UIImageView = UIImageView()
    
    private var collectionView: UICollectionView!
    
    private var layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    private var menuArray: [ResolutionMultipleModel] = [
        ResolutionMultipleModel(title: "完整", type: .full, isSelect: false, isCheck: true),
        ResolutionMultipleModel(title: "二分之一", type: .half, isSelect: false, isCheck: true),
        ResolutionMultipleModel(title: "四分之一", type: .quarter, isSelect: false, isCheck: true),
        ResolutionMultipleModel(title: "八分之一", type: .eighth, isSelect: false, isCheck: true)
    ]

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    private func setupView() {
        layer.borderColor = UIColor.systemGray.cgColor
        layer.borderWidth = 1.0
        
        addSubview(textLabel)
        textLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.left.equalToSuperview().offset(12)
        }
        textLabel.text = "预览分辨率"
        textLabel.textColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
        textLabel.font = .systemFont(ofSize: 10, weight: .semibold)
        
        addSubview(arrowIcon)
        arrowIcon.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-12)
            make.centerY.equalTo(textLabel.snp.centerY)
            make.width.height.equalTo(16)
        }
        arrowIcon.image = UIImage(named: "arrow")
        
        layout.itemSize = CGSize(width: 138, height: 44)
        layout.minimumLineSpacing = 0.0
        layout.minimumInteritemSpacing = 0.0
        layout.scrollDirection = .vertical
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(textLabel.snp.bottom).offset(12)
            make.left.right.bottom.equalToSuperview()
        }
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: String(describing: type(of: MenuCell.self)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension MenuView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: type(of: MenuCell.self)), for: indexPath) as? MenuCell else {
            fatalError()
        }
        cell.model = menuArray[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        for item in menuArray {
            item.isSelect = false
        }
        menuArray[indexPath.item].isSelect = true
        collectionView.reloadData()
        delegate?.getCurrentSelect(type: menuArray[indexPath.item].type)
    }
}
