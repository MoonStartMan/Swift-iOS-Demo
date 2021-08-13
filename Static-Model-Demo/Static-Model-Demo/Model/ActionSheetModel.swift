//
//  ActionSheetModel.swift
//  Static-Model-Demo
//
//  Created by 王潇 on 2021/8/11.
//

import Foundation
import UIKit

/// 动画时间
let timerDuration: Float = 0.5
/// 单个高度
let itemHeight: Int = 80

struct ActionSheetModelItem {
    var iconImage: String
    var title: String
}


class ActionSheet: UIView{
    /// Btn包起来的view
    var btnCoverView: UIView!
    /// 传入model
    var model: [ActionSheetModelItem] = []
    /// 点击事件
    var ensureClick: ((ActionSheetModelItem) -> Void)?
    /// 取消点击事件
    var cancelClick: (() -> Void)?
    /// 设置弹窗的函数
    ///
    /// - Parameters
    ///     -   superView: 弹窗索要放在的位置,UIWindow或者UIView上
    ///     -   model:  传递为ActionSheetModelItem的数组
    ///     -   ensureClick:  点击事件
    ///     -   cancel: 取消点击
    static func setActionSheet(superView: UIView?, model: [ActionSheetModelItem], ensureClick: @escaping (ActionSheetModelItem) -> Void, cancel: @escaping () -> Void) {
        
        let actionSheetView = ActionSheet()
        actionSheetView.backgroundColor = UIColor.hex("#000000", 0.7)
        
        if let superView = superView {
            superView.addSubview(actionSheetView)
            actionSheetView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            superView.layoutIfNeeded()
        } else {
            let window = UIApplication.shared.windows.filter({ $0.isKeyWindow }).last
            window?.addSubview(actionSheetView)
            actionSheetView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            window?.layoutIfNeeded()
        }
        
        actionSheetView.model = model
        actionSheetView.ensureClick = ensureClick
        actionSheetView.cancelClick = cancel
        actionSheetView.addItem()
    }
    
    /// 循环渲染Item
    func addItem() {
        btnCoverView = UIView(frame: .zero)
        let totalCount = model.count
        self.addSubview(btnCoverView)
        btnCoverView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(totalCount*itemHeight)
            make.height.equalTo(totalCount*itemHeight)
        }
        self.layoutIfNeeded()
        for (index, item) in model.enumerated() {
            let listBtn = ActionSheetItem()
            btnCoverView.addSubview(listBtn)
            listBtn.snp.makeConstraints { make in
                make.left.right.equalToSuperview()
                make.bottom.equalToSuperview().offset(-index*itemHeight)
                make.height.equalTo(itemHeight)
            }
            listBtn.iconImage = item.iconImage
            listBtn.title = item.title
            listBtn.tag = index
            listBtn.addTarget(self, action: #selector(click), for:.touchUpInside)
            listBtn.backgroundColor = UIColor.hex("#FFFFFF")
        }
        btnCoverView.layoutIfNeeded()
        popupView()
    }
    
    /// 弹出界面动画
    func popupView() {
        let totalCount = self.model.count
        UIView.animate(withDuration: TimeInterval(timerDuration)) {
            self.btnCoverView.snp.remakeConstraints { make in
                make.left.right.equalToSuperview()
                make.bottom.equalToSuperview()
                make.height.equalTo(totalCount*itemHeight)
            }
            self.layoutIfNeeded()
        }
    }
    /// 传递
    @objc func click(sender:UIButton) {
        ensureClick?(model[sender.tag])
    }
    /// 消失事件
    func dismissRecognizer() {
        let totalCount = self.model.count
        UIView.animate(withDuration: TimeInterval(timerDuration)) {
            self.btnCoverView.snp.remakeConstraints { make in
                make.left.right.equalToSuperview()
                make.bottom.equalToSuperview().offset(totalCount*itemHeight)
                make.height.equalTo(totalCount*itemHeight)
            }
            self.layoutIfNeeded()
        } completion: { isFinish in
            if isFinish {
                self.removeFromSuperview()
            }
        }

    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let view = touches.first?.view, view == self.btnCoverView {
            return
        }
        dismissRecognizer()
    }
}
