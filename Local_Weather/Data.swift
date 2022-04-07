//
//  Data.swift
//  Local_Weather
//
//  Created by 한법문 on 2022/04/07.
//

import Foundation

let BASE_URL = "https://www.metaweather.com/"

struct IdentifiableLocation: Identifiable {
    var id = UUID()
    var location: LocationItem
}

struct LocationItem: Codable {
    var title: String
    var location_type: String
    var woeid: Int
    var latt_long: String
}

struct WeatherResponse: Codable {
    var consolidated: [WeatherItem]
    
    private enum CodingKeys: String, CodingKey {
        case consolidated = "consolidated_weather"
    }
}

struct WeatherItem: Codable {
    var name: String
    var abbr: String
    var temp: Double
    var humidity: Int
    
    private enum CodingKeys: String, CodingKey {
        case name = "weather_state_name"
        case abbr = "weather_state_abbr"
        case temp = "the_temp"
        case humidity = "humidity"
    }
}

