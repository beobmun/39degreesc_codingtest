//
//  ContentView.swift
//  Local_Weather
//
//  Created by 한법문 on 2022/04/07.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var locationViewModel = LocationViewModel()
    @State private var reLoading: Bool = false
    
    var body: some View {
        GeometryReader { geometry in

            VStack {
                HStack {
                    Text("Local Weahter")
                        .bold()
                        .font(.largeTitle)
                        .padding()
                    Spacer()
                } // HStack
                if (!locationViewModel.isLoading) {
                    List {
                        listheaderView(geometry)
                        ForEach(locationViewModel.locations) { locaion in
                            WeatherCardView(geometry, locaion, $reLoading)
                        }
                    } // List
                    .listStyle(.plain)
                    .refreshable {
                        reLoading.toggle()
                    }
                } else {
                    Spacer()
                    HStack {
                        Spacer()
                        ProgressView()
                        Spacer()
                    }
                    Spacer()
                }

            } // VStack
        }

    }
}

struct listheaderView: View {
    let geometry: GeometryProxy
    
    init (_ geometry: GeometryProxy) {
        self.geometry = geometry
    }
    var body: some View {
        let localWidth = geometry.size.width / 8
        let dayWidth = (geometry.size.width - localWidth - 60) / 2
        HStack {
            VStack(spacing: 0) {
                Text("Local")
                    .frame(width: localWidth)
                Rectangle()
                    .frame(width: localWidth, height: 0)
            }
            
            Divider()
            VStack(spacing: 0) {
                Rectangle()
                    .frame(width: dayWidth, height: 0)
                Text("Today")
                    .bold()
            }
            Divider()
            VStack(spacing: 0) {
                Rectangle()
                    .frame(width: dayWidth, height: 0)
                Text("Tomorrow")
                    .bold()
            }

        } // HStack
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
