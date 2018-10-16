//
//  WeatherDataManager.swift
//  WeatherForecast
//
//  Created by Niloy Chakraborty on 15/10/2018.
//  Copyright © 2018 Niloy. All rights reserved.
//

import Foundation

protocol WeatherForecasting {
    func getFiveDayForecast(callback: @escaping (ForecastList?, Error?) -> ())
}
class WeatherDataManager: WeatherForecasting {

    let kBaseUrl = "http://api.openweathermap.org/data/2.5"
    private var token: String
    private var city: String
    private lazy var networkManager: NetworkManager =  {
        return NetworkManager()
    }()

    init(city: String, token: String) {
        self.city = city
        self.token = token
    }

    private func buildForecaseRequestString() -> String {

        var serviceUrl = kBaseUrl
        // Add the forecast
        serviceUrl += "/forecast?"
        //Add the city
        serviceUrl += "q=\(city)"
        // Add API Token
        serviceUrl += "&appid=\(token)"
        return serviceUrl
    }

    public func getFiveDayForecast(callback: @escaping (ForecastList?, Error?) -> ()) {

        networkManager.getWeather(from: buildForecaseRequestString()) { [callback] forecastData,err  in

            callback(forecastData, err)
        }
    }
}
