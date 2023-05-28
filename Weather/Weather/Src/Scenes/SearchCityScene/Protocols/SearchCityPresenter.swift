//
//  SearchCityPresenter.swift
//  Weather
//
//  Created by Александр Головин on 25.05.2023.
//

protocol SearchCityPresenter {
    
    func getGeo(query: String)
    
    func getData() -> [AddressSuggestion]
    
    func searchCity(text: String)
    
    func sendNotification(with data: AddressSuggestion)
}
