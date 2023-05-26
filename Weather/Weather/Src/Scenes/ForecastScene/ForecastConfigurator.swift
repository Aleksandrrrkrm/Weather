//
//  ForecastConfigurator.swift
//  Weather
//
//  Created by Александр Головин on 24.05.2023.
//

import UIKit

enum ForecastConfigurator {
    
    static func configure(view: ForecastViewController) {
        let router = ForecastRouter(view)
        let presenter = ForecastPresenterImp(view, router)
        view.presenter = presenter
    }
    
    static func open(navigationController: UINavigationController) {
        let view = ForecastViewController()
        Self.configure(view: view)
        navigationController.pushViewController(view, animated: true)
    }
}
