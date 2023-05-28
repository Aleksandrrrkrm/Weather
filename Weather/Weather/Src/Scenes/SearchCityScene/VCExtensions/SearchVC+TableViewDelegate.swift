//
//  SearchVC+TableViewDelegate.swift
//  Weather
//
//  Created by Александр Головин on 26.05.2023.
//

import UIKit

extension SearchCityViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getData().count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellsId.searchCell.rawValue, for: indexPath) as? SearchResultTableViewCell,
              let data = presenter?.getData() else {
            return UITableViewCell()
        }
        if !data.isEmpty {
            cell.setupCell(data[indexPath.row])
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let data = presenter?.getData() else { return }
        presenter?.sendNotification(with: data[indexPath.row])
        closeScene()
    }
}
