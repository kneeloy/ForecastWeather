//
//  NetworkManager.swift
//  WeatherForecast
//
//  Created by Niloy Chakraborty on 15/10/2018.
//  Copyright © 2018 Niloy. All rights reserved.
//

import Foundation

protocol NetworkManagerProtocol {
    func getWeather(from url: String,
                    callBackHandler: @escaping (ForecastList?, Error?) -> ())
}
class NetworkManager: NetworkManagerProtocol {

    internal static let instance = NetworkManager()

    init() {}

    internal func getWeather(from url: String,
                             callBackHandler: @escaping (ForecastList?, Error?) -> ()) {
        guard let serviceUrl = URL(string: url) else { return }

        URLSession.shared.dataTask(with: serviceUrl) { (data, response, error) in
            if let error = error {
                let error = WeatherAppError.generalError(title: AlertTitleForGeneralError, message: error.localizedDescription)
                callBackHandler(nil, error)
            }
            guard let data = data else { return }

            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Custom)
            do {
                let result = try decoder.decode(ForecastList.self, from: data)
                callBackHandler(result, nil)
            } catch {
                let error = WeatherAppError.generalError(title: AlertTitleForGeneralError, message: error.localizedDescription)
                callBackHandler(nil, error)
            }
            }.resume()
    }
}
