//
//  MainPresenterImp.swift
//  Weather
//
//  Created by Александр Головин on 24.05.2023.
//

import Foundation
import CoreLocation
import CoreData

class MainPresenterImp: MainPresenter {
    
    private weak var view: MainView?
    private let router: MainRouter
    private let coreDataGateway: CoreDataGateway
    
    init(_ view: MainView,
         _ router: MainRouter,
         _ coreDataGetaway: CoreDataGateway) {
        self.view = view
        self.router = router
        self.coreDataGateway = coreDataGetaway
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
                    
                    self?.view?.setupTempLabel(currentTemperature)
                    self?.setDescription(key: currentCondition)
                    
                    self?.coreDataGateway.deleteAllNews()
                    self?.coreDataGateway.saveNews(forecast.forecasts, completion: nil)
                    
                    let notificationName = Notification.Name("Forecast")
                    let userInfo: [String: [Forecast]] = ["weather" : forecast.forecasts]
                    NotificationCenter.default.post(name: notificationName, object: nil, userInfo: userInfo)
                    self?.view?.hideLoading()
                } catch {
                    print("JSON ERROR IN getWeather: \(error)")
                }
            case let .failure(error):
                print(error)
                self?.view?.showInternetAlert()
                let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
                guard let cashe = self?.coreDataGateway.getNews(sortDescriptors: [sortDescriptor]) else { return }
                let notificationName = Notification.Name("Forecast")
                let userInfo: [String: [Forecast]] = ["weather" : cashe]
                NotificationCenter.default.post(name: notificationName, object: nil, userInfo: userInfo)
                
            }
        }
    }
    
    func reverseGeocode(location: CLLocation) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if let error = error {
                print("Ошибка обратного геокодирования: \(error.localizedDescription)")
                return
            }
            if let placemark = placemarks?.first {
                if let city = placemark.locality {
                    self.view?.setupCityLabel("\(city)")
                }
            }
        }
    }
    
    private func setDescription(key: String) {
        let weatherDescription = DescriptionTranslate.translate(key: key)
        view?.setupDescriptionLabel(weatherDescription)
        let imageName = DescriptionTranslate.generateImage(text: weatherDescription)
        view?.setupImage(imageName)
    }
    
    func openSearchScene() {
        router.openSearchScene()
    }
}

