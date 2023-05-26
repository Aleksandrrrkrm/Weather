//
//  SearchCityPresenter.swift
//  Weather
//
//  Created by Александр Головин on 25.05.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import Foundation

protocol SearchCityPresenter {
    
    func getGeo(query: String)
    func getCount() -> Int
    func getData() -> [AddressSuggestion]
}