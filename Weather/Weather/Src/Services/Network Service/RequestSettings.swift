//
//  RequestSettings.swift
//  Weather
//
//  Created by Александр Головин on 25.05.2023.
//

import Foundation

enum Request {
    
    case getGeo(query: String)
    case getWeather(lat: String, lon: String)
}

struct RequestSettings {
    
    static func setupRequest(type: Request) -> URLRequest? {
        
        var request: URLRequest
        
        switch type {
        case let .getGeo(query: query):
            if let url = URL(string: "https://suggestions.dadata.ru/suggestions/api/4_1/rs/suggest/address") {
                request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                request.setValue("application/json", forHTTPHeaderField: "Accept")
                request.setValue("Token b0b15ae1e9349d2aeafcb28a3d491e1501a20408", forHTTPHeaderField: "Authorization")
                let parameters = [
                    "query": query,
                    "count": 5,
                    "from_bound": [ "value": "city" ],
                    "to_bound": [ "value": "city" ]
                ] as [String : Any]
                guard let jsonData = try? JSONSerialization.data(withJSONObject: parameters) else {
                    
                    print("!ОШИБКА СЕТТИНГС ПРИ СОЗДАНИИ БОДИ ЗАПРОСА")
                    
                    return nil
                }
                request.httpBody = jsonData
                return request
            } else {
                return nil
            }
            
        case let .getWeather(lat: lat, lon: lon):
            let baseURLString = "https://api.weather.yandex.ru/v2/forecast"
            var urlComponents = URLComponents(string: baseURLString)
            let parameters = [
                "lat": lat,
                "lon": lon,
                "lang": "ru_RU",
                "limit": "7"
            ]
            urlComponents?.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
            guard let url = urlComponents?.url else {
                print("!ОШИБКА СЕТТИНГС ПРИ СОЗДАНИИ ЮРЛ")
                return nil
            }
            request = URLRequest(url: url)
            request.setValue("e11fbff5-fff6-4ac2-a100-00aa99d02d68", forHTTPHeaderField: "X-Yandex-API-Key")
            request.httpMethod = "GET"
            return request
            
        }
    }
}


