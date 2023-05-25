//
//  MainPresenterImp.swift
//  Weather
//
//  Created by Александр Головин on 24.05.2023.
//

import Foundation

class MainPresenterImp: MainPresenter {
    
    private weak var view: MainView?
    private let router: MainRouter
    
    init(_ view: MainView,
         _ router: MainRouter) {
        self.view = view
        self.router = router
    }
    
    func getWeather(lat: String, lon: String) {
        RequestManager.request(requestType: .getWeather(lat: lat, lon: lon)) { result in
            switch result {
            case let .success(data):
                do {
                    let decoder = JSONDecoder()
                    let forecast = try decoder.decode(WeatherForecast.self, from: data)
                    
                    let currentTemperature = forecast.fact.temp
                    let currentCondition = forecast.fact.condition
                    let forecastt = forecast.forecasts[1].parts.day.tempMax
                    
                    print("Current Temperature: \(currentTemperature)°C")
                    print("Current Condition: \(currentCondition)")
                    print(forecastt)
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func getGeo(query: String) {
        RequestManager.request(requestType: .getGeo(query: "мос")) { result in
            switch result {
            case let .success(data):
                
                do {
                    let decoder = JSONDecoder()
                    let suggestionsResponse = try decoder.decode(AddressSuggestionsResponse.self, from: data)
                    
                    for suggestion in suggestionsResponse.suggestions {
                        let address = suggestion.value
                        let lat = suggestion.data.geoLat
                        let lon = suggestion.data.geoLon
                        
                        print("Address: \(address)")
                        print("lat: \(lat)")
                        print("lon: \(lon)")
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            case let .failure(error):
                print(error)
            }
        }
    }
}
