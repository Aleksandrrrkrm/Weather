//
//  MainView.swift
//  Weather
//
//  Created by Александр Головин on 24.05.2023.
//

import UIKit

protocol MainView: AnyObject {
    
    func setupCityLabel(_ text: String)
    func setupTempLabel(_ temp: Int)
    func setupDescriptionLabel(_ text: String)
    func setupImage(_ named: String)
    func showLoading()
    func hideLoading()
    func showInternetAlert()
}
