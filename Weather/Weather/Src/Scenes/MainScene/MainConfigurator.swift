//
//  MainConfigurator.swift
//  Weather
//
//  Created by Александр Головин on 24.05.2023.
//

import UIKit

enum MainConfigurator {
    
    static func configure(view: MainViewController) {
        let router = MainRouter(view)
        let presenter = MainPresenterImp(view,
                                         router,
                                         CoreDataGatewayImp(coreDataStack: CoreStack.shared))
        view.presenter = presenter
        presenter.locationManager.delegate = presenter
        let notificationName = Notification.Name("NewCity")
        NotificationCenter.default.addObserver(presenter, selector: #selector(presenter.handleNotification(_:)), name: notificationName, object: nil)
    }
    
    static func open(navigationController: UINavigationController) {
        let view = MainViewController()
        Self.configure(view: view)
        navigationController.pushViewController(view, animated: true)
    }
}
