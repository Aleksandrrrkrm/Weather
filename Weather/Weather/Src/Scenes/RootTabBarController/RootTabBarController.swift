//
//  RootTabBarController.swift
//  Weather
//
//  Created by Александр Головин on 24.05.2023.
//

import UIKit

final class RootTabBarController: UITabBarController {
    
    // MARK: - VC's
    private let mainViewController = UINavigationController(rootViewController: MainViewController())
    private let forecastViewController = UINavigationController(rootViewController: ForecastViewController())
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addViewControllers()
        configureIcons()
        configureTabBar()
    }
    
    // MARK: - Settings
    
    private func addViewControllers() {
        viewControllers = [mainViewController, forecastViewController]
    }
    
    private func configureTabBar() {
        tabBar.barTintColor = UIColor(named: "appBlack")
        tabBar.backgroundColor = UIColor(named: "appBlack")
        tabBar.isTranslucent = false
        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = .gray
    }
    
    private func configureIcons() {
        let titles = ["Main", "Forecast"]
        let images = [UIImage(systemName: "sun.max.fill"), UIImage(named: "cloud.fill")]
        self.viewControllers?.enumerated().forEach({ index, view in
            view.tabBarItem.title = titles[index]
            view.tabBarItem.image = images[index]
        })
    }
}
