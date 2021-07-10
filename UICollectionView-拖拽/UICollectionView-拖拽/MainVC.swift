//
//  MainVC.swift
//  UICollectionView-拖拽
//
//  Created by 王潇 on 2021/7/9.
//

import UIKit

let KMainCellID = "MainCellID"
let itemWidth = (UIScreen.main.bounds.size.width / 4) - 10

class MainVC: UIViewController{

    var photoCollectionView: UICollectionView!
    var layout: UICollectionViewFlowLayout!
    lazy var imageArray = [
            UIImage(named: "1")!,
            UIImage(named: "2")!,
            UIImage(named: "3")!,
            UIImage(named: "4")!,
            UIImage(named: "5")!,
            UIImage(named: "6")!,
            UIImage(named: "7")!,
            UIImage(named: "8")!,
            UIImage(named: "9")!,
            UIImage(named: "10")!,
            UIImage(named: "11")!,
            UIImage(named: "12")!,
            UIImage(named: "13")!
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        photoCollectionView.delegate = self
        photoCollectionView.dataSource = self
        photoCollectionView.dragDelegate = self
        photoCollectionView.dropDelegate = self
        photoCollectionView.dragInteractionEnabled = true   //  开启拖放交互
        // Do any additional setup after loading the view.
    }
    
    func setUI() {
        layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        layout.scrollDirection = .vertical
        photoCollectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        view.addSubview(photoCollectionView)
        photoCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        photoCollectionView.register(MainCell.self, forCellWithReuseIdentifier: KMainCellID)
    }

}

extension MainVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(indexPath.item)")
    }
}


extension MainVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KMainCellID, for: indexPath) as! MainCell
        let view = UIView(frame: .zero)
        cell.addSubview(view)
        cell.imageView.image = imageArray[indexPath.item]
        return cell
    }
    
}

extension MainVC: UICollectionViewDragDelegate {
    //  开始拖拽时
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        //  可用indexPath判断某section或某item是否可拖动,若不可拖动则返回空数组
        
        let image = imageArray[indexPath.item]
        let dragItem = UIDragItem(itemProvider: NSItemProvider(object: image))
        dragItem.localObject = image//放下cell时，移动image数组里的数据时需用到;在同一app内拖放时，localObject可以加快数据传递
        
        return [dragItem]
        
    }
    //若一次拖动多个,需实现itemsForAddingTo方法
    //若要改变拖拽时cell外观,需实现dragPreviewParametersForItemAt方法
}

extension MainVC: UICollectionViewDropDelegate {
    //拖着移动时-可选实现，但一般都实现，频繁调用，代码尽可能快速简单执行
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        //DropProposal--放开cell的方案
        //若需实现section间不可拖拽的功能:可定全局变量dragingIndexPath(拖拽起始位置)，在itemsForBeginning中赋值为indexPath，然后对比他的section是否等于destinationIndexPath(拖拽结束位置)的section，若不等于则返回forbidden，
        //可用session.localDragSession来判断是否在同一app中操作
        
        if collectionView.hasActiveDrag{
            return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        }
        return UICollectionViewDropProposal(operation: .forbidden)
    }
    
    //放下cell时（手指离开屏幕）
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        //coordinator协调器，类似于context上下文，iOS中常用的获取之前数据的机制
        //若不是在本app中拖拽cell（如iPad中可拖拽图片进app以上传图片功能），则coordinator.destinationIndexPath为nil
        
        if coordinator.proposal.operation == .move,
           let item = coordinator.items.first,//本例中拖拽单个，故获取first即可
           let sourceIndexPath = item.sourceIndexPath,
           let destinationIndexPath = coordinator.destinationIndexPath{
            
            //将多个操作合并为一个动画
            collectionView.performBatchUpdates {
                imageArray.remove(at: sourceIndexPath.item)
                imageArray.insert(item.dragItem.localObject as! UIImage, at: destinationIndexPath.item)
                collectionView.moveItem(at: sourceIndexPath, to: destinationIndexPath)
            }
            //固定操作,让拖拽变得自然
            coordinator.drop(item.dragItem, toItemAt: destinationIndexPath)
            
        }
    }
}
