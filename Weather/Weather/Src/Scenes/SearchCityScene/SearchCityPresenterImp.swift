//
//  SearchCityPresenterImp.swift
//  Weather
//
//  Created by Александр Головин on 25.05.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import Foundation

class SearchCityPresenterImp: SearchCityPresenter {
    
    private weak var view: SearchCityView?
    private let router: SearchCityRouter
    
    init(_ view: SearchCityView,
         _ router: SearchCityRouter) {
        self.view = view
        self.router = router
    }
    
}
