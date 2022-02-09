//
//  ViewController.swift
//  CollectionViewDelegate-Demo
//
//  Created by 王潇 on 2022/2/8.
//

import UIKit
import SnapKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    private var idArray: [String] = [] {
        didSet {
            var idString: String = ""
            for (index, item) in idArray.enumerated() {
                if index != idArray.count-1 {
                    idString += "\(item)~"
                } else {
                    idString += "\(item)"
                }
            }
            debugPrint(idString)
        }
    }
    
    private lazy var cellArray: [TestModel] = {
       return [
        TestModel(title: "1"),
        TestModel(title: "2"),
        TestModel(title: "3"),
        TestModel(title: "4"),
        TestModel(title: "5"),
        TestModel(title: "6"),
        TestModel(title: "7"),
        TestModel(title: "8"),
        TestModel(title: "9"),
       ]
    }()

    private var collectionView: UICollectionView!
    
    private var layout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 20
        layout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(TestCell.self, forCellWithReuseIdentifier: NSStringFromClass(TestCell.self))
        
        collectionView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-32)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(40)
        }
        
        collectionView.backgroundColor = .clear
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(TestCell.self), for: indexPath) as! TestCell
        cell.model = cellArray[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let id = cellArray[indexPath.item].title
        if !idArray.contains(id) {
            idArray.append(id)
        }
    }

}

struct TestModel: Codable {
    var title: String = ""
}
