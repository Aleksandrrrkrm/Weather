//
//  MainPresenterImp.swift
//  Weather
//
//  Created by Александр Головин on 24.05.2023.
//

import Foundation

class MainPresenterImp: MainPresenter {
    
    private weak var view: MainView?
    private let router: MainRouter
    
    init(_ view: MainView,
         _ router: MainRouter) {
        self.view = view
        self.router = router
    }
    
}
