//
//  ContentItemCommon.swift
//  SwiftUI-LightAndDark
//
//  Created by 王潇 on 2021/8/2.
//

import SwiftUI

struct ContentItemCommon: View {
    
    @Binding var SettingImageName: String
    @Binding var SettingTitleText: String
    
    var body: some View {
        HStack {
            Image(SettingImageName)
                .resizable()
                .renderingMode(.template)
                .foregroundColor(Color.init("backgroundColor2"))
                .scaledToFit()
                .frame(width: 20, height: 20)
                .padding(.leading, 16)
            
            Text(SettingTitleText)
                .font(.caption)
                .foregroundColor(Color.init("backgroundColor2"))
                .padding(.leading, 24)
        }
        Spacer()
    }
}

//struct ContentItemCommon_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentItemCommon(SettingImageName: .constant("heart"), SettingTitleText: .constant("Like"))
//    }
//}
