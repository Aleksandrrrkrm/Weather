//
//  SearchVC+TableViewDelegate.swift
//  Weather
//
//  Created by Александр Головин on 26.05.2023.
//

import UIKit

extension SearchCityViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as? SearchResultTableViewCell,
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
        let notificationName = Notification.Name("NewCity")
        let userInfo: [String: AddressSuggestion] = ["NewCity" : data[indexPath.row]]
        NotificationCenter.default.post(name: notificationName, object: nil, userInfo: userInfo)
        closeScene()
    }
}
