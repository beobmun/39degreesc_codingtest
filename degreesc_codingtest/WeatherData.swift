//
//  WeatherData.swift
//  degreesc_codingtest
//
//  Created by 한법문 on 2022/04/04.
//

import Foundation

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
