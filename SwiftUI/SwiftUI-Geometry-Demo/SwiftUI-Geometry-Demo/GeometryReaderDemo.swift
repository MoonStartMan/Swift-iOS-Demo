//
//  StructDemo1.swift
//  SwiftUI-Geometry-Demo
//
//  Created by 王潇 on 2021/8/7.
//

import SwiftUI

struct GeometryReaderDemo: View {
    var body: some View {
        GeometryReaderView()
            .frame(width: 200, height: 100, alignment: .center)
    }
}

struct StructDemo1_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReaderDemo()
    }
}

struct GeometryReaderView: View {
    var body: some View {
        GeometryReader { proxy in
            HStack(spacing: 0) {
                Text("\(proxy.size.width)")
                    .layoutPriority(1)
                
                MyRectangle()
                    .layoutPriority(1)
            }
            .border(Color.pink, width: 1)
        }
    }
}
