//
//  WeatherViewModel.swift
//  Local_Weather
//
//  Created by 한법문 on 2022/04/07.
//

import Combine
import Alamofire
import Foundation

struct WeatherInfo {
    var todayWeather: String
    var todayAbbrURL: String
    var todayTemp: Int
    var todayHumidity: Int
    var tomorrowWeather: String
    var tomorrowAbbrURL: String
    var tomorrowTemp: Int
    var tomorrowHumidity: Int
}

class WeatherViewModel: ObservableObject {
    var subscription = Set<AnyCancellable>()
    @Published var isLoading: Bool = false
    @Published var weatherInfo: WeatherInfo?
    private var weather = [WeatherItem]()
    
    var fetchWeatherSubject = PassthroughSubject<IdentifiableLocation, Never>()
    init() {
        fetchWeatherSubject.sink { [weak self] receivedValue in
            guard let self = self else { return }
            self.fetchWeather(receivedValue)
        }
        .store(in: &subscription)
    }
    
    func fetchWeather(_ location: IdentifiableLocation) {
        isLoading = true
        AF.request("\(BASE_URL)api/location/\(location.location.woeid)", method: .get)
            .publishDecodable(type: WeatherResponse.self)
            .compactMap { $0.value }
            .sink { [weak self] completion in
                guard let self = self else { return }
                self.weatherInfo = self.makeWeatherInfo()
                self.isLoading = false
            } receiveValue: { [weak self] receivedValue in
                guard let self = self else { return }
                self.weather = receivedValue.consolidated
            }
            .store(in: &subscription)
    }
    
    func makeWeatherInfo() -> WeatherInfo {
        let info = WeatherInfo(todayWeather: weather[0].name,
                               todayAbbrURL: "\(BASE_URL)static/img/weather/png/\(weather[0].abbr).png",
                               todayTemp: Int(round(weather[0].temp)),
                               todayHumidity: weather[0].humidity,
                               tomorrowWeather: weather[1].name,
                               tomorrowAbbrURL: "\(BASE_URL)static/img/weather/png/\(weather[1].abbr).png",
                               tomorrowTemp: Int(round(weather[1].temp)),
                               tomorrowHumidity: weather[1].humidity)
        return (info)
    }
}
