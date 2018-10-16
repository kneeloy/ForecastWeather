# ForecastWeather
Forecast 5 day weather from OpenWeatherMap For Dublin location
MVVM  Architecture
Protocol-Oriented Programming for Dependency Injection
Unit Tests

How to build

Clone the repository
$ git clone https://github.com/kneeloy/ForecastWeather.git
Open the workspace in Xcode

open "WeatherApp.xcodeproj"

Compile and run the app in your simulator

Compile and test i.e 'CommanU' to run the unit tests

The API Key is embedded inside Project so no need to change that

The locatin to fetch the weather Data is also gard coaded at he moment in the constant file

Requirements

Xcode 10

iOS 10+

Swift 4.2


Further Iteration Of Work :

Documentation/code commenis need to be included in much more depth

Reading he API key from file system so that anybody can use there API should go first if any thing need to be implemented with more time

Using the Geolocation to get the current location for forecasting is also very much required

UIFonts could have been used if there were more time

More indepth Unit tests need to  be included as currently the tests only cover the ViewModel, The Network layer and json codebale parsing need to be included

The UI is very basic as this version mainly aimed to create one loosely coupled, injectable architecture that can be scalled if need so with out much refactoring.


