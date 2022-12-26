//
//  PanViewController.swift
//  AutoLayout-Demo
//
//  Created by 王潇 on 2022/12/22.
//

import UIKit

class PanViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(PanViewCell.self), for: indexPath) as? PanViewCell else {
            fatalError()
        }
        cell.backgroundColor = .black
        return cell
    }
    
    
    private var layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    private var spaceLayout: NSLayoutConstraint!
    
    var panGesture: UIPanGestureRecognizer!
    
    var topSpaceLayoutConstant: CGFloat = 0.0
    var originY: CGFloat = 0.0
    
    private lazy var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    
    private var panView: UIView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupView()
        
        topSpaceLayoutConstant = spaceLayout.constant
        originY = panView.frame.origin.y
    }
    
    func setupView() {
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.size.width - 40.0) / 3.0, height: 60)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0.0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(PanViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(PanViewCell.self))
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        let collectionViewTop = NSLayoutConstraint(item: collectionView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 44)
        let collectionViewLeft = NSLayoutConstraint(item: collectionView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0)
        let collectionViewRight = NSLayoutConstraint(item: collectionView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0)
        let collectionViewHeight = NSLayoutConstraint(item: collectionView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 60)
        collectionView.superview?.addConstraints([collectionViewTop, collectionViewLeft, collectionViewRight, collectionViewHeight])
        collectionView.backgroundColor = .clear
        
        view.addSubview(panView)
        panView.translatesAutoresizingMaskIntoConstraints = false
        
        let panViewTop = NSLayoutConstraint(item: panView, attribute: .top, relatedBy: .equal, toItem: collectionView, attribute: .bottom, multiplier: 1, constant: 10)
        spaceLayout = panViewTop
        let panViewLeft = NSLayoutConstraint(item: panView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 10)
        let panViewRight = NSLayoutConstraint(item: panView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: -10)
        let panViewHeight = NSLayoutConstraint(item: panView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 80)
        panView.superview?.addConstraints([panViewTop, panViewLeft, panViewRight, panViewHeight])
        panView.backgroundColor = .systemPink
        
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(toggleTop))
        panView.addGestureRecognizer(panGesture)
    }
    
    @objc func toggleTop() {
        if panGesture.state == UIGestureRecognizer.State.ended {
            UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseOut) {
//                self.panView.frame.origin.y = self.originY + 104.0
                self.spaceLayout.constant = self.topSpaceLayoutConstant
                self.view.layoutIfNeeded()
            } completion: { success in
//                if success {
                    
//                }
            }
            return
        }
        let y = panGesture.translation(in: self.view).y
        spaceLayout.constant = topSpaceLayoutConstant + y
    }
}
