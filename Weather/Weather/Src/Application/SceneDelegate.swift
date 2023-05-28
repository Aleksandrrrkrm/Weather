//
//  SceneDelegate.swift
//  Weather
//
//  Created by Александр Головин on 24.05.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let rootTabBarController = RootTabBarController()
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = rootTabBarController
        window?.overrideUserInterfaceStyle = .dark
        window?.makeKeyAndVisible()
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        guard let windowScene = scene as? UIWindowScene,
            let tabBarController = windowScene.windows.first?.rootViewController as? UITabBarController,
            let navController = tabBarController.viewControllers?[0] as? UINavigationController,
            let mainViewController = navController.viewControllers.first as? MainViewController else {
                return
        }
        mainViewController.presenter?.checkAuthorizationStatus()
    }
}

