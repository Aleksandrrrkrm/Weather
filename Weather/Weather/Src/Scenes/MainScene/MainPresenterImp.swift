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
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Weather")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var context: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()
    
    
    init(_ view: MainView,
         _ router: MainRouter) {
        self.view = view
        self.router = router
    }
    
    func getWeather(lat: String, lon: String) {
        let fetchRequest: NSFetchRequest<Weather> = Weather.fetchRequest()
        let objects = try? context.fetch(fetchRequest)
        print(objects?[0].date)
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
                    
                    forecast.forecasts.forEach { data in
                        let person = Weather(context: self?.context ?? NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType))
                        person.date = data.date
                        person.tempMin = String(data.parts.day.tempMin)
                        person.tempMax = String(data.parts.day.tempMax)
                        person.forecast = data.parts.day.condition
                        self?.saveContext()
                    }
                    
                    let notificationName = Notification.Name("Forecast")
                    let userInfo: [String: [Forecast]] = ["weather" : forecast.forecasts]
                    NotificationCenter.default.post(name: notificationName, object: nil, userInfo: userInfo)
                    self?.view?.hideLoading()
                } catch {
                    print("JSON ERROR IN getWeather: \(error)")
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                context.rollback()
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
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

