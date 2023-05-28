//
//  ForecastView.swift
//  Weather
//
//  Created by Александр Головин on 24.05.2023.
//

protocol ForecastView: BaseView {
    
    func reloadTableView()
    
    func hideLoading()
}
