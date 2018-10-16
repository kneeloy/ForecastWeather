//
//  MockFailableWeatherDataManager.swift
//  WeatherForecastTests
//
//  Created by Niloy Chakraborty on 16/10/2018.
//  Copyright © 2018 Niloy. All rights reserved.
//

import Foundation
@testable import WeatherApp

class MockFailableWeatherDataManager: WeatherForecasting {
    let error: WeatherAppError
    public func getFiveDayForecast(callback: @escaping (ForecastList?, Error?) -> ()) {

        callback(nil, error)

    }
    init(error: WeatherAppError) {
        self.error = error
    }
}
