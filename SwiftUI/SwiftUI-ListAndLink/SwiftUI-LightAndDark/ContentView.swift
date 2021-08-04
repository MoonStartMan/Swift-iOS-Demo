//
//  ContentView.swift
//  SwiftUI-LightAndDark
//
//  Created by 王潇 on 2021/8/2.
//

import SwiftUI
import UIKit

struct ContentView: View {
    
    //  跳转链接总数
    private let totalCount: Int = settingModelArray.count
    
    //  跳转到Number
    @State var jumpToLink: String? = nil
    
    var body: some View {
        
        NavigationView {
            
            List {
                ForEach(0 ..< settingModelArray.count,id:\.self) { i in
                    NavigationLink(
                        "",
                        destination: linkToModelArray[i].linkView as? Text,
                        tag:linkToModelArray[i].tag,
                        selection: $jumpToLink
                    )
                    .frame(width: 0, height: 0)
                    .hidden()
                    ContentItemView(
                        itemType: settingModelArray[i].itemType,
                        iconImageName: settingModelArray[i].iconImageName,
                        titleName: settingModelArray[i].titleName,
                        iconRightText: settingModelArray[i].iconRightText
                    )
                    .onTapGesture {
                        jumpToLink = "\(linkToModelArray[i].tag)"
                    }
                }
            }
            .background(Color.clear)
            .listRowBackground(Color.clear)
            .environment(\.defaultMinListRowHeight, 80)
            .modifier(ListRemoveSeparator())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ListRemoveSeparator: ViewModifier {
    func body(content: Content) -> some View {
        content
            .onAppear(perform: {
                UITableView.appearance().tableFooterView = UIView()
                UITableView.appearance().separatorStyle = .none
            })
            .onDisappear(perform: {
                UITableView.appearance().tableFooterView = nil
                UITableView.appearance().separatorStyle = .singleLine
            })
    }
}
