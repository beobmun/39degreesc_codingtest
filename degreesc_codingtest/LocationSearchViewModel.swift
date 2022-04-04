//
//  LocationSearchViewModel.swift
//  degreesc_codingtest
//
//  Created by 한법문 on 2022/04/04.
//

import Foundation
import Combine
import Alamofire

class LocationSearchViewModel: ObservableObject {
    var subscription = Set<AnyCancellable>()
    
    @Published var isLoading: Bool = false
    @Published var searchedLocation = [LocationItem]()
    
    var fetchLocationSubject = PassthroughSubject<String, Never>()
    
    init() {
        fetchLocationSubject.sink { [weak self] receivedValue in
            guard let self = self else { return }
            print(receivedValue)
            self.fetchLocation(receivedValue)
        }
        .store(in: &subscription)
    }
    
    func fetchLocation(_ location: String) {
        isLoading = true
        AF.request(Router.serchLocaion(query: location))
            .publishDecodable(type: [LocationItem].self)
            .sink { [weak self] completion in
                guard let self = self else { return }
                self.isLoading = false
            } receiveValue: { [weak self] receivedValue in
                guard let self = self else { return }
                if let value = receivedValue.value {
                    self.searchedLocation = value
                }
                print("\(self.searchedLocation)")
            }
            .store(in: &subscription)
    }
}
