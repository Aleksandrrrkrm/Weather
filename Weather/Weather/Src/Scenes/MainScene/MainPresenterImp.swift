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
        RequestManager.request(requestType: .getWeather(lat: lat, lon: lon)) { [weak self] result in
            switch result {
            case let .success(data):
                do {
                    let decoder = JSONDecoder()
                    let forecast = try decoder.decode(WeatherForecast.self, from: data)
                    
                    let currentTemperature = forecast.fact.temp
                    let currentCondition = forecast.fact.condition
                    let forecastt = forecast.forecasts[1].parts.day.tempMax
                    
                    print("Current Temperature: \(currentTemperature)°C")
                    self?.view?.setupTempLabel(currentTemperature)
                    print("Current Condition: \(currentCondition)")
                    self?.setDescription(key: currentCondition)
                   
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
        RequestManager.request(requestType: .getGeo(query: "rbckjdjlcr")) { [weak self] result in
            switch result {
            case let .success(data):
                
                do {
                    let decoder = JSONDecoder()
                    let suggestionsResponse = try decoder.decode(AddressSuggestionsResponse.self, from: data)
                    
                    print(suggestionsResponse.suggestions.count)
                        let address = suggestionsResponse.suggestions[0].value
                        let lat = suggestionsResponse.suggestions[0].data.geoLat
                        let lon = suggestionsResponse.suggestions[0].data.geoLon
                        
                        print("Address: \(address)")
                        self?.view?.setupCityLabel("\(address)")
                        print("lat: \(lat)")
                        print("lon: \(lon)")
//
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            case let .failure(error):
                print(error)
            }
        }
    }

    private func setDescription(key: String) {
        let weatherDescriptions: [String: String] = [
            "clear": "Ясно",
            "partly-cloudy": "Малооблачно",
            "cloudy": "Облачно с прояснениями",
            "overcast": "Пасмурно",
            "partly-cloudy-and-light-rain": "Малооблачно, небольшой дождь",
            "partly-cloudy-and-rain": "Малооблачно, дождь",
            "overcast-and-rain": "Значительная облачность, сильный дождь",
            "overcast-thunderstorms-with-rain": "Сильный дождь с грозой",
            "cloudy-and-light-rain": "Облачно, небольшой дождь",
            "overcast-and-light-rain": "Значительная облачность, небольшой дождь",
            "cloudy-and-rain": "Облачно, дождь",
            "overcast-and-wet-snow": "Дождь со снегом",
            "partly-cloudy-and-light-snow": "Небольшой снег",
            "partly-cloudy-and-snow": "Малооблачно, снег",
            "overcast-and-snow": "Снегопад",
            "cloudy-and-light-snow": "Облачно, небольшой снег",
            "overcast-and-light-snow": "Значительная облачность, небольшой снег",
            "cloudy-and-snow": "Облачно, снег"
        ]
        let dic = ["sun" : ["Ясно"],
                   "easyCloud" : ["Малооблачно","Облачно с прояснениями"],
                   "hardCloud" : ["Пасмурно","Облачно, небольшой дождь", "Значительная облачность, небольшой дождь"],
                   "rain" : ["Малооблачно, небольшой дождь", "Малооблачно, дождь","Сильный дождь с грозой", "Облачно, дождь", "Значительная облачность, сильный дождь"],
                   "snow" : ["Дождь со снегом","Небольшой снег","Малооблачно, снег","Снегопад","Облачно, небольшой снег","Значительная облачность, небольшой снег","Облачно, снег"]]
        if let weatherDescription = weatherDescriptions[key] {
            view?.setupDescriptionLabel(weatherDescription)
            dic.forEach { key, value in
                if value.contains(weatherDescription) {
                    view?.setupImage(key)
                }
            }
        } else {
            view?.setupDescriptionLabel("У погоды нет плохой погоды! :)")
        }
    }
}
