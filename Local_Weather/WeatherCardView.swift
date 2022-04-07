//
//  WeatherCardView.swift
//  Local_Weather
//
//  Created by 한법문 on 2022/04/07.
//

import SwiftUI
import URLImage

struct WeatherCardView: View {
    let geometry: GeometryProxy
    let location: IdentifiableLocation
    @Binding var reLoading: Bool
    @ObservedObject var weatherViewModel = WeatherViewModel()
    
    init (_ geometry: GeometryProxy, _ location: IdentifiableLocation, _ reLoading: Binding<Bool> = .constant(false)) {
        self.geometry = geometry
        self.location = location
        _reLoading = reLoading
    }
    
    var body: some View {
        let localWidth = geometry.size.width / 8
        HStack {
            VStack(alignment: .center, spacing: 0) {
                Text(location.location.title)
                    .frame(width: localWidth)
                Rectangle()
                    .frame(width: localWidth, height: 0)
            }
            Divider()
            if let weatherInfo = weatherViewModel.weatherInfo {
                WeatherView(geometry, weatherInfo)
                    .padding([.vertical])
            } else {
                HStack {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
            }
        } // HStack
        .onAppear {
            if (weatherViewModel.weatherInfo == nil) {
                weatherViewModel.fetchWeatherSubject.send(location)
            }
        }
        .onChange(of: self.reLoading) { _ in
            weatherViewModel.fetchWeatherSubject.send(location)
        }

    }
}

struct WeatherView: View {
    let geometry: GeometryProxy
    let weatherInfo: WeatherInfo
    
    init (_ geometry: GeometryProxy, _ weatherInfo: WeatherInfo) {
        self.geometry = geometry
        self.weatherInfo = weatherInfo
    }
    var body: some View {
        let imgSize = geometry.size.width / 8 > 50 ? 50 : geometry.size.width / 8
        let localWidth = geometry.size.width / 8
        let dayWidth = (geometry.size.width - localWidth - 60) / 2
        
        HStack {
            HStack {
                if let url = URL(string: weatherInfo.todayAbbrURL) {
                    URLImage(url) { image in
                        image
                            .resizable()
                            .frame(width: imgSize, height: imgSize)
                            
                    }
                }
                VStack(alignment: .leading, spacing: 10) {
                    Text(weatherInfo.todayWeather)
                        .font(.system(size: 15))
                    HStack {
                        Text("\(weatherInfo.todayTemp)℃")
                            .bold()
                            .foregroundColor(.red)
                            .font(.system(size: 15))
                        Text("\(weatherInfo.todayHumidity)%")
                            .bold()
                            .font(.system(size: 15))
                    }
                } // VStack
            }
            .frame(width: dayWidth)
            
            Divider()
            
            HStack {
                if let url = URL(string: weatherInfo.tomorrowAbbrURL) {
                    URLImage(url) { image in
                        image
                            .resizable()
                            .frame(width: imgSize, height: imgSize)
                    }
                }
                VStack(alignment: .leading, spacing: 10) {
                    Text(weatherInfo.tomorrowWeather)
                        .font(.system(size: 15))
                    HStack {
                        Text("\(weatherInfo.tomorrowTemp)℃")
                            .bold()
                            .foregroundColor(.red)
                            .font(.system(size: 15))

                        Text("\(weatherInfo.tomorrowHumidity)%")
                            .bold()
                            .font(.system(size: 15))
                    }
                } // VStack
            }
            .frame(width: dayWidth)

        } // HStack
    }
}

