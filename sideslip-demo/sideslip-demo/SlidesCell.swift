//
//  SlidesCell.swift
//  sideslip-demo
//
//  Created by 王潇 on 2023/2/17.
//

import UIKit
import SnapKit

class SlidesCell: UITableViewCell {
    
    private var startPointX: CGFloat = 0.0
    
    private var endStartPointX: CGFloat = 0.0
    
    var model: SlidesModelItem? {
        didSet {
            if let model = model {
                titleLable.text = model.content
            }
        }
    }
    
    private var titleLable: UILabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.addSubview(titleLable)
        titleLable.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        titleLable.textColor = .black
        titleLable.font = .systemFont(ofSize: 12, weight: .bold)
        
//        let panGesture = UIPanGestureRecognizer()
//        panGesture.addTarget(self, action: #selector(moveGesture(sender:)))
//
//        self.contentView.addGestureRecognizer(panGesture)
//        self.contentView.backgroundColor = .systemPink
    }
    
//    @objc func moveGesture(sender: UIPanGestureRecognizer) {
//        let offset = sender.location(in: self)
//        if sender.state == .began {
//            startPointX = offset.x
//            print("\(startPointX)")
//        } else if sender.state == .ended {
//            endStartPointX = offset.x
//            print("\(endStartPointX)")
//        } else if sender.state == .changed {
//            self.contentView.center.x = offset.x
//        }
//    }
    
}

struct SlidesModelItem {
    var content: String
}
