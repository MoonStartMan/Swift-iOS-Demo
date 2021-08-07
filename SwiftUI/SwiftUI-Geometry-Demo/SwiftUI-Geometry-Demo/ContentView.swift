//
//  ContentView.swift
//  SwiftUI-Geometry-Demo
//
//  Created by 王潇 on 2021/8/7.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
//        HStack {
//            Text("Hello World")
//            MyRectangle()
//        }
//        .frame(width: 200, height: 100, alignment: .center)
//        .border(Color.pink, width: 1)
        Text("Hello,World")
            .font(.title2)
            .padding(.all, 10)
            .foregroundColor(.white)
            .background(RoundedCornersView(color: .black,
                                           topLeading: 0,
                                           topTrailing: 30,
                                           bottomLeading: 30,
                                           bottomTrailing: 0))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct MyRectangle: View {
    var body: some View {
        Rectangle().fill(Color.pink)
    }
}
