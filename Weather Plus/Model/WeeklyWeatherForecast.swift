//
//  WeeklyWeatherForecast.swift
//  Weather Plus
//
//  Created by joe_mac on 01/30/2021.
//

import Foundation
import Alamofire
import SwiftyJSON

class WeeklyWeatherForecast {
    private var _date: Date!
    private var _temp: Double!
    private var _weatherIcon: String!
    
    var date: Date {
        if _date == nil {
            _date = Date()
        }
        return _date
    }
    var temp: Double {
        if _temp == nil {
            _temp = 0.0
        }
        return _temp
    }
    var weatherIcon: String {
        if _weatherIcon == nil {
            _weatherIcon = ""
        }
        return _weatherIcon
    }
    
    init(weatherDictionary: Dictionary<String, AnyObject>) {
        let json = JSON(weatherDictionary)
        self._temp = json["temp"].double
        self._date = currentDateFromUnix(unixDate: json["ts"].double!)
        self._weatherIcon = json["weather"]["icon"].stringValue
    }

    class func downloadWeeklyWeatherForecast(location: WeatherLocation, completion: @escaping ([WeeklyWeatherForecast]) -> Void) {
        var WEEKLYFORECAST_URL: String!
        
        if !location.isCurrentLocation {
            WEEKLYFORECAST_URL = String(format: "https://api.weatherbit.io/v2.0/forecast/daily?city=%@,%@&days=7&key=a29d471fc46d40939f9c34ab3627c2b1", location.city, location.countryCode)
        } else {
            WEEKLYFORECAST_URL = CURRENTLOCATIONWEEKLYFORECAST_URL
        }
        
        AF.request(WEEKLYFORECAST_URL).responseJSON { (response) in
            var forecastArray: [WeeklyWeatherForecast] = []
            switch response.result {
            case .success(let value):
//                print("weekly data: ", value)
                if let dictionary = value as? Dictionary<String, AnyObject> {
                    if var list = dictionary["data"] as? [Dictionary<String, AnyObject>] {
                        list.remove(at: 0)  // remove current day
                        print("number of days", list.count)
                        for item in list {
                            let forecast = WeeklyWeatherForecast(weatherDictionary: item)
                            forecastArray.append(forecast)
                        }
                    }
                }
                completion(forecastArray)

            case .failure:
                completion(forecastArray)
                print("No weekly forecast found")
            }
        }
        
    }
    
}
