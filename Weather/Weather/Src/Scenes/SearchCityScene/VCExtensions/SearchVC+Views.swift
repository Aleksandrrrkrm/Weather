//
//  SearchVC+Views.swift
//  Weather
//
//  Created by Александр Головин on 28.05.2023.
//

import UIKit

extension SearchCityViewController {
    
    // MARK: - Configure UI
    func setupAllViews() {
        view.backgroundColor = UIColor(named: Colors.appBlue.rawValue)
        setupSearchBar()
        setTableViewDelegate()
        setupTableView()
        setupActivityIndicator()
    }
    
    private func setupActivityIndicator() {
        activityIndicator.color = .white
        tableView.backgroundView = activityIndicator
    }
    
    private func setupSearchBar() {
        searchBar.delegate = self
        searchBar.becomeFirstResponder()
        searchBar.barTintColor = UIColor(named: Colors.appLightBlue.rawValue)
        view.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setTableViewDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SearchResultTableViewCell.self, forCellReuseIdentifier: CellsId.searchCell.rawValue)
    }
    
    private func setupTableView() {
        tableView.backgroundColor = UIColor(named: Colors.appBlue.rawValue)
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor,constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}
