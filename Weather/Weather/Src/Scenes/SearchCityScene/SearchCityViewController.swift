//
//  SearchCityViewController.swift
//  Weather
//
//  Created by Александр Головин on 25.05.2023.
//

import UIKit

class SearchCityViewController: UIViewController {
    
    internal var presenter: SearchCityPresenter?
    
    // MARK: - UI elements
    var searchBar = UISearchBar()
    var tableView = UITableView()
    var activityIndicator = UIActivityIndicatorView(style: .medium)
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAllViews()
    }

    // MARK: - Methods
    func closeScene() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.dismiss(animated: true)
        }
    }
    
    func showLoading() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
}

// MARK: - Protocol extension
extension SearchCityViewController: SearchCityView {
    
    func reloadTableView() {
        performInMainThread {
            self.tableView.reloadData()
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
