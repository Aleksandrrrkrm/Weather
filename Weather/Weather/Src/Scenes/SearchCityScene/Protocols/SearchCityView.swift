//
//  SearchCityView.swift
//  Weather
//
//  Created by Александр Головин on 25.05.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import UIKit

protocol SearchCityView: AnyObject {
    
    func reloadTableView()
    func hideLoading()
}
