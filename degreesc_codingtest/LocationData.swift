//
//  LocationData.swift
//  degreesc_codingtest
//
//  Created by 한법문 on 2022/04/04.
//

import Foundation

struct LocationItem: Codable {
//    var id = UUID()
    var title: String
    var location_type: String
    var woeid: Int
    var latt_long: String
}
