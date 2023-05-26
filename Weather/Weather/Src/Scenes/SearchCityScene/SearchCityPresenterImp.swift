//
//  SearchCityPresenterImp.swift
//  Weather
//
//  Created by Александр Головин on 25.05.2023.
//

import Foundation

class SearchCityPresenterImp: SearchCityPresenter {
    
    private weak var view: SearchCityView?
    private let router: SearchCityRouter
    private var resultCount = 0
    private var data: [AddressSuggestion] = []
    
    init(_ view: SearchCityView,
         _ router: SearchCityRouter) {
        self.view = view
        self.router = router
    }
    
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
                    print("Error decoding JSON: \(error)")
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func reloadData() {
        data = []
    }
    
    func getCount() -> Int {
        resultCount
    }
    
    func getData() -> [AddressSuggestion] {
        data
    }
}
