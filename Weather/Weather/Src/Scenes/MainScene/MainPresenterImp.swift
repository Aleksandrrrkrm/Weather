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
    private var isFirstLocation = true
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
    private func getWeather(lat: String, lon: String) {
        RequestManager.request(requestType: .getWeather(lat: lat, lon: lon)) { [weak self] (result: Result<WeatherForecast, Error>) in
            switch result {
            case let .success(data):
                let currentTemperature = data.fact.temp
                let currentCondition = data.fact.condition
                
                self?.view?.setupTempLabel(currentTemperature)
                self?.setDescription(key: currentCondition)
                self?.saveData(data.forecasts)
                self?.sendNotification(with: data.forecasts)
                self?.view?.hideLoading()
            case let .failure(error):
                self?.view?.showErrorAlert(message: error.localizedDescription)
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
                    if self.isFirstLocation {
                        UserDefaults.standard.removeObject(forKey: "City")
                        UserDefaults.standard.set(city, forKey: "City")
                        self.isFirstLocation = false
                    }
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
            getCityFromCache()
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
    
    private func getWeatherForecast(for location: CLLocation) {
        lastLocation = location
        if InternetConnection.checkInternetConnection() {
            getWeather(lat: "\(location.coordinate.latitude)",
                       lon: "\(location.coordinate.longitude)")
            reverseGeocode(location: location)
        } else {
            getCityFromCache()
            view?.showInternetAlert()
            sendNotification()
        }
    }
    
    private func sendNotification(with data: [Forecast]? = nil) {
        guard let data else {
            let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
            guard let data = self.coreDataGateway.getData(sortDescriptors: [sortDescriptor]) else { return }
            let notificationName = Notification.Name("Forecast")
            let userInfo: [String: [Forecast]] = [NotificationName.userInfoKey.rawValue : data]
            NotificationCenter.default.post(name: notificationName, object: nil, userInfo: userInfo)
            return
        }
        let notificationName = Notification.Name("Forecast")
        let userInfo: [String: [Forecast]] = [NotificationName.userInfoKey.rawValue : data]
        NotificationCenter.default.post(name: notificationName, object: nil, userInfo: userInfo)
    }
    
    private func getCityFromCache() {
        if let city = UserDefaults.standard.string(forKey: "City") {
            self.view?.setupCityLabel(city)
        }
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
    
    func openSearchScene() {
        router.openSearchScene()
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

