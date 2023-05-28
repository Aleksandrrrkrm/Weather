//
//  MainPresenter.swift
//  Weather
//
//  Created by Александр Головин on 24.05.2023.
//

import CoreLocation

protocol MainPresenter {
    
    func reverseGeocode(location: CLLocation)
    
    func openSearchScene()
    
    func checkAuthorizationStatus()
    
    func handleNotification(_ notification: Notification)
}
