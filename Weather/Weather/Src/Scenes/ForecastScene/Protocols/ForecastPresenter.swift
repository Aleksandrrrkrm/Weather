//
//  ForecastPresenter.swift
//  Weather
//
//  Created by Александр Головин on 24.05.2023.
//

import Foundation

protocol ForecastPresenter {
    
    func setData(data: [Forecast])
    
    func getData() -> [Forecast]
    
    func handleNotification(_ notification: Notification)
}
