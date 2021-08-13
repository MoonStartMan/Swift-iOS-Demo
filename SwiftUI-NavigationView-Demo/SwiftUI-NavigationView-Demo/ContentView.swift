//
//  ContentView.swift
//  SwiftUI-NavigationView-Demo
//
//  Created by 王潇 on 2021/8/7.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                
            }
            .navigationBarUIColor(Color.pink)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension View {
    
    func navigationBarUIColor(_ backgroundColor: Color?) -> some View {
        self.modifier(NavigationBarModifier(backgroundColor: UIColor(backgroundColor!)))
    }
    
}
