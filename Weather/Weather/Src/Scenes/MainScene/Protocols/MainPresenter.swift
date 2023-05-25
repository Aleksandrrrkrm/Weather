//
//  MainPresenter.swift
//  Weather
//
//  Created by Александр Головин on 24.05.2023.
//

import Foundation

protocol MainPresenter {
    
    func getWeather(lat: String, lon: String)
    func getGeo(query: String)
}
