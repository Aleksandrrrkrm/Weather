//
//  ForecastViewController.swift
//  Weather
//
//  Created by Александр Головин on 24.05.2023.
//

import UIKit

class ForecastViewController: UIViewController {
    
    internal var presenter: ForecastPresenter?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ForecastConfigurator.configure(view: self)
        view.backgroundColor = .blue
    }
}

extension ForecastViewController: ForecastView {
    
}
