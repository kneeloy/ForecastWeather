//
//  ForecastDisplayModel.swift
//  WeatherForecast
//
//  Created by Niloy Chakraborty on 15/10/2018.
//  Copyright © 2018 Niloy. All rights reserved.
//

import Foundation
public struct ForecastDisplay {
    public var currentDate: Date
    public var currentDateDisplayString: String {
        let calendar = Calendar.current
        let date=calendar.dateComponents([.year,.month,.day], from: currentDate)
        return "\(date.year!):\(date.month!):\(date.day!)"
    }

    public var sectionHeaderCurrentDateDisplayString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d"
        return dateFormatter.string(from: currentDate)

    }
    public var forecastItems: [ForecastItemsDisplay]

    init(currentDate: Date, forecastItems: [ForecastItemsDisplay]) {
        self.currentDate = currentDate
        self.forecastItems = forecastItems
    }
}

public struct Tempurature {
    public var currentTemp: String
    public var minTemp: String
    public var maxTemp: String

    init(currentTemp: Double, minTemp: Double, maxTemp: Double) {
        self.currentTemp = "\(String(format: "%.1f", currentTemp))\(" C")"
        self.minTemp = "\("L: ")\(String(format: "%.1f", minTemp))\(" C")"
        self.maxTemp = "\("H: ")\(String(format: "%.1f", maxTemp))\(" C")"
    }
}

public struct ForecastItemsDisplay {

    //ToDo : Duplicate Date information as ForecastDisplay also contains the date
    // Needs time to revisit to check how this can be further refactpred to use single instance of Date
    public var currentDate: Date
    public var temp: Tempurature
    public var windSpeed: String
    public var humidity: String
    public var weatherDesc: String
    public var forecastTimeDisplayString: String {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h a"
        return dateFormatter.string(from: currentDate)
    }

    init(temp: Tempurature, windSpeed: Float, humidity: Int, weatherDesc: String, currentDate: Date) {
        self.temp = temp
        self.windSpeed = "\("Wind: ")\(String(windSpeed))\(" km/hr")"
        self.humidity = "\("Humidity: ")\(String(humidity))\(" %")"
        self.weatherDesc = weatherDesc
        self.currentDate = currentDate
    }
}
