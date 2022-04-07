//
//  LocationViewModel.swift
//  Local_Weather
//
//  Created by 한법문 on 2022/04/07.
//

import Combine
import Alamofire

class LocationViewModel: ObservableObject {
    var subscription = Set<AnyCancellable>()
    @Published var isLoading = false
    @Published var locations = [IdentifiableLocation]()
    
    init () {
        fetchLocation()
    }
    
    func fetchLocation() {
        isLoading = true
        AF.request("\(BASE_URL)api/location/search/?query=se", method: .get)
            .publishDecodable(type: [LocationItem].self)
            .compactMap { $0.value }
            .sink { [weak self] completion in
                guard let self = self else { return }
                self.isLoading = false                
            } receiveValue: { [weak self] receivedValue in
                guard let self = self else { return }
                self.makeIdentifiableLocation(receivedValue)
            }
            .store(in: &subscription)
    }
    
    func makeIdentifiableLocation(_ locationItems: [LocationItem]) {
        var location = [IdentifiableLocation]()
        for item in locationItems {
            location.append(IdentifiableLocation(location: item))
        }
        locations = location
    }
}
