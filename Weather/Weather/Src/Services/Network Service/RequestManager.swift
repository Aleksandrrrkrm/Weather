//
//  RequestManager.swift
//  Weather
//
//  Created by Александр Головин on 25.05.2023.
//

import Foundation

struct RequestManager {
    
    static func request(requestType: Request, complition: @escaping (CustomResult) -> Void) {
        
        switch requestType {
            
        case let .getGeo(query: query):
            DispatchQueue.global().async {
                ApiClientImp.shared.execute(requestType: .getGeo(query: query)) { result in
                    switch result {
                    case let .success(str):
                        complition(CustomResult.success(str))
                    case let .failure(error):
                        complition(CustomResult.failure(error))
                    }
                }
            }
            
        case let .getWeather(lat: lat, lon: lon):
            DispatchQueue.global().async {
                ApiClientImp.shared.execute(requestType: .getWeather(lat: lat, lon: lon)) { result in
                    switch result {
                    case let .success(str):
                        complition(CustomResult.success(str))
                    case let .failure(error):
                        complition(CustomResult.failure(error))
                    }
                }
            }
        }
    }
}

