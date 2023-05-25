//
//  WeatherModel.swift
//  Weather
//
//  Created by Александр Головин on 25.05.2023.
//

import Foundation

struct WeatherForecast: Codable {
    let fact: Fact
    let forecasts: [Forecast]
}

struct Fact: Codable {
    let temp: Int
    let condition: String
}

struct Forecast: Codable {
    let date: String
    let parts: Part
}

struct Part: Codable {
    let day: Day
}

struct Day: Codable {
    let tempMin: Int
    let tempMax: Int
    let condition: String
    
    enum CodingKeys: String, CodingKey {
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case condition
    }
}
