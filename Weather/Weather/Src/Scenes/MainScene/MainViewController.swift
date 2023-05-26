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
    
    // MARK: - UI Elements
    var searchButton = UIButton()
    var activityIndicator = UIActivityIndicatorView(style: .large)
    
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
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MainConfigurator.configure(view: self)
        locationManager.delegate = self
        let notificationName = Notification.Name("NewCity")
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification(_:)), name: notificationName, object: nil)
        checkLocationPermision()
        setupAllView()
    }
    
    // MARK: - USAGE
    private func checkLocationPermision() {
        showLoading()
        let status = locationManager.authorizationStatus
        if status == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        } else if status == .authorizedWhenInUse || status == .authorizedAlways {
            locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
            locationManager.startUpdatingLocation()
        } else {
        }
    }
    
    @objc func buttonTapped() {
        presenter?.openSearchScene()
    }
    
    @objc func handleNotification(_ notification: Notification) {
        if let userInfo = notification.userInfo {
            if let value = userInfo["NewCity"] as? AddressSuggestion {
                
                guard let lat = value.data.geoLat,
                      let lon = value.data.geoLon else { return }
                
                guard let doubleLat = Double(lat),
                      let doubleLon = Double(lon) else { return }
                
                let locationLat = CLLocationDegrees(doubleLat)
                let locationLon = CLLocationDegrees(doubleLon)
                
                let location = CLLocation(latitude: locationLat, longitude: locationLon)
                presenter?.getWeather(lat: "\(location.coordinate.latitude)", lon: "\(location.coordinate.longitude)")
                presenter?.reverseGeocode(location: location)
            }
        }
    }
}

// MARK: Protocol extension
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
            UIView.transition(with: self.imageView, duration: 0.3, options: .transitionCrossDissolve, animations: {
                self.imageView.image = UIImage(named: named)
            }, completion: nil)
        }
    }
    
    func showLoading() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            self.activityIndicator.isHidden = true
            self.activityIndicator.stopAnimating()
        }
    }
}
