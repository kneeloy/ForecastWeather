//
//  ForecastViewModel.swift
//  WeatherForecast
//
//  Created by Niloy Chakraborty on 15/10/2018.
//  Copyright © 2018 Niloy. All rights reserved.
//

import Foundation
import UIKit

protocol ForecastViewModelProtocol {
    func getforecast(callBack: @escaping (Error?) -> ())
    var weatherDataManager: WeatherForecasting { get }
}

class ForecastViewModel: ForecastViewModelProtocol {

    let weatherDataManager: WeatherForecasting
    var forecastDisplayModelList: [ForecastDisplay] = []
    weak var weatherView: WeatherViewProtocol?

    init(weatherDataManager: WeatherForecasting) {
        self.weatherDataManager = weatherDataManager
    }

    public func getforecast(callBack: @escaping (Error?) -> ()) {
        if (!checkNetworkConnectionIsAvailable()) {
            let error = WeatherAppError.networkError(title: AlertTitleForNetworkError, message: AlertMesageForNetworkError)
            callBack(error)
        } else {
            weatherDataManager.getFiveDayForecast() { [weak self] forecastDataList, error in
                if let error = error {
                    callBack(error)
                } else if let forecastDataList = forecastDataList {
                    self?.forecastDisplayModelList = self?.convertToDisplayModel(forecastList: forecastDataList) ?? []
                        callBack(nil)
                }
            }
        }
    }

    private func convertToDisplayModel(forecastList: ForecastList) -> [ForecastDisplay] {
        return forecastList.list.reduce([ForecastDisplay]()) { arr, forecastDataItem -> [ForecastDisplay] in

            var mutableArr = arr
            //Create the DisplayModel from DataSource Model
            let temp = Tempurature(currentTemp: forecastDataItem.forecaseAttributes.celsius.currentTemp,
                                   minTemp: forecastDataItem.forecaseAttributes.celsius.minTemp,
                                   maxTemp: forecastDataItem.forecaseAttributes.celsius.maxTemp)
            let forecastItemsDisplay = ForecastItemsDisplay(temp: temp,
                                                            windSpeed: forecastDataItem.wind.speed,
                                                            humidity: forecastDataItem.forecaseAttributes.humidity,
                                                            weatherDesc: forecastDataItem.weather.first?.description ?? "N/A", currentDate: forecastDataItem.currentDate)
            let forecastDisplay = ForecastDisplay(currentDate: forecastDataItem.currentDate,
                                                  forecastItems: [forecastItemsDisplay])

            if let forecastDisplayItemIndex = mutableArr.index(where: { $0.currentDateDisplayString == forecastDisplay.currentDateDisplayString }) {
                mutableArr[forecastDisplayItemIndex].forecastItems.append(forecastItemsDisplay)
            } else {
                mutableArr.append(forecastDisplay)
            }
            return mutableArr
        }

    }

    public func refreshWeatherForecast(callBack: @escaping ((Error?) -> ())) {
        getforecast() { error in

            guard let error = error else {
                callBack(nil)
                return
            }
            callBack(error)
        }
    }

    private func checkNetworkConnectionIsAvailable() -> Bool {
        return Reachability.isConnectedToNetwork() ? true : false
    }
}
