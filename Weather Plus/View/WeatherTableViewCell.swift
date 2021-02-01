//
//  WeatherTableViewCell.swift
//  Weather Plus
//
//  Created by joe_mac on 02/01/2021.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    
    // MARK:- IBOutlets
    @IBOutlet weak var dayOfTheWeekLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var weatherIconImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func generateCell(forecast: WeeklyWeatherForecast) {
        dayOfTheWeekLabel.text = forecast.date.dayOfTheWeek()
        weatherIconImageView.image = getWeatherIcon(for: forecast.weatherIcon)
        tempLabel.text = "\(forecast.temp)°"
    }
    
}
