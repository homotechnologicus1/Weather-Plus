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
        
        WeeklyWeatherForecast.downloadWeeklyWeatherForecast { (weeklyArray) in
            for forecast in weeklyArray {
                print("forecast info: \(forecast.date), \(forecast.temp), \(forecast.weatherIcon)")
            }
        }
    }


}

