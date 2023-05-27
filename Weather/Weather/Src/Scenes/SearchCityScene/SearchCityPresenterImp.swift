//
//  SearchCityPresenterImp.swift
//  Weather
//
//  Created by Александр Головин on 25.05.2023.
//

import Foundation

class SearchCityPresenterImp: SearchCityPresenter {
    
    // MARK: - Dependencies
    private weak var view: SearchCityView?
    
    // MARK: - Properties
    private var resultCount = 0
    private var data: [AddressSuggestion] = []
    
    // MARK: - Init
    init(_ view: SearchCityView) {
        self.view = view
    }
    
    // MARK: - API method
    func getGeo(query: String) {
        RequestManager.request(requestType: .getGeo(query: query)) { [weak self] result in
            switch result {
            case let .success(data):
                do {
                    let decoder = JSONDecoder()
                    let suggestionsResponse = try decoder.decode(AddressSuggestionsResponse.self, from: data)
                    self?.resultCount = suggestionsResponse.suggestions.count
                    self?.reloadData()
                    suggestionsResponse.suggestions.forEach { item in
                        if item.data.geoLat != nil {
                            self?.data.append(item)
                        }
                    }
                    self?.data = suggestionsResponse.suggestions
                    self?.view?.hideLoading()
                    self?.view?.reloadTableView()
                } catch {
#if DEBUG
                    print("ошибка getGeo JSON: \(error)")
#endif
                }
            case .failure:
                self?.view?.showInternetAlert()
            }
        }
    }
    
    // MARK: - Helpers
    private func reloadData() {
        data = []
    }
    
    func getCount() -> Int {
        resultCount
    }
    
    func getData() -> [AddressSuggestion] {
        data
    }
}
