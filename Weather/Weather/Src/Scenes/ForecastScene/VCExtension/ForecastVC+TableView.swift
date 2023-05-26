//
//  ForecastVC+TableView.swift
//  Weather
//
//  Created by Александр Головин on 26.05.2023.
//

import UIKit

extension ForecastViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.getData().count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ForecastTableViewCell else {
            return UITableViewCell()
        }
        
        guard let data = presenter?.getData() else {
            return UITableViewCell()
        }
        cell.setupCell(data: data[indexPath.row])
        return cell
    }
}

