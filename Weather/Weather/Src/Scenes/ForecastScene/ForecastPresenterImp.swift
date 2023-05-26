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
    
    private var data: [Forecast] = []
    
    init(_ view: ForecastView,
         _ router: ForecastRouter) {
        self.view = view
        self.router = router
    }
    
    func setData(data: [Forecast]) {
        self.data = data
    }
    
    func getData() -> [Forecast] {
        data
    }
}
