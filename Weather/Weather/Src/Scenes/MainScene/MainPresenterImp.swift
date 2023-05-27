//
//  MainPresenterImp.swift
//  Weather
//
//  Created by Александр Головин on 24.05.2023.
//

import Foundation
import CoreLocation
import CoreData

class MainPresenterImp: NSObject, MainPresenter {
    
    // MARK: - Dependencies
    private weak var view: MainView?
    private let router: MainRouter
    private let coreDataGateway: CoreDataGateway
    
    // MARK: - Properties
    private var isFirstRequest = true
    private var lastAuthorizationStatusCL: CLAuthorizationStatus?
    private var lastLocation: CLLocation?
    
    let locationManager = CLLocationManager()
    let defaultLocation = CLLocation(latitude: 55.751244, longitude: 37.618423)
    
    // MARK: - Init
    init(_ view: MainView,
         _ router: MainRouter,
         _ coreDataGetaway: CoreDataGateway) {
        self.view = view
        self.router = router
        self.coreDataGateway = coreDataGetaway
    }
    
    // MARK: - API method
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
                    
                    self?.saveData(forecast.forecasts)
                    
                    let notificationName = Notification.Name("Forecast")
                    let userInfo: [String: [Forecast]] = ["weather" : forecast.forecasts]
                    NotificationCenter.default.post(name: notificationName, object: nil, userInfo: userInfo)
                    self?.view?.hideLoading()
                } catch {
#if DEBUG
                    print("ошибка getWeather: \(error)")
#endif
                }
            case .failure:
                self?.view?.showInternetAlert()
                let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
                guard let cashe = self?.coreDataGateway.getData(sortDescriptors: [sortDescriptor]) else { return }
                let notificationName = Notification.Name("Forecast")
                let userInfo: [String: [Forecast]] = ["weather" : cashe]
                NotificationCenter.default.post(name: notificationName, object: nil, userInfo: userInfo)
                
            }
        }
    }
    
    // MARK: - Location methods
    func reverseGeocode(location: CLLocation) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if let error = error {
#if DEBUG
                print("ошибка reverseGeocode: \(error.localizedDescription)")
#endif
                return
            }
            if let placemark = placemarks?.first {
                if let city = placemark.locality {
                    self.view?.setupCityLabel("\(city)")
                }
            }
        }
    }
    
    func checkAuthorizationStatus() {
        guard let lastAuthorizationStatusCL else { return }
        let status = locationManager.authorizationStatus
        if status != lastAuthorizationStatusCL {
            self.checkLocationPermision()
        } else {
            guard let lastLocation else { return }
            getWeatherForecast(for: lastLocation)
        }
    }
    
    func checkLocationPermision() {
        view?.showLoading()
        let status = locationManager.authorizationStatus
        if status == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        } else if status == .authorizedWhenInUse || status == .authorizedAlways {
            locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
            locationManager.startUpdatingLocation()
        } else {
            getWeatherForecast(for: defaultLocation)
        }
    }
    
    // MARK: - Core Data methods
    private func saveData(_ data: [Forecast]) {
        if isFirstRequest {
            coreDataGateway.deleteAllData()
            coreDataGateway.saveData(data, completion: nil)
            isFirstRequest = false
        }
    }
    
    // MARK: - Helpers
    private func setDescription(key: String) {
        let weatherDescription = DescriptionTranslate.translate(key: key)
        view?.setupDescriptionLabel(weatherDescription)
        let imageName = DescriptionTranslate.generateImage(text: weatherDescription)
        view?.setupImage(imageName)
    }
    
    func openSearchScene() {
        router.openSearchScene()
    }
    
    @objc func handleNotification(_ notification: Notification) {
        if let userInfo = notification.userInfo {
            if let value = userInfo["NewCity"] as? AddressSuggestion {

                guard let lat = value.data.geoLat,
                      let lon = value.data.geoLon else { return }
                
                guard let doubleLat = Double(lat),
                      let doubleLon = Double(lon) else { return }
                
                let locationLat = CLLocationDegrees(doubleLat)
                let locationLon = CLLocationDegrees(doubleLon)
                
                let location = CLLocation(latitude: locationLat, longitude: locationLon)
                getWeatherForecast(for: location)
            }
        }
    }
    
    func getWeatherForecast(for location: CLLocation) {
        lastLocation = location
        getWeather(lat: "\(location.coordinate.latitude)",
                              lon: "\(location.coordinate.longitude)")
        reverseGeocode(location: location)
    }
}

// MARK: - Location manager delegate extension
extension MainPresenterImp: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        locationManager.stopUpdatingLocation()
        getWeatherForecast(for: location)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
#if DEBUG
                    print("ошибка locationManager: \(error)")
#endif
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        lastAuthorizationStatusCL = status
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        case .denied, .restricted:
            getWeatherForecast(for: defaultLocation)
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        @unknown default:
            break
        }
    }
}

