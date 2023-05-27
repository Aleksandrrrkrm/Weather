//
//  SearchCityConfigurator.swift
//  Weather
//
//  Created by Александр Головин on 25.05.2023.
//

import UIKit

enum SearchCityConfigurator {
    
    static func configure(view: SearchCityViewController) {
        let presenter = SearchCityPresenterImp(view)
        view.presenter = presenter
    }
    
    static func open(navigationController: UINavigationController) {
        let view = SearchCityViewController()
        Self.configure(view: view)
        navigationController.present(view, animated: true)
    }
}
