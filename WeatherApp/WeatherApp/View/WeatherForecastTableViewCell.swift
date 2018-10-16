//
//  WeatherForecastTableViewCell.swift
//  WeatherForecast
//
//  Created by Niloy Chakraborty on 15/10/2018.
//  Copyright © 2018 Niloy. All rights reserved.
//

import UIKit

class WeatherForecastTableViewCell: UITableViewCell {
    @IBOutlet weak var currentTemp: UILabel!
    @IBOutlet weak var forecastTime: UILabel!
    @IBOutlet weak var maxTemp: UILabel!
    @IBOutlet weak var minTemp: UILabel!
    @IBOutlet weak var wind: UILabel!
    @IBOutlet weak var himudity: UILabel!
    @IBOutlet weak var weatherDesc: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    func configure(with weatherDisplayItem: ForecastItemsDisplay) {
        currentTemp.text = weatherDisplayItem.temp.currentTemp
        maxTemp.text = weatherDisplayItem.temp.maxTemp
        minTemp.text = weatherDisplayItem.temp.minTemp
        wind.text = weatherDisplayItem.windSpeed
        himudity.text = weatherDisplayItem.humidity
        weatherDesc.text = weatherDisplayItem.weatherDesc
        forecastTime.text = weatherDisplayItem.forecastTimeDisplayString
    }
}
