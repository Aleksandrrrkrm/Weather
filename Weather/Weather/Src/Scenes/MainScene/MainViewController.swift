//
//  MainViewController.swift
//  Weather
//
//  Created by Александр Головин on 24.05.2023.
//

import UIKit

class MainViewController: UIViewController {
    
    internal var presenter: MainPresenter?
    
    // MARK: - UI Elements
    var activityIndicator = UIActivityIndicatorView(style: .large)
    
    var cityLabel = UILabel()
        .alignment(.center)
        .setManyLines()
        .color(UIColor.white)
        .font(UIFont(name: Fonts.montserratBold.rawValue, size: 30) ?? UIFont())
    
    var tempLabel = UILabel()
        .color(UIColor.white)
        .font(UIFont(name: Fonts.montserratSemiBold.rawValue, size: 80) ?? UIFont())
    
    var descriptionLabel = UILabel()
        .color(UIColor.white)
        .font(UIFont(name: Fonts.montserratMedium.rawValue, size: 20) ?? UIFont())
    
    var imageView = UIImageView()
    
    // MARK: - Life cycle
    override func loadView() {
        super.loadView()
        
        MainConfigurator.configure(view: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAllView()
        showLoading()
    }
    
    // MARK: - USAGE
    @objc func buttonTapped() {
        presenter?.openSearchScene()
    }
}

// MARK: Protocol extension
extension MainViewController: MainView {
    
    func setupCityLabel(_ text: String) {
        performInMainThread {
            self.cityLabel.text = text
        }
    }
    
    func setupTempLabel(_ temp: Int) {
        performInMainThread {
            self.tempLabel.text = "\(temp)°"
        }
    }
    
    func setupDescriptionLabel(_ text: String) {
        performInMainThread {
            self.descriptionLabel.text = text
        }
    }
    
    func setupImage(_ named: String) {
        performInMainThread {
            UIView.transition(with: self.imageView, duration: 0.3, options: .transitionCrossDissolve, animations: {
                self.imageView.image = UIImage(named: named)
            }, completion: nil)
        }
    }
    
    func showLoading() {
        performInMainThread {
            self.activityIndicator.isHidden = false
            self.activityIndicator.startAnimating()
        }
    }
    
    func hideLoading() {
        performInMainThread {
            self.activityIndicator.isHidden = true
            self.activityIndicator.stopAnimating()
        }
    }
    
    func showInternetAlert() {
        hideLoading()
        performInMainThread {
            self.showAlert(withTitle: Strings.weatherInfoNotAvailable.rawValue,
                           message: Strings.checkInternetConnection.rawValue,
                           actionTitle: Strings.settings.rawValue,
                           viewController: self) {
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    if UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                }
            }
        }
    }
    
    func showErrorAlert(message: String) {
        performInMainThread {
            self.showAlert(withTitle: Strings.errorTitle.rawValue,
                           message: message,
                           actionTitle: nil,
                           viewController: self)
        }
    }
}
