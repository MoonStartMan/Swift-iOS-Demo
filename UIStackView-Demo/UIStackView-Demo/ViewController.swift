//
//  ViewController.swift
//  UIStackView-Demo
//
//  Created by 王潇 on 2023/2/18.
//

import UIKit
import SnapKit

private let kWidth: CGFloat = UIScreen.main.bounds.size.width

class ViewController: UIViewController {
    
    private var layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    private var collectionView: UICollectionView!
    
    private var dataArray: [ListData] = [
        ListData(index: 1, name: "Toby"),
        ListData(index: 2, name: "Sam"),
        ListData(index: 3, name: "Candy"),
        ListData(index: 4, name: "Jim")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: kWidth, height: 40)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 30
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = true
        collectionView.backgroundColor = .clear
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(36)
            make.bottom.equalTo(-34)
            make.left.right.equalToSuperview()
        }
        collectionView.delegate = self
        collectionView.dataSource = self
        for index in dataArray.indices {
            collectionView.register(ListCell.self, forCellWithReuseIdentifier: NSStringFromClass(ListCell.self) + "\(index)")
        }
        
        collectionView.register(ListCell.self, forCellWithReuseIdentifier: NSStringFromClass(ListCell.self))
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressMoving(longPress:)))
        collectionView.addGestureRecognizer(longPress)
    }
    
    @objc func longPressMoving(longPress: UILongPressGestureRecognizer) {
        switch longPress.state {
        case .began:
            //这里是上报的当前Cell的IndexPath
            //手势作用的位置
            let point = longPress.location(in: self.collectionView)
            let selectIndexPath = self.collectionView?.indexPathForItem(at: point)
            //找到当前的cell
            let selectCell = self.collectionView?.cellForItem(at: selectIndexPath!)
            //拽起变大动画效果
            UIView.animate(withDuration: 0.2) {
                selectCell?.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            }
            //开始移动
            self.collectionView?.beginInteractiveMovementForItem(at: selectIndexPath!)
        case .changed:
            //这里上报的是当前触摸点的位置
            let point = longPress.location(in: self.collectionView)
            //更新移动的位置
            self.collectionView?.updateInteractiveMovementTargetPosition(point)
        case .ended:
            //结束移动
            self.collectionView?.endInteractiveMovement()
        default:
            //移动失败或者取消
            //选中状态清除
            self.collectionView?.cancelInteractiveMovement()
        }
    }
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(ListCell.self) + "\(indexPath.item)", for: indexPath) as? ListCell else {
            fatalError()
        }
        cell.model = dataArray[indexPath.item]
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let sourceData = dataArray[sourceIndexPath.item]
        self.dataArray.remove(at: sourceIndexPath.item)
        self.dataArray.insert(sourceData, at: destinationIndexPath.item)
//        collectionView.moveItem(at: sourceIndexPath, to: destinationIndexPath)
        collectionView.reloadData()
    }
}

extension ViewController: SwipeableCollectionViewCellDelegate {
    func srcollDidEndScroll(inCell cell: UICollectionViewCell) {
        
    }
    
    func scrollDidScroll(inCell cell: UICollectionViewCell) {
        
    }
    
    func scrollLessThanHalfWidth(inCell cell: UICollectionViewCell) {
        //        guard let indexPath = collectionView.indexPath(for: cell),
        //              let cell = collectionView.cellForItem(at: indexPath) as? SwipeableCollectionViewCell else {
        //            return
        //        }
    }
    
    func scrollGreaterThanHalfWidth(inCell cell: UICollectionViewCell) {
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        dataArray.remove(at: indexPath.item)
        collectionView.reloadData()
    }
}
