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
        locationManager.stopUpdatingLocation()
        presenter?.getWeather(lat: "\(location.coordinate.latitude)", lon: "\(location.coordinate.longitude)")
        presenter?.reverseGeocode(location: location)
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
