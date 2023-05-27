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
    
    // MARK: - UI elements
    var searchBar = UISearchBar()
    var tableView = UITableView()
    var activityIndicator = UIActivityIndicatorView(style: .medium)
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAllViews()
        searchBar.becomeFirstResponder()
    }
    
    // MARK: - Configure UI
    private func setupAllViews() {
        view.backgroundColor = UIColor(named: "appBlue")
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
        searchBar.barTintColor = UIColor(named: "appLightBlue")
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
        tableView.register(SearchResultTableViewCell.self, forCellReuseIdentifier: "searchCell")
    }
    
    private func setupTableView() {
        tableView.backgroundColor = UIColor(named: "appBlue")
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor,constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
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
    
    @objc func search(timer: Timer) {
        if let searchText = timer.userInfo as? String {
            self.presenter?.getGeo(query: searchText)
        }
    }
}

// MARK: - Protocol extension
extension SearchCityViewController: SearchCityView {
    
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
