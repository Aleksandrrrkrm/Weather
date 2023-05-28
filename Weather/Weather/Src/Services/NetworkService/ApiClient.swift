//
//  ApiClient.swift
//  Weather
//
//  Created by Александр Головин on 25.05.2023.
//

import Foundation

final class ApiClientImp {
    
    static let shared = ApiClientImp()
    
    private init () { }
    
    func execute(requestType: Request, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let request = RequestSettings.setupRequest(type: requestType) else {
            return
        }
        let task =  URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data, let _ = response as? HTTPURLResponse
            else {
                return
            }
            completion(.success(data))
        }
        task.resume()
    }
}

