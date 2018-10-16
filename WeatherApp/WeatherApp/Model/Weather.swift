//
//  Weather.swift
//  WeatherForecast
//
//  Created by Niloy Chakraborty on 15/10/2018.
//  Copyright © 2018 Niloy. All rights reserved.
//

import Foundation
public struct Weather : Codable {

    let kKelvinToCelsiusRef = 273.15
    //Temperature values in Kelvin
    public var kelvin: (currentTemp: Double, maxTemp: Double, minTemp: Double) {
        get {
            return (temp, maxTemp, minTemp)
        }
    }

    ///Temperature values in Celsius
    public var celsius: (currentTemp: Double, maxTemp: Double, minTemp: Double) {
        get {
            return (toCelsius(kelvin: temp), toCelsius(kelvin: maxTemp), toCelsius(kelvin: minTemp))
        }
    }

    public var pressure: Double
    public var humidity: Int

    var temp: Double
    var minTemp: Double
    var maxTemp: Double

    init(currentTemp: Double, maxTemp: Double, minTemp: Double) {
        self.temp = currentTemp
        self.maxTemp = maxTemp
        self.minTemp = minTemp

        self.pressure = 0.0
        self.humidity = 0
    }

    enum CodingKeys : String, CodingKey {
        case temp = "temp"
        case minTemp = "temp_min"
        case maxTemp = "temp_max"
        case pressure = "pressure"
        case humidity = "humidity"
    }

    func toCelsius(kelvin: Double) -> Double {
        return kelvin - kKelvinToCelsiusRef
    }
}
