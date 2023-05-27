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
    private let viewForTabBarButton = UIViewController()
    
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
        viewControllers = [mainViewController, viewForTabBarButton, forecastViewController]
    }
    
    private func configureTabBar() {
        let customTabBar = CustomTabBar()
        customTabBar.barTintColor = UIColor(named: Colors.appBlack.rawValue)
        customTabBar.backgroundColor = UIColor(named: Colors.appBlack.rawValue)
        customTabBar.isTranslucent = false
        customTabBar.tintColor = .white
        customTabBar.unselectedItemTintColor = .gray
        setValue(customTabBar, forKey: "tabBar")
        
        if let viewControllers = viewControllers, viewControllers.count >= 2 {
            let viewForTabBarButton = viewControllers[1]
            viewForTabBarButton.tabBarItem.isEnabled = false
        }
    }
    
    private func configureIcons() {
        mainViewController.tabBarItem.image = UIImage(systemName: "cloud.sun")
        forecastViewController.tabBarItem.image = UIImage(systemName: "calendar")
    }
    
    private func setupCenterButton() {
        let centerButton = UIButton(type: .custom)
        let buttonSize: CGFloat = view.bounds.height / 10
        let inset = view.bounds.height / 40
        centerButton.frame = CGRect(x: (tabBar.bounds.width - buttonSize) / 2,
                                    y: (tabBar.bounds.height - buttonSize) / 2 - inset,
                                    width: buttonSize,
                                    height: buttonSize)
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

// MARK: - Override hit test for button
class CustomTabBar: UITabBar {
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if let centerButton = getCenterButton(), centerButton.frame.contains(point) {
            return centerButton
        }
        return super.hitTest(point, with: event)
    }
    
    private func getCenterButton() -> UIButton? {
        return subviews.first { $0 is UIButton } as? UIButton
    }
    
}
