//
//  MainVC+AlertController.swift
//  Weather
//
//  Created by Александр Головин on 27.05.2023.
//

import UIKit


//class CustomAlert: UIAlertController {
//
//    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
//        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//
//        configureAlert()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    private func configureAlert() {
//        title = "Информация о погоде недоступна"
//        message = "Приложение 'Weather' не подключено к интернету.\nПроверьте подключение к сети"
//        self.preferredStyle = .alert
//        let settingsAction = UIAlertAction(title: "Перейти в настройки", style: .default) { (action) in
//              if let url = URL(string:UIApplication.openSettingsURLString) {
//                  if UIApplication.shared.canOpenURL(url) {
//                      UIApplication.shared.open(url, options: [:], completionHandler: nil)
//                  }
//              }
//          }
//          self.addAction(settingsAction)
//        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
//          self.addAction(cancelAction)
//    }
//}

class CustomAlertController: UIAlertController {

    static func showAlert(withTitle title: String, message: String, viewController: UIViewController, settingsHandler: (() -> Void)? = nil) {
        let alertController = CustomAlertController(title: title, message: message, preferredStyle: .alert)
        

        let settingsAction = UIAlertAction(title: "Настройки", style: .default) { (_) in
            settingsHandler?()
        }
        alertController.addAction(settingsAction)

        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
        alertController.addAction(cancelAction)

        viewController.present(alertController, animated: true, completion: nil)
    }
}
