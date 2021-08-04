//
//  ContentItemView.swift
//  SwiftUI-LightAndDark
//
//  Created by 王潇 on 2021/8/2.
//

import SwiftUI

enum ItemType {
    case ItemTypeContent    /// 右侧展示数字的
    case ItemTypeLink       /// 右侧带有跳转链接
}

struct ContentItemView: View {
    
    var itemType: ItemType
    
    /// icon图片
    @State var iconImageName: String
    /// 标题名字
    @State var titleName: String
    /// icon右侧类型(选填)
    @State var iconRightText: String
    
    var body: some View {
        if itemType == .ItemTypeLink {
            HStack {
                ContentItemCommon(SettingImageName: $iconImageName, SettingTitleText: $titleName)
                
                Image("setting_arrow")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(Color.init("backgroundColor2"))
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .padding(.trailing, 16)
            }
            .background(Color.init("backgroundColor"))
        } else {
            HStack {
                HStack {
                    ContentItemCommon(SettingImageName: $iconImageName, SettingTitleText: $titleName)
                    
                    Text(iconRightText)
                        .foregroundColor(.gray)
                        .padding(.trailing, 16)
                        .font(.caption)
                }
                .background(Color.init("backgroundColor"))
            }
        }
    }
}

//struct ContentItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentItemView(itemType: .ItemTypeContent, iconImageName: "heart", titleName: "Like", iconRightText: "")
//    }
//}
