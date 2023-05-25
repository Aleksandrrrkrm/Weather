//
//  MainVC+CLLocationManagerDelegate.swift
//  Weather
//
//  Created by Александр Головин on 25.05.2023.
//

import CoreLocation

extension MainViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        print("Latitude: \(location.coordinate.latitude), Longitude: \(location.coordinate.longitude)")
        locationManager.stopUpdatingLocation()
        setupTextLabel("локация есть - \(location.coordinate.latitude)")
        print(label.text)
        presenter?.getWeather(lat: "47.2313", lon: "39.7233")
        presenter?.getGeo(query: "")
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location error: \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse:
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        case .denied:
            break
        case .restricted:
            break
        case .notDetermined:
            break
        case .authorizedAlways:
            locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
            locationManager.startUpdatingLocation()
        @unknown default:
            break
        }
    }
}
