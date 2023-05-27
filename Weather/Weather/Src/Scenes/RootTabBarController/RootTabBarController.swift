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
    private let justForButtonScene = JustForButtonScene()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addViewControllers()
        configureIcons()
        configureTabBar()
        setupCenterButton()
    }
    
    // MARK: - Settings
    
    private func addViewControllers() {
        viewControllers = [mainViewController, justForButtonScene, forecastViewController]
    }
    
    private func configureTabBar() {
        tabBar.barTintColor = UIColor(named: Colors.appBlack.rawValue)
        tabBar.backgroundColor = UIColor(named: Colors.appBlack.rawValue)
        tabBar.isTranslucent = false
        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = .gray
    }
    
    private func configureIcons() {
        
        mainViewController.tabBarItem.image = UIImage(systemName: "cloud.sun")
        forecastViewController.tabBarItem.image = UIImage(systemName: "calendar")
    }
    
    private func setupCenterButton() {
        let centerButton = UIButton(type: .custom)
        let buttonSize: CGFloat = 80.0
        centerButton.frame = CGRect(x: (tabBar.bounds.width - buttonSize) / 2, y: (tabBar.bounds.height - buttonSize) / 2 - 10, width: buttonSize, height: buttonSize)
        centerButton.layer.shadowColor = UIColor.black.cgColor
        centerButton.layer.shadowOffset = CGSize(width: 0, height: 6)
        centerButton.layer.shadowRadius = 8
        centerButton.layer.shadowOpacity = 1
        centerButton.layer.masksToBounds = false
        centerButton.setImage(UIImage(named: "justForButton"), for: .normal)
        centerButton.addTarget(self, action: #selector(tabButtonTapped), for: .touchUpInside)
        
        tabBar.addSubview(centerButton)
    }
    
    @objc private func tabButtonTapped() {
        selectedIndex = 1
    }
}
