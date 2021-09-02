//
//  FillterListModel.swift
//  List-Of-Fillter-Demo
//
//  Created by 王潇 on 2021/9/2.
//

import Foundation

class FillterListModelItem: NSObject {
    /// id
    var id: String = ""
    /// 是否选中
    var isSelect: Bool = false
    /// 滤镜名称
    var fillterName: String = ""
}

class FillterListModel: NSObject {
    /// id
    var id: String = ""
    /// 滤镜标题
    var fillterTitle: String = ""
    /// 滤镜子列表
    var fillterList: [FillterListModelItem]  = []
}
