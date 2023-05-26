//
//  ForecastRouter.swift
//  Weather
//
//  Created by Александр Головин on 24.05.2023.
//

import UIKit

class ForecastRouter {
    
    weak var view: UIViewController?
    
    init(_ view: ForecastViewController) {
        self.view = view
    }
    
    //    func openSomeScene() {
    //        guard let navController = self.view?.navigationController else {
    //            return
    //        }
    //    }
}
