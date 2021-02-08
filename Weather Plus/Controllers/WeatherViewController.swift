//
//  WeatherViewController.swift
//  Weather Plus
//
//  Created by joe_mac on 01/30/2021.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    
    // MARK:- IBOutlets
    @IBOutlet weak var weatherScrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var weatherLocation: WeatherLocation!
    
    // MARK: - Variables
    let userDefaults = UserDefaults.standard
    
    var locationManager: CLLocationManager?
    var currentLocation: CLLocationCoordinate2D!
    
    var allLocations: [WeatherLocation] = []
    var allWeatherView: [WeatherView] = []
    var allWeatherData: [CityTempData] = []

    // MARK:- ViewLifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManagerStart()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        locationAuthCheck()
        
        /*
        let weatherView = WeatherView()
//        weatherView.frame = CGRect(x: 0, y: 0, width: weatherScrollView.bounds.width, height: weatherScrollView.bounds.height)
        weatherView.frame = weatherScrollView.bounds
        weatherScrollView.addSubview(weatherView)
        
        weatherLocation = WeatherLocation(city: "Nicosia", country: "Cyprus", countryCode: "CY", isCurrentLocation: false)
        
        getCurrentWeather(weatherView: weatherView)
        getWeeklyWeather(weatherView: weatherView)
        getHourlyWeather(weatherView: weatherView)  */
    }

    // MARK:- Download Weather
    
    private func getWeather() {
        loadLocationsFromUserDefaults()
        print("We have \(allLocations.count) locations.")
    }
    
    private func getCurrentWeather(weatherView: WeatherView) {
        weatherView.currentWeather = CurrentWeather()
        weatherView.currentWeather.getCurrentWeather(location: weatherLocation) { (success) in
            weatherView.refreshData()
        }
    }
    
    private func getWeeklyWeather(weatherView: WeatherView) {
        WeeklyWeatherForecast.downloadWeeklyWeatherForecast(location: weatherLocation) { (weatherForecasts) in
            weatherView.weeklyWeatherForecastData = weatherForecasts
            weatherView.tableView.reloadData()
        }
    }
    
    private func getHourlyWeather(weatherView: WeatherView) {
        HourlyForecast.downloadHourlyForecastWeather(location: weatherLocation) { (weatherForecasts) in
            weatherView.dailyWeatherForecastData = weatherForecasts
            weatherView.hourlyCollectionView.reloadData()
        }
    }
    
    // MARK: - LoadLocations from User Defaults
    private func loadLocationsFromUserDefaults() {
        let currentLocation = WeatherLocation(city: "", country: "", countryCode: "", isCurrentLocation: true)
        if let data = userDefaults.value(forKey: "Locations") as? Data {
            allLocations = try! PropertyListDecoder().decode(Array<WeatherLocation>.self, from: data)
            allLocations.insert(currentLocation, at: 0)
        } else {
            print("No user data in user defaults.")
            allLocations.append(currentLocation)
        }
    }
    
    // MARK: - Location Manager
    private func locationManagerStart() {
        if locationManager == nil {
            locationManager = CLLocationManager()
            locationManager!.desiredAccuracy = kCLLocationAccuracyBest
            locationManager!.requestWhenInUseAuthorization()
            locationManager!.delegate = self
        }
        locationManager!.startMonitoringSignificantLocationChanges()
    }
    
    private func locationManagerStop() {
        if locationManager != nil {
            locationManager!.stopMonitoringSignificantLocationChanges()
        }
    }
    
    private func locationAuthCheck() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentLocation = locationManager!.location?.coordinate
            if currentLocation != nil {
                // set our coordinates
                LocationService.shared.latitude = currentLocation.latitude
                LocationService.shared.longitude = currentLocation.longitude
                getWeather()
            } else {
                locationAuthCheck()
            }
        } else {
            locationManager?.requestWhenInUseAuthorization()
            locationAuthCheck()
        }
    }

}

extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get location, \(error.localizedDescription)")
    }
}