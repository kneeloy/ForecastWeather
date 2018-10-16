//
//  Forecast.swift
//  WeatherForecast
//
//  Created by Niloy Chakraborty on 15/10/2018.
//  Copyright © 2018 Niloy. All rights reserved.
//

import Foundation
public struct Forecast : Codable {
    public var currentDate: Date
    public var date: TimeInterval
    public var forecaseAttributes: Weather
    public var weather: [WeatherDetailInfo]
    public var wind: Wind

    private enum CodingKeys: String, CodingKey {
        case currentDate = "dt_txt"
        case date = "dt"
        case forecaseAttributes = "main"
        case weather
        case wind

    }
}

public struct ForecastList : Codable {
    public var list: [Forecast]
}
