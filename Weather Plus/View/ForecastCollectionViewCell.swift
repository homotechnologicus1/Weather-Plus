//
//  ForecastCollectionViewCell.swift
//  Weather Plus
//
//  Created by joe_mac on 01/31/2021.
//

import UIKit

class ForecastCollectionViewCell: UICollectionViewCell {
    
    // MARK:- IBOutlets
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var weatherIconImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func generateCell(weather: HourlyForecast) {
        timeLabel.text = weather.date.time()
        weatherIconImageView.image = getWeatherIcon(for: weather.weatherIcon)
        tempLabel.text = "\(weather.temp)°"
    }

}
