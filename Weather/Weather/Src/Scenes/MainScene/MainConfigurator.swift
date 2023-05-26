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
        let presenter = MainPresenterImp(view, router)
        view.presenter = presenter
    }
    
    static func open(navigationController: UINavigationController) {
        let view = MainViewController()
        Self.configure(view: view)
        navigationController.pushViewController(view, animated: true)
    }
}
