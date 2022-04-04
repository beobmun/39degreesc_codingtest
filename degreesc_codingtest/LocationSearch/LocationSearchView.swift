//
//  LocationSearchView.swift
//  degreesc_codingtest
//
//  Created by 한법문 on 2022/04/04.
//

import SwiftUI

struct LocationSearchView: View {
    @State var location: String = ""
//    @ObservedObject var locationSearchViewModel =  LocationSearchViewModel()
    var locationSearchViewModel:  LocationSearchViewModel
    
    init(_ locationSearchViewModel: LocationSearchViewModel) {
        self.locationSearchViewModel = locationSearchViewModel
    }
    var body: some View {
        HStack {
            TextField("Please enter your location", text: $location)
                .disableAutocorrection(true)
                .textFieldStyle(.roundedBorder)
                .autocapitalization(.none)
                .onSubmit {
                    locationSearchViewModel.fetchLocationSubject.send(location)
                }
            Button {
                locationSearchViewModel.fetchLocationSubject.send(location)
            } label: {
                Text("Search")
                    .padding(8)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
            }

        } // HStack
        .padding()

    }
}

//struct LocationSearchView_Previews: PreviewProvider {
//    @ObservedObject var locationSearchViewModel =  LocationSearchViewModel()
//
//    static var previews: some View {
//        GeometryReader { geo in
//            LocationSearchView(geo, locationSearchViewModel)
//        }
//    }
//}
