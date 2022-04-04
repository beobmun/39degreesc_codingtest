//
//  ContentView.swift
//  degreesc_codingtest
//
//  Created by 한법문 on 2022/04/04.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var locationSearchViewModel =  LocationSearchViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                LocationSearchView(locationSearchViewModel)
                List(locationSearchViewModel.searchedLocation) { location in
                    WeatherInfoCardView(geometry, location)
                }
                .listStyle(.plain)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
