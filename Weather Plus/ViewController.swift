//
//  ViewController.swift
//  Weather Plus
//
//  Created by joe_mac on 01/29/2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        HourlyForecast.downloadDailyForecastWeather { (hourlyForecastArray) in
            for data in hourlyForecastArray {
                print("forecast data: \(data.temp), \(data.date), \(data.weatherIcon)")
            }
        }
    }


}

