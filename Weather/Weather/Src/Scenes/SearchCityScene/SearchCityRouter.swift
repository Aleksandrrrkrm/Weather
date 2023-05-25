//
//  SearchCityRouter.swift
//  Weather
//
//  Created by Александр Головин on 25.05.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import UIKit

class SearchCityRouter {
    
    weak var view: UIViewController?
    
    init(_ view: SearchCityViewController) {
        self.view = view
    }
    
    func openSomeScene() {
        guard let navController = self.view?.navigationController else {
            return
        }
        //  SomeSceneConfigurator.open(navigationController: navController)
    }
}
