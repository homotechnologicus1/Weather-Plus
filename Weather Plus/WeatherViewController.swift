//
//  WeatherViewController.swift
//  Weather Plus
//
//  Created by joe_mac on 01/30/2021.
//

import UIKit

class WeatherViewController: UIViewController {
    
    // MARK:- IBOutlets
    @IBOutlet weak var weatherScrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    

    // MARK:- ViewLifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let weatherView = WeatherView()
//        weatherView.frame = CGRect(x: 0, y: 0, width: weatherScrollView.bounds.width, height: weatherScrollView.bounds.height)
        weatherView.frame = weatherScrollView.bounds
        weatherScrollView.addSubview(weatherView)
        
        getCurrentWeather(weatherView: weatherView)
        getWeeklyWeather(weatherView: weatherView)
        getHourlyWeather(weatherView: weatherView)
    }

    // MARK:- Download Weather
    
    private func getCurrentWeather(weatherView: WeatherView) {
        weatherView.currentWeather = CurrentWeather()
        weatherView.currentWeather.getCurrentWeather { (success) in
            weatherView.refreshData()
        }
    }
    
    private func getWeeklyWeather(weatherView: WeatherView) {
        WeeklyWeatherForecast.downloadWeeklyWeatherForecast { (weatherForecasts) in
            weatherView.weeklyWeatherForecastData = weatherForecasts
            weatherView.tableView.reloadData()
        }
    }
    
    private func getHourlyWeather(weatherView: WeatherView) {
        HourlyForecast.downloadHourlyForecastWeather { (weatherForecasts) in
            weatherView.dailyWeatherForecastData = weatherForecasts
            weatherView.hourlyCollectionView.reloadData()
        }
    }
    

}
