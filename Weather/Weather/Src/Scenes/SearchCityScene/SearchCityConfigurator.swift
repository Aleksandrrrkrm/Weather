//
//  SearchCityConfigurator.swift
//  Weather
//
//  Created by Александр Головин on 25.05.2023.
//

import UIKit

enum SearchCityConfigurator {
    
    static func configure(view: SearchCityViewController) {
        let router = SearchCityRouter(view)
        let presenter = SearchCityPresenterImp(view, router)
        view.presenter = presenter
    }
    
    static func open(navigationController: UINavigationController) {
        let view = SearchCityViewController()
        Self.configure(view: view)
        navigationController.present(view, animated: true)
    }
}
