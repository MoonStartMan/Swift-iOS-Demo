//
//  EditBarView.swift
//  BottomBarView-Demo
//
//  Created by 王潇 on 2022/2/28.
//

import UIKit
import SnapKit

struct editItem {
    var type: EditBarCellBtnType
    var isClick: Bool
}

class EditBarView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    typealias editBtnClickBlock = (_ type: EditBarCellBtnType) -> Void
    
    private var collectionView: UICollectionView!
    
    private var layout: UICollectionViewFlowLayout!
    
    private var modelArray: [EditBarCellModel] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var bottomEditBarArray: [editItem] = [] {
        didSet {
            var bottomArray: [EditBarCellModel] = []
            for item in bottomEditBarArray {
                switch item.type {
                case .copy:
                    bottomArray.append(EditBarCellModel(btnType: .icon, imageName: "copy", actionType: .copy, isClick: item.isClick))
                case .replace:
                    bottomArray.append(EditBarCellModel(btnType: .icon, imageName: "replace", actionType: .replace, isClick: item.isClick))
                case .leftCut:
                    bottomArray.append(EditBarCellModel(btnType: .icon, imageName: "cut_left", actionType: .leftCut, isClick: item.isClick))
                case .centerCut:
                    bottomArray.append(EditBarCellModel(btnType: .icon, imageName: "cut", actionType: .centerCut, isClick: item.isClick))
                case .rightCut:
                    bottomArray.append(EditBarCellModel(btnType: .icon, imageName: "cut_right", actionType: .rightCut, isClick: item.isClick))
                case .volume:
                    bottomArray.append(EditBarCellModel(btnType: .icon, imageName: "turn_on", actionType: .volume, isClick: item.isClick))
                case .delete:
                    bottomArray.append(EditBarCellModel(btnType: .icon, imageName: "delete", actionType: .delete, isClick: item.isClick))
                case .none:
                    bottomArray.append(EditBarCellModel(btnType: .line, imageName: "", actionType: .none, isClick: item.isClick))
                }
            }
            modelArray = bottomArray
        }
    }
    
    var editBtnBack: editBtnClickBlock?
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        
        let totalWidth = UIScreen.main.bounds.size.width - 16*2 - 24*7 - 1*2
        let minimumInteritemSpacing = CGFloat(totalWidth / 10)
        
        layout.minimumInteritemSpacing = minimumInteritemSpacing
        layout.sectionInset = UIEdgeInsets(top: 0, left: minimumInteritemSpacing, bottom: 0, right: 0)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(48)
        }
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = false
        collectionView.register(EditBarCell.self, forCellWithReuseIdentifier: NSStringFromClass(EditBarCell.self))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension EditBarView {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return modelArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(EditBarCell.self), for: indexPath) as? EditBarCell else {
            fatalError()
        }
        cell.model = modelArray[indexPath.item]
        cell.btnClickBack = editBtnBack
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let model: EditBarCellModel = modelArray[indexPath.item]
        if model.btnType == .icon {
            return CGSize(width: 24, height: 24)
        } else {
            return CGSize(width: 1, height: 16)
        }
    }
}
