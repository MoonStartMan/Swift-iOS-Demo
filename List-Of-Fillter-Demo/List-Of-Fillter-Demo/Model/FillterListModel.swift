//
//  FillterListModel.swift
//  List-Of-Fillter-Demo
//
//  Created by 王潇 on 2021/9/2.
//

import Foundation

class FillterListModelItem: Decodable {
    /// id
    var id: String = ""
    /// 是否需要更新
    var isUpdate: Bool = false
    /// 滤镜名称
    var fillterName: String = ""
    /// 滤镜图片
    var imageUrl: String = ""
}

class FillterListModel: Decodable {
    /// id
    var id: String = ""
    /// 滤镜标题
    var fillterTitle: String = ""
    /// 滤镜子列表
    var fillterList: [FillterListModelItem]  = []
}
