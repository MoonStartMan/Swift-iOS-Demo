//
//  PanelLoadAnimateView.swift
//  Flicker-Demo
//
//  Created by 王潇 on 2023/9/27.
//

import UIKit
import SnapKit

class PanelLoadAnimateView: UIView, UICollectionViewDelegate, UICollectionViewDataSource {
    private var panelCoverView: UIView = UIView()
    
    private var imageView: UIImageView = UIImageView()

    private var topView: UIView = UIView()
    
    private var gridView: UICollectionView!
    
    private var gridLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .clear
        
        addSubview(panelCoverView)
        panelCoverView.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.height.equalTo(40)
        }
        panelCoverView.backgroundColor = .systemGray6
        panelCoverView.layer.cornerRadius = 16
        panelCoverView.layer.masksToBounds = true
        
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalTo(panelCoverView.snp.edges)
        }
        imageView.image = UIImage(named: "animate_block")
        imageView.contentMode = .scaleAspectFill
        imageView.center = CGPoint(x: 0, y: 0)
        imageView.transform = CGAffineTransform(translationX: -140.0, y: 0)
        UIView.animate(withDuration: 1.6, delay: 0, options: [.curveEaseOut, .repeat]) {
            self.imageView.transform = CGAffineTransform(translationX: 140.0, y: 0)
        }
        
        let itemWidth = (UIScreen.main.bounds.width - 13 * 3 - 16 * 2) / 4
        
        gridLayout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        gridLayout.scrollDirection = .horizontal
        gridLayout.minimumLineSpacing = 20
        gridLayout.minimumLineSpacing = 13
        gridView = UICollectionView(frame: .zero, collectionViewLayout: gridLayout)
        addSubview(gridView)
        gridView.snp.makeConstraints { make in
            make.top.equalTo(panelCoverView.snp.bottom).offset(16)
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.bottom.equalToSuperview().offset(-34)
        }
        gridView.delegate = self
        gridView.dataSource = self
        gridView.register(PanelLoadAnimateCell.self, forCellWithReuseIdentifier: NSStringFromClass(PanelLoadAnimateCell.self))
        gridView.isScrollEnabled = false
        gridView.backgroundColor = .clear
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(PanelLoadAnimateCell.self), for: indexPath) as? PanelLoadAnimateCell else {
            fatalError()
        }
        return cell
    }
}
