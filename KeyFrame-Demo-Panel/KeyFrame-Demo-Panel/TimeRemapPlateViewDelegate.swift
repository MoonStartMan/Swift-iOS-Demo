//
//  TimeRemapPlateViewDelegate.swift
//  KeyFrame-Demo-Panel
//
//  Created by 王潇 on 2023/4/7.
//

import Foundation

protocol TimeRemapPlateViewDelegate: AnyObject {
    /// 添加/删除关键帧
    func keyFrameBtnClick()
    /// 设置/取消定格帧
    func decideFrameBtnClick()
    /// 上一帧
    func prevFrameBtnClick()
    /// 下一帧
    func nextFrameBtnClick()
    /// 曲线点击
    func curveBtnClick()
    /// 重置点击
    func resetBtnClick()
}
