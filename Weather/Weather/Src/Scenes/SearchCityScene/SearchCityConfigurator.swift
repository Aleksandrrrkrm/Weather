//
//  SearchCityConfigurator.swift
//  Weather
//
//  Created by Александр Головин on 25.05.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
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
