//
//  ForecastPresenterImp.swift
//  Weather
//
//  Created by Александр Головин on 24.05.2023.
//

import Foundation

class ForecastPresenterImp: ForecastPresenter {
    
    private weak var view: ForecastView?
    
    private var data: [Forecast] = []
    
    init(_ view: ForecastView) {
        self.view = view
    }
    
    func setData(data: [Forecast]) {
        self.data = data
    }
    
    func getData() -> [Forecast] {
        data
    }
    
    @objc func handleNotification(_ notification: Notification) {
        if let userInfo = notification.userInfo {
            if let value = userInfo["weather"] as? [Forecast] {
                setData(data: value)
                view?.reloadTableView()
                view?.hideLoading()
            }
        }
    }
}
