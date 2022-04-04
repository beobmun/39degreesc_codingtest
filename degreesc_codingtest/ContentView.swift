//
//  ContentView.swift
//  degreesc_codingtest
//
//  Created by 한법문 on 2022/04/04.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                LocationSearchView(geometry)
                List {
                    
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
