//
//  SearchVC+SearchBarDelegate.swift
//  Weather
//
//  Created by Александр Головин on 26.05.2023.
//

import UIKit

extension SearchCityViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        showLoading()
        presenter?.searchCity(text: searchText)
    }
}
