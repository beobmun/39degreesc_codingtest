//
//  WeatherInfoCardView.swift
//  degreesc_codingtest
//
//  Created by 한법문 on 2022/04/04.
//

import SwiftUI
import URLImage

struct WeatherInfoCardView: View {
    @ObservedObject var weatherInfoCardViewModel = WeatherInfoCardViewModel()
    
    let geometry: GeometryProxy
    let location: IdentifiableLocation
    
    init(_ geometry: GeometryProxy, _ location: IdentifiableLocation) {
        self.geometry = geometry
        self.location = location
    }
    
    var body: some View {
        LazyVStack {
            if (weatherInfoCardViewModel.weather.count > 0) {
                Text("location : \(location.location.title)")
                HStack {
                    DayWeatherInfo(geometry, "Today", weatherInfoCardViewModel.weather[0])
                    Divider()
                    DayWeatherInfo(geometry, "Tomorrow", weatherInfoCardViewModel.weather[1])
                } // HStack
            } else {
              ProgressView()
            }
        } // VStack
        .onAppear() {
            if !(weatherInfoCardViewModel.weather.count > 0) {
                weatherInfoCardViewModel.fetchWeatherSubject.send(location.location)
            }
        }
    }
}

struct DayWeatherInfo: View {
    let geometry: GeometryProxy
    let when: String
    let weather: WeatherItem
    init(_ geometry: GeometryProxy, _ when: String, _ weather: WeatherItem) {
        self.geometry = geometry
        self.when = when
        self.weather = weather
    }
    var body: some View {
        VStack {
            Text(when)
            if let url = URL(string: "\(BASE_URL)static/img/weather/png/64/\(weather.abbr).png") {
                URLImage(url) { image in
                    image
                        .resizable()
                        .frame(width: geometry.size.width / 6, height: geometry.size.width / 6)
                }
            }
            Text("\(weather.name)")
            Text("\(Int(weather.temp)) ℃")
            Text("\(weather.humidity) %")
            Rectangle()
                .frame(height: 0)
        }
    }
}

//struct WeatherInfoCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        WeatherInfoCardView(1132599)
//    }
//}
