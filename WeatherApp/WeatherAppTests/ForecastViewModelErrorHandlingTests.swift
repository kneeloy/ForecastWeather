//
//  ForecastViewModelErrorhandlingTest.swift
//  WeatherForecastTests
//
//  Created by Niloy Chakraborty on 16/10/2018.
//  Copyright © 2018 Niloy. All rights reserved.
//

import XCTest
@testable import WeatherForecast

class ForecastViewModelErrorHandlingTests: XCTestCase {

    var viewModel: ForecastViewModel!
    var forecastError: WeatherAppError!
    let message = "Test Message"

    override func setUp() {
        let title = "Test Title"

        forecastError = WeatherAppError.generalError(title: title, message: message)
        let weatherDataManager = MockFailableWeatherDataManager(error: forecastError)
        viewModel =  ForecastViewModel(weatherDataManager: weatherDataManager)
    }

    override func tearDown() {
        super.tearDown()
        viewModel = nil
    }

    func testErrorDuringFetchingWeatherCanBeHandled() {

        viewModel.getforecast(){ [weak self] error in
            guard let self = self, let error = error as? WeatherAppError else {
                XCTFail("Error")
                return
            }

            switch error {
            case .generalError(_, let message):
                XCTAssertEqual(message, self.message)
                break
            case .networkError(_, let message):
                XCTFail("Error")
                break
            }
        }
    }
}
