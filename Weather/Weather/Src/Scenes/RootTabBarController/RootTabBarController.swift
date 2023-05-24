//
//  RootTabBarController.swift
//  Weather
//
//  Created by Александр Головин on 24.05.2023.
//

import UIKit

final class RootTabBarController: UITabBarController {

        
       private let mainViewController = UINavigationController(rootViewController: MainViewController())
       private let forecastViewController = UINavigationController(rootViewController: ForecastViewController())
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            addViewControllers()
            configureIcons()
            configureTabBar()
        }
        
        private func configureTabBar() {
            tabBar.barTintColor = .gray
            tabBar.backgroundColor = .lightGray
            tabBar.isTranslucent = false
            tabBar.tintColor = .white
            tabBar.unselectedItemTintColor = .black
        }
        
        private func addViewControllers() {
            viewControllers = [mainViewController, forecastViewController]
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
