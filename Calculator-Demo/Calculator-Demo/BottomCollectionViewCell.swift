//
//  BottomCollectionViewCell.swift
//  Calculator-Demo
//
//  Created by 王潇 on 2021/6/9.
//

import UIKit
import SnapKit

class BottomCollectionViewCell: UICollectionViewCell {
    
    public var btnLabel: UILabel?
    public var btnView: UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.btnView = UIView.init(frame: .zero)
        self.addSubview(self.btnView!)
        self.btnView?.snp.makeConstraints({ make in
            make.edges.equalToSuperview()
        })
        
        self.btnLabel = UILabel(frame: .zero)
        self.btnView?.addSubview(self.btnLabel!)
        self.btnLabel?.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.btnView?.layer.cornerRadius = self.frame.size.height * 0.5
        self.btnView?.layer.masksToBounds = true
        self.btnLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        self.btnLabel?.textAlignment = .center
        self.btnLabel?.textColor = .white
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
