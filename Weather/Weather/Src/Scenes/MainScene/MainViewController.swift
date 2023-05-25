//
//  MainViewController.swift
//  Weather
//
//  Created by Александр Головин on 24.05.2023.
//

import UIKit
import CoreLocation

class MainViewController: UIViewController {
    
    internal var presenter: MainPresenter?
    
    let locationManager = CLLocationManager()
    
    var label = UILabel()
       
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MainConfigurator.configure(view: self)
        locationManager.delegate = self
        view.backgroundColor = .red
        checkLocationPermision()
        setupTestLabel()
    }
    
    // MARK: - UIView
    
    private func setupAllView() {
        
    }
    
    private func setupTestLabel() {
        label.text = "ответов нет"
        label.font = UIFont(name: "arial", size: 20)
        label.textColor = .white
        print(label.text)
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    // MARK: - USAGE
    private func checkLocationPermision() {
        let status = locationManager.authorizationStatus
        if status == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        } else if status == .authorizedWhenInUse || status == .authorizedAlways {
            setupTextLabel("разрешение есть")
            print(label.text)
            locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
            locationManager.startUpdatingLocation()
        } else {
            setupTextLabel("разрешения нет")
            print(label.text)
        }
    }
    
    
}

extension MainViewController: MainView {
    
    func setupTextLabel(_ text: String) {
        label.text = text
    }
}
