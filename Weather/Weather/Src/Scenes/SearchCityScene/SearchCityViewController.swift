//
//  SearchCityViewController.swift
//  Weather
//
//  Created by Александр Головин on 25.05.2023.
//

import UIKit

class SearchCityViewController: UIViewController {
    
    internal var presenter: SearchCityPresenter?
    
    var searchTimer: Timer?
    let searchDelay: TimeInterval = 0.3
    
    var searchBar = UISearchBar()
    var tableView = UITableView()
    var activityIndicator = UIActivityIndicatorView(style: .medium)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SearchResultTableViewCell.self, forCellReuseIdentifier: "searchCell")
        setupAllViews()
        activityIndicator.color = .white
    }
    
    private func setupAllViews() {
        view.backgroundColor = UIColor(named: "appBlue")
        setupSearchBar()
        setupTableView()
    }
    
    private func setupSearchBar() {
        searchBar.delegate = self
        searchBar.barTintColor = UIColor(named: "appLightBlue")
        view.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupTableView() {
        tableView.backgroundColor = UIColor(named: "appBlue")
        tableView.backgroundView = activityIndicator
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor,constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc func search(timer: Timer) {
        if let searchText = timer.userInfo as? String {
            self.presenter?.getGeo(query: searchText)
        }
    }
    
    func closeScene() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.dismiss(animated: true)
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

extension SearchCityViewController: SearchCityView {
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
