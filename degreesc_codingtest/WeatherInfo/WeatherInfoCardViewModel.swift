//
//  WeatherInfoCardViewModel.swift
//  degreesc_codingtest
//
//  Created by 한법문 on 2022/04/04.
//

import Combine
import Alamofire
import CoreGraphics

class WeatherInfoCardViewModel: ObservableObject {
    var subscription = Set<AnyCancellable>()
    
    @Published var weather = [WeatherItem]()
    var fetchWeatherSubject = PassthroughSubject<LocationItem, Never>()
    
    init() {
        fetchWeatherSubject.sink { [weak self] receivedValue in
            guard let self = self else { return }
            self.fetchWeather(receivedValue.woeid)
        }
        .store(in: &subscription)
    }
    
    func fetchWeather(_ woeid: Int) {
        AF.request("\(BASE_URL)api/location/\(woeid)", method: .get)
            .publishDecodable(type: WeatherResponse.self)
            .compactMap { $0.value }
            .sink { [weak self] receivedValue in
                guard let self = self else { return }
                self.weather = self.weatherTempRound(receivedValue.consolidated)
            }
            .store(in: &subscription)
    }
    
    func weatherTempRound(_ weather: [WeatherItem]) -> [WeatherItem] {
        var result = [WeatherItem]()
        for w in weather {
            let roundedTemp = round(w.temp)
            result.append(WeatherItem(name: w.name, abbr: w.abbr, temp: roundedTemp, humidity: w.humidity))
        }
        return result
    }
}
