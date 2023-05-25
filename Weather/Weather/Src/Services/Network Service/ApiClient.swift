//
//  ApiClient.swift
//  Weather
//
//  Created by Александр Головин on 25.05.2023.
//

import Foundation

enum CustomResult {
    case success(Data)
    case failure(String)
}

final class ApiClientImp {
    
    static let shared = ApiClientImp()
    
    private init () { }
    
    func execute(requestType: Request, complition: @escaping (CustomResult) -> Void) {
        guard let request = RequestSettings.setupRequest(type: requestType) else {
            return
        }
        let task =  URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                complition(.failure("Error sending POST request: \(error.localizedDescription)"))
                return
            }
            guard let data = data, let _ = response as? HTTPURLResponse
            else {
                complition(.failure("Invalid response from POST request"))
                return
            }
                complition(.success(data))
        }
        task.resume()
    }
}

