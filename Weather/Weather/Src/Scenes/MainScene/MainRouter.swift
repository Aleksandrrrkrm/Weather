//
//  MainRouter.swift
//  Weather
//
//  Created by Александр Головин on 24.05.2023.
//

import UIKit

class MainRouter {
    
    weak var view: UIViewController?
    
    init(_ view: MainViewController) {
        self.view = view
    }
    
    func openSomeScene() {
        guard let navController = self.view?.navigationController else {
            return
        }
        //  SomeSceneConfigurator.open(navigationController: navController)
    }
}
