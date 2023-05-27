//
//  MainVC+AlertController.swift
//  Weather
//
//  Created by Александр Головин on 27.05.2023.
//

import UIKit

class CustomAlertController: UIAlertController {

    static func showAlert(withTitle title: String, message: String, viewController: UIViewController, settingsHandler: (() -> Void)? = nil) {
        let alertController = CustomAlertController(title: title, message: message, preferredStyle: .alert)
        

        let settingsAction = UIAlertAction(title: Strings.settings.rawValue, style: .default) { (_) in
            settingsHandler?()
        }
        alertController.addAction(settingsAction)

        let cancelAction = UIAlertAction(title: Strings.cancel.rawValue, style: .cancel)
        alertController.addAction(cancelAction)

        viewController.present(alertController, animated: true, completion: nil)
    }
}
