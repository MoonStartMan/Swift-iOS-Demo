//
//  ContentView.swift
//  Swift-List-Demo
//
//  Created by 王潇 on 2021/8/5.
//

import SwiftUI

struct ContentView: View {
    
    
    private let itemWidth: CGFloat = (UIScreen.main.bounds.size.width - 4) / 3
    private let itemHeight: CGFloat = 182
    
    private var model = ContentModel(count: 8)
    
    var body: some View {
        
        List {
            
            ForEach (0 ..< model.totalRow, id: \.self) { index in
                HStack(spacing: 2) {
                    if index == model.totalRow-1 {
                        ForEach(0 ..< model.lastLineCount, id: \.self) { item in
                            Text("\(index) + \(item)")
                        }
                        .frame(width: itemWidth, height: itemHeight)
                        .background(Color.red)
                        .padding(.bottom, 2)
                    } else {
                        ForEach(0 ..< model.lineMaxcount, id: \.self) { item in
                            Text("\(index) + \(item)")
                        }
                        .frame(width: itemWidth, height: itemHeight)
                        .background(Color.red)
                        .padding(.bottom, 2)
                    }
                }
            }
            .listSeparatorNone()
        }
        .background(Color.clear)
        .listRowBackground(Color.clear)
        .edgesIgnoringSafeArea(.all)
        .onAppear() {
            
        }
        Spacer()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
