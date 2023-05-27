//
//  MainPresenter.swift
//  Weather
//
//  Created by Александр Головин on 24.05.2023.
//

import Foundation
import CoreLocation

protocol MainPresenter {
    
    func getWeather(lat: String, lon: String)
    func reverseGeocode(location: CLLocation)
    func openSearchScene()
    func checkLocationPermision()
    func handleNotification(_ notification: Notification)
}
