//
//  ContentModel.swift
//  SwiftUI-LightAndDark
//
//  Created by 王潇 on 2021/8/2.
//

import SwiftUI

struct settingModel {
    var itemType: ItemType
    var iconImageName: String
    var titleName: String
    var iconRightText: String
}

let settingModelArray: [settingModel] = [
    settingModel(itemType: ItemType.ItemTypeLink, iconImageName: "setting_number", titleName: "Number", iconRightText: ""),
    settingModel(itemType: ItemType.ItemTypeLink, iconImageName: "setting_edit", titleName: "Edit Video", iconRightText: ""),
    settingModel(itemType: ItemType.ItemTypeContent, iconImageName: "setting_delete", titleName: "Delete", iconRightText: "135M"),
    settingModel(itemType: ItemType.ItemTypeLink, iconImageName: "setting_upload", titleName: "Upload", iconRightText: ""),
    settingModel(itemType: ItemType.ItemTypeLink, iconImageName: "setting_search", titleName: "Search", iconRightText: ""),
    settingModel(itemType: ItemType.ItemTypeLink, iconImageName: "setting_like", titleName: "Like", iconRightText: ""),
]

struct linkToModel {
    var linkView: Any
    var tag: String
}

var linkToModelArray :[linkToModel] = [
    linkToModel(linkView: Text("Number"), tag: "toNumber"),
    linkToModel(linkView: Text("Edit Video"), tag: "toEditVideo"),
    linkToModel(linkView: Text("Delete"), tag: "toDelete"),
    linkToModel(linkView: Text("Upload"), tag: "toUpload"),
    linkToModel(linkView: Text("Search"), tag: "toSearch"),
    linkToModel(linkView: Text("Like"), tag: "toLike")
]
