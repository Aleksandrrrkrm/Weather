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
    
    var searchButton = UIButton()
    
    var cityLabel = UILabel()
        .alignment(.center)
        .setManyLines()
        .color(UIColor.white)
        .font(UIFont(name: "Montserrat-Bold", size: 30) ?? UIFont())
    
    var tempLabel = UILabel()
        .color(UIColor.white)
        .font(UIFont(name: "Montserrat-SemiBold", size: 40) ?? UIFont())
       
    var descriptionLabel = UILabel()
        .color(UIColor.white)
        .font(UIFont(name: "Montserrat-Medium", size: 20) ?? UIFont())
    
    var imageView = UIImageView()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MainConfigurator.configure(view: self)
        locationManager.delegate = self
        view.backgroundColor = .blue
        checkLocationPermision()
        setupAllView()
    }
    
    // MARK: - USAGE
    private func checkLocationPermision() {
        let status = locationManager.authorizationStatus
        if status == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        } else if status == .authorizedWhenInUse || status == .authorizedAlways {
            setupCityLabel("разрешение есть")
            print(cityLabel.text)
            locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
            locationManager.startUpdatingLocation()
        } else {
            setupCityLabel("разрешения нет")
            print(cityLabel.text)
        }
    }
    
    @objc func buttonTapped() {
        // Обработка нажатия кнопки
        print("Кнопка была нажата")
    }
}

extension MainViewController: MainView {
    
    func setupCityLabel(_ text: String) {
        DispatchQueue.main.async {
            self.cityLabel.text = text
        }
    }
    
    func setupTempLabel(_ temp: Int) {
        DispatchQueue.main.async {
            self.tempLabel.text = "\(temp) °C"
        }
    }
    
    func setupDescriptionLabel(_ text: String) {
        DispatchQueue.main.async {
            self.descriptionLabel.text = text
        }
    }
    
    func setupImage(_ named: String) {
        DispatchQueue.main.async {
            self.imageView.image = UIImage(named: named)
        }
    }
}
