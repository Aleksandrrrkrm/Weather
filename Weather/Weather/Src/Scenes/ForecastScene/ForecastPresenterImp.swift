//
//  ForecastPresenterImp.swift
//  Weather
//
//  Created by Александр Головин on 24.05.2023.
//

import Foundation

class ForecastPresenterImp: ForecastPresenter {
    
    private weak var view: ForecastView?
    private let router: ForecastRouter
    
    init(_ view: ForecastView,
         _ router: ForecastRouter) {
        self.view = view
        self.router = router
    }
    
}
