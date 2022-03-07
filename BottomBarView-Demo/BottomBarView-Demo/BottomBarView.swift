//
//  BottomBarView.swift
//  BottomBarView-Demo
//
//  Created by 王潇 on 2022/2/28.
//

import UIKit

class BottomBarView: UIView {
    
    private var editBarView: EditBarView = EditBarView()
    
    private var bottomSubBarView: BottomBarSubView = BottomBarSubView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(editBarView)
        editBarView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(48)
        }
        editBarView.bottomEditBarArray = [
            editItem(type: .copy, isClick: true),
            editItem(type: .replace, isClick: false),
            editItem(type: .none, isClick: false),
            editItem(type: .leftCut, isClick: true),
            editItem(type: .centerCut, isClick: true),
            editItem(type: .rightCut, isClick: true),
            editItem(type: .none, isClick: false),
            editItem(type: .volume, isClick: false),
            editItem(type: .delete, isClick: true)
        ]
        editBarView.editBtnBack = { [weak self] (type) in
            guard let self = self else { return }
            print("\(type)")
        }
        
        addSubview(bottomSubBarView)
        bottomSubBarView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.top.equalTo(editBarView.snp.bottom).offset(16)
        }
        bottomSubBarView.bottomBarArray = [.transform, .preset, .ingroup, .group]
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
