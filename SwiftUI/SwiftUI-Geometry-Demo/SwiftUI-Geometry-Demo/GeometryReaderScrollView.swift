//
//  GeometryReaderScrollView.swift
//  SwiftUI-Geometry-Demo
//
//  Created by 王潇 on 2021/8/7.
//

import SwiftUI

struct GeometryReaderScrollView: View {
    
    let img = ["1", "2", "3", "4", "5", "6"]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 0) {
                ForEach(0..<img.count) { index in
                    GeometryReader { proxy in
                        Image(img[index])
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .rotation3DEffect(self.rotateAngle(proxy), axis: (x: 0, y: 11, z: 0))
                    }
                    .frame(width: 600.0 / 3, height: 600.0 / 3 * (425 / 640))
                }
            }
        }
        .frame(width: 600)
        .coordinateSpace(name: "ScrollViewSpace")
        .background(Color.black)
        .edgesIgnoringSafeArea(.all)
    }
    
    func rotateAngle(_ proxy: GeometryProxy) -> Angle {
        let dif = 600 * 0.5 - proxy.frame(in: .named("ScrollViewSpace")).midX
        let pct = min(dif / proxy.size.width * 0.5, 1)
        return .degrees(Double(30 * pct))
    }
}
    
    struct GeometryReaderScrollView_Previews: PreviewProvider {
        static var previews: some View {
            GeometryReaderScrollView()
        }
    }
