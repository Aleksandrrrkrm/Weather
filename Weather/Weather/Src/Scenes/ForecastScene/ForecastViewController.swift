//
//  ForecastViewController.swift
//  Weather
//
//  Created by Александр Головин on 24.05.2023.
//

import UIKit

class ForecastViewController: UIViewController {
    
    internal var presenter: ForecastPresenter?
    
    var tableView = UITableView()
    var activityIndicator = UIActivityIndicatorView(style: .large)
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        ForecastConfigurator.configure(view: self)
//        let notificationName = Notification.Name("Forecast")
//        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification(_:)), name: notificationName, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.color = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ForecastTableViewCell.self, forCellReuseIdentifier: "cell")
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Недельный прогноз"
        
        view.backgroundColor = UIColor(named: "appBlue")
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        showLoading()
        tableView.reloadData()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.backgroundColor = UIColor(named: "appBlue")
        tableView.backgroundView = activityIndicator
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            
        ])
    }
    
//    @objc func handleNotification(_ notification: Notification) {
//        if let userInfo = notification.userInfo {
//            if let value = userInfo["weather"] as? [Forecast] {
//                presenter?.setData(data: value)
//                reloadTableView()
//                hideLoading()
//            }
//        }
//    }
    
    func showLoading() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
}

extension ForecastViewController: ForecastView {
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            self.activityIndicator.isHidden = true
            self.activityIndicator.stopAnimating()
        }
    }
}
