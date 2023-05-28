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
    private var data: [AddressSuggestion] = []
    
    var searchTimer: Timer?
    
    // MARK: - Init
    init(_ view: SearchCityView) {
        self.view = view
    }
    
    // MARK: - API method
    func getGeo(query: String) {
        RequestManager.request(requestType: .getGeo(query: query)) { [weak self] (result: Result<AddressSuggestionsResponse, Error>) in
            switch result {
            case let .success(data):
                self?.reloadData()
                data.suggestions.forEach { item in
                    if item.data.geoLat != nil {
                        self?.data.append(item)
                    }
                }
                self?.data = data.suggestions
                self?.view?.hideLoading()
                self?.view?.reloadTableView()
            case let .failure(error):
                self?.view?.showErrorAlert(message: error.localizedDescription)
            }
        }
    }
    
    func searchCity(text: String) {
        searchTimer?.invalidate()
        searchTimer = Timer.scheduledTimer(timeInterval: 0.3,
                                           target: self,
                                           selector: #selector(search),
                                           userInfo: text,
                                           repeats: false)
    }
    
    // MARK: - Helpers
    private func reloadData() {
        data = []
    }
    
    @objc func search(timer: Timer) {
        if InternetConnection.checkInternetConnection() {
            if let searchText = timer.userInfo as? String {
                self.getGeo(query: searchText)
            }
        } else {
            view?.showInternetAlert()
        }
    }
    
    func sendNotification(with data: AddressSuggestion) {
        let notificationName = Notification.Name(NotificationName.newCity.rawValue)
        let userInfo: [String: AddressSuggestion] = [NotificationName.newCity.rawValue : data]
        NotificationCenter.default.post(name: notificationName, object: nil, userInfo: userInfo)
    }
    
    func getData() -> [AddressSuggestion] {
        data
    }
}
