//
//  ViewController.swift
//  Slider-Show-Demo
//
//  Created by 王潇 on 2023/7/4.
//

import UIKit

class ViewController: UIViewController {

    private let spacing: CGFloat = 40.0
    
    private let itemWidth: CGFloat = 200.0
    
    private let itemHeight: CGFloat = 300.0
    
    private var layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    private var collectionView: UICollectionView!
    
    private var colorArray: [UIColor] = [.systemRed, .systemBlue, .systemCyan, .systemFill]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupView()
    }

    private func setupView() {
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.decelerationRate = .fast
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(ListCell.self, forCellWithReuseIdentifier: NSStringFromClass(ListCell.self))
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(500)
            make.centerY.equalToSuperview()
        }
    }

}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(ListCell.self), for: indexPath) as? ListCell else {
            fatalError()
        }
        cell.currentColor = colorArray[indexPath.item]
        return cell
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let contentOffsetX = scrollView.contentOffset.x
        var index = Int(ceil(contentOffsetX / (itemWidth + spacing)))
        if let cell = collectionView.cellForItem(at: IndexPath(item: index, section: 0)) as? ListCell {
            // 设置初始状态
            cell.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            cell.alpha = 0

            // 添加动画效果
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: [], animations: {
                cell.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                cell.alpha = 1
            }) { finish in
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: [], animations: {
                    cell.transform = .identity
                    cell.alpha = 1
                })
            }
        }

    }
}
