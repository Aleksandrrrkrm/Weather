//
//  BaseView.swift
//  Weather
//
//  Created by Александр Головин on 28.05.2023.
//

import UIKit

protocol BaseView: AnyObject {}

extension BaseView {
    
    func performInMainThread(_ block: @escaping () -> ()) {
        if Thread.isMainThread {
            block()
        } else {
            DispatchQueue.main.async {
                block()
            }
        }
    }
    
    func showAlert(withTitle title: String,
                   message: String,
                   actionTitle: String?,
                   viewController: UIViewController,
                   settingsHandler: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if let actionTitle {
            let action = UIAlertAction(title: actionTitle, style: .default) { _ in
                settingsHandler?()
            }
            alertController.addAction(action)
        }
        let cancelAction = UIAlertAction(title: Strings.cancel.rawValue, style: .cancel)
        alertController.addAction(cancelAction)
        viewController.present(alertController, animated: true, completion: nil)
    }
}
