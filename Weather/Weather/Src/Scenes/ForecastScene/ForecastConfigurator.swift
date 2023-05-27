//
//  ForecastConfigurator.swift
//  Weather
//
//  Created by Александр Головин on 24.05.2023.
//

import UIKit

enum ForecastConfigurator {
    
    static func configure(view: ForecastViewController) {
        let presenter = ForecastPresenterImp(view)
        view.presenter = presenter
        let notificationName = Notification.Name("Forecast")
        NotificationCenter.default.addObserver(presenter, selector: #selector(presenter.handleNotification(_:)), name: notificationName, object: nil)
    }
    
    static func open(navigationController: UINavigationController) {
        let view = ForecastViewController()
        Self.configure(view: view)
        navigationController.pushViewController(view, animated: true)
    }
}
