//
//  LocationSearchViewModel.swift
//  degreesc_codingtest
//
//  Created by 한법문 on 2022/04/04.
//

import Foundation
import Combine
import Alamofire
import UIKit

class LocationSearchViewModel: ObservableObject {
    var subscription = Set<AnyCancellable>()
    
    @Published var isLoading: Bool = false
    @Published var searchedLocation = [IdentifiableLocation]()
    
    var fetchLocationSubject = PassthroughSubject<String, Never>()
    
    init() {
        fetchLocationSubject.sink { [weak self] receivedValue in
            guard let self = self else { return }
            self.fetchLocation(receivedValue)
        }
        .store(in: &subscription)
    }
    
    func fetchLocation(_ location: String) {
        isLoading = true
        AF.request(Router.searchLocaion(query: location))
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
        searchedLocation = location
    }
}


