//
//  SearchCityView.swift
//  Weather
//
//  Created by Александр Головин on 25.05.2023.
//

protocol SearchCityView: BaseView {
    
    func reloadTableView()
    
    func hideLoading()
    
    func showInternetAlert()
    
    func showErrorAlert(message: String)
}
