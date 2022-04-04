//
//  LocationSearchView.swift
//  degreesc_codingtest
//
//  Created by 한법문 on 2022/04/04.
//

import SwiftUI

struct LocationSearchView: View {
    @State var location: String = ""
    @ObservedObject var locationSearchViewModel =  LocationSearchViewModel()
    let geometry: GeometryProxy
    
    init(_ geometry: GeometryProxy) {
        self.geometry = geometry
    }
    var body: some View {
        TextField("Please enter your location", text: $location)
            .disableAutocorrection(true)
            .textFieldStyle(.roundedBorder)
            .autocapitalization(.none)
            .padding()
            .onChange(of: self.location) { newValue in
                locationSearchViewModel.fetchLocationSubject.send(newValue)
            }
    }
}

struct LocationSearchView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geo in
            LocationSearchView(geo)
        }
    }
}
