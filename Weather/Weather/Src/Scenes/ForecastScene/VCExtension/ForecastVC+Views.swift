//
//  ForecastVC+Views.swift
//  Weather
//
//  Created by Александр Головин on 28.05.2023.
//

import UIKit

extension ForecastViewController {
    
    func setupAllViews() {
        view.backgroundColor = UIColor(named: Colors.appBlue.rawValue)
        activityIndicator.color = .white
        configureNavBar()
        setupTableView()
    }
    
    private func configureNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = Strings.weekForecast.rawValue
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ForecastTableViewCell.self, forCellReuseIdentifier: CellsId.forecastCell.rawValue)
        tableView.backgroundView = activityIndicator
        view.addSubview(tableView)
        tableView.backgroundColor = UIColor(named: Colors.appBlue.rawValue)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            
        ])
    }
    
    
}
