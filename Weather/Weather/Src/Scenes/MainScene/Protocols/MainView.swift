//
//  MainView.swift
//  Weather
//
//  Created by Александр Головин on 24.05.2023.
//

import UIKit

protocol MainView: BaseView {
    
    func setupDescriptionLabel(_ text: String)
    
    func setupCityLabel(_ text: String)
    
    func setupTempLabel(_ temp: Int)
    
    func setupImage(_ named: String)
    
    func showInternetAlert()
    
    func showErrorAlert(message: String)
    
    func showLoading()
    
    func hideLoading()
}
