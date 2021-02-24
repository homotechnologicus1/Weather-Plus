//
//  WeatherView.swift
//  Weather Plus
//
//  Created by joe_mac on 01/30/2021.
//

import UIKit

class WeatherView: UIView {
    
    // MARK:- IBOutlets
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weatherInfoLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var bottomContainer: UIView!
    @IBOutlet weak var hourlyCollectionView: UICollectionView!
    @IBOutlet weak var infoCollectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK:- Variables
    var currentWeather: CurrentWeather!
    var weeklyWeatherForecastData: [WeeklyWeatherForecast] = []
    var dailyWeatherForecastData: [HourlyForecast] = []
    var weatherInfoData: [WeatherInfo] = []
    
    // MARK:- INITs
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        mainInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        mainInit()
    }
    
    private func mainInit() {
        Bundle.main.loadNibNamed("WeatherView", owner: self, options: nil)
        mainView.frame = self.bounds
        mainView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        addSubview(mainView)
        
        setupTableView()
        setupHourlyCollectionView()
        setupInfoCollectionView()
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: "WeatherTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "Cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    private func setupHourlyCollectionView() {
        hourlyCollectionView.register(UINib(nibName: "ForecastCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "Cell")
        hourlyCollectionView.dataSource = self
    }
    
    private func setupInfoCollectionView() {
        infoCollectionView.register(UINib(nibName: "InfoCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "Cell")
        infoCollectionView.dataSource = self
    }
    
    func refreshData() {
        setupCurrentWeather()
        setupWeatherInfo()
        infoCollectionView.reloadData()
    }
    
    private func setupCurrentWeather() {
        cityNameLabel.text = currentWeather.city
        dateLabel.text = "Today, \(currentWeather.date.shortDate())"
        tempLabel.text = String(format: "%.0f%@", currentWeather.currentTempo, returnTempFormatFromUserDefaults())
        weatherInfoLabel.text = currentWeather.weatherType
    }
    
    private func setupWeatherInfo() {
        let windInfo = WeatherInfo(infoText: String(format: "%.1fm/sec", currentWeather.windSpeed), nameText: nil, image: getWeatherIcon(for: "wind"))
        let humidity = WeatherInfo(infoText: String(format: "%.0f%%", currentWeather.humidity), nameText: nil, image: getWeatherIcon(for: "humidity"))
        let pressureInfo = WeatherInfo(infoText: String(format: "%.0fmb", currentWeather.pressure), nameText: nil, image: getWeatherIcon(for: "pressure"))
        let visibilityInfo = WeatherInfo(infoText: String(format: "%.0fkm", currentWeather.visibility), nameText: nil, image: getWeatherIcon(for: "visibility"))
        let feelsLike = WeatherInfo(infoText: String(format: "%.1f%@", currentWeather.feelsLike, returnTempFormatFromUserDefaults()), nameText: nil, image: getWeatherIcon(for: "feelsLike"))
        let uvInfo = WeatherInfo(infoText: String(format: "%.1f", currentWeather.uv), nameText: "UV Index", image: nil)
        let sunriseInfo = WeatherInfo(infoText: currentWeather.sunrise, nameText: nil, image: getWeatherIcon(for: "sunrise"))
        let sunsetInfo = WeatherInfo(infoText: currentWeather.sunset, nameText: nil, image: getWeatherIcon(for: "sunset"))
        
        weatherInfoData = [windInfo, humidity, pressureInfo, visibilityInfo, feelsLike, uvInfo, sunriseInfo, sunsetInfo]
    }
    
}

extension WeatherView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weeklyWeatherForecastData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! WeatherTableViewCell
        cell.generateCell(forecast: weeklyWeatherForecastData[indexPath.row])
        return cell
    }
    
    
}

extension WeatherView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == hourlyCollectionView {
            return dailyWeatherForecastData.count
        } else {
            return weatherInfoData.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == hourlyCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ForecastCollectionViewCell
            cell.generateCell(weather: dailyWeatherForecastData[indexPath.row])
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! InfoCollectionViewCell
            cell.generateCell(weatherInfo: weatherInfoData[indexPath.row])
            return cell
        }
    }
    
    
}
