//
//  ForecastViewController.swift
//  Weather
//
//  Created by Александр Головин on 24.05.2023.
//

import UIKit

class ForecastViewController: UIViewController {
    
    
    internal var presenter: ForecastPresenter?
    
    // MARK: - UI elements
    var tableView = UITableView()
    var activityIndicator = UIActivityIndicatorView(style: .large)
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        ForecastConfigurator.configure(view: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAllViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        showLoading()
    }

    // MARK: - Methods
    func showLoading() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
}

    // MARK: Protocol extension
extension ForecastViewController: ForecastView {
    
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
}
