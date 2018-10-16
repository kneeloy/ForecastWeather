//
//  WeatherForecastTests.swift
//  WeatherForecastTests
//
//  Created by Niloy Chakraborty on 15/10/2018.
//  Copyright © 2018 Niloy. All rights reserved.
//

import XCTest
@testable import WeatherForecast

class ForecastViewModelTests: XCTestCase {

    var viewModel: ForecastViewModel!
    let currentTemp: Double = 10.0
    let currentTempInCelsiusDisplayStr = "-263.1 C" //Celsius equivalent of 10Kel

    override func setUp() {

        let wind = Wind(speed: 10.0, deg: 12.0)
        let weatherInfo = Weather(currentTemp: currentTemp, maxTemp: 6.0, minTemp: 12.0)
        let weatherDetailInfo = WeatherDetailInfo(id: 10, condition: "Test Weather", description: "Test Weather Condition", icon: "TestIcon")
        let forecast = Forecast(currentDate: Date(), date: Date().timeIntervalSinceNow, forecaseAttributes: weatherInfo, weather: [weatherDetailInfo], wind: wind)
        let forecastList = ForecastList(list: [forecast])

        let weatherDataManager = MockWeatherDataManager(with: forecastList)
        viewModel =  ForecastViewModel(weatherDataManager: weatherDataManager)
    }

    override func tearDown() {
        super.tearDown()
        viewModel = nil
    }

    // The aim of this test is to confirm that the ViewModel can be created the DisplayModel given the network
    // Layer has been provided the data.
    //This test is not enough to confirm the testability of network layer
    // Network Layer and json codable transformation layer also need to be tested get a good code coverage
    func testDisplayModelCanBeCreatedFromDataSourceModel() {

        viewModel.getforecast(){ [weak self] error in
            guard let self = self else {
                XCTFail("Error")
                return
            }
            XCTAssertEqual(self.viewModel.forecastDisplayModelList.count, 1)
            XCTAssertEqual(self.viewModel.forecastDisplayModelList[0].forecastItems[0].temp.currentTemp, self.currentTempInCelsiusDisplayStr)
        }
    }

    func testErrorCanBeHandled() {
        
    }
}
