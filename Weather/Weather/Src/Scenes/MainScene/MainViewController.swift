//
//  MainViewController.swift
//  Weather
//
//  Created by Александр Головин on 24.05.2023.
//

import UIKit

class MainViewController: UIViewController {
    
    internal var presenter: MainPresenter?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
}

extension MainViewController: MainView {
    
}
