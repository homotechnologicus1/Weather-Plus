//
//  WeatherLocation.swift
//  Weather Plus
//
//  Created by joe_mac on 02/02/2021.
//

import Foundation

struct WeatherLocation: Codable, Equatable {
    var city: String
    var country: String
    var countryCode: String
    var isCurrentLocation: Bool
}
