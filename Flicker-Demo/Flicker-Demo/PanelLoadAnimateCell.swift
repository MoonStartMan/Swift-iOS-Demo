//
//  PanelLoadAnimateCell.swift
//  Flicker-Demo
//
//  Created by 王潇 on 2023/9/27.
//

import UIKit

class PanelLoadAnimateCell: UICollectionViewCell {
    
    private var coverView: UIView = UIView()
    
    private var imageView: UIImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .clear
        
        contentView.addSubview(coverView)
        coverView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        coverView.layer.cornerRadius = 12
        coverView.layer.masksToBounds = true
        coverView.backgroundColor = .systemGray6
        
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        imageView.image = UIImage(named: "animate_block")
        imageView.contentMode = .scaleAspectFill
        imageView.center = CGPoint(x: 0, y: 0)
        imageView.transform = CGAffineTransform(translationX: -140.0, y: 0)
        
        UIView.animate(withDuration: 1.6, delay: 0, options: [.curveEaseInOut, .repeat]) {
            self.imageView.transform = CGAffineTransform(translationX: 140.0, y: 0)
        }
    }
}
