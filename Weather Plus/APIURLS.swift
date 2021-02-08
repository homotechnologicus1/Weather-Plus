//
//  APIURLS.swift
//  Weather Plus
//
//  Created by joe_mac on 02/02/2021.
//

import Foundation

let CURRENTLOCATION_URL = "https://api.weatherbit.io/v2.0/current?lat=\(LocationService.shared.latitude!)&lon=\(LocationService.shared.longitude!)&key=a29d471fc46d40939f9c34ab3627c2b1"
let CURRENTLOCATIONWEEKLYFORECAST_URL = "https://api.weatherbit.io/v2.0/forecast/daily?lat=\(LocationService.shared.latitude!)&lon=\(LocationService.shared.longitude!)&days=7&key=a29d471fc46d40939f9c34ab3627c2b1"
let CURRENTLOCATIONHOURLYFORECAST_URL = "https://api.weatherbit.io/v2.0/forecast/hourly?lat=\(LocationService.shared.latitude!)&lon=\(LocationService.shared.longitude!)&hours=24&key=a29d471fc46d40939f9c34ab3627c2b1"
