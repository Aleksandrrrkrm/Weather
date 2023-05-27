//
//  MainVC+CLLocationManagerDelegate.swift
//  Weather
//
//  Created by Александр Головин on 25.05.2023.
//

import CoreLocation

//extension MainViewController: CLLocationManagerDelegate {
//    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let location = locations.first else {
//            return
//        }
//        locationManager.stopUpdatingLocation()
//        getWeatherForecast(for: location)
//    }
//    
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//#if DEBUG
//                    print("!!!!!ERROR IN MainViewController locationManager: \(error)")
//#endif
//    }
//    
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        switch status {
//        case .authorizedWhenInUse, .authorizedAlways:
//            locationManager.desiredAccuracy = kCLLocationAccuracyBest
//            locationManager.startUpdatingLocation()
//        case .denied, .restricted:
//            getWeatherForecast(for: defaultLocation)
//        case .notDetermined:
//            locationManager.requestWhenInUseAuthorization()
//        @unknown default:
//            break
//        }
//    }
//}
