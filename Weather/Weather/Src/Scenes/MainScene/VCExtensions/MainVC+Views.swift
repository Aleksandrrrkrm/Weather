//
//  MainVC+Views.swift
//  Weather
//
//  Created by Александр Головин on 25.05.2023.
//

import UIKit

extension MainViewController {
    
    func setupAllView() {
        setupImageView()
        setupCityLabel()
        setupTempLabel()
        setupDescriptionLabel()
        setupSearchButton()
    }
    
    private func setupCityLabel() {
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cityLabel)
        NSLayoutConstraint.activate([
            cityLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            cityLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cityLabel.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20)
        ])
    }
    
    private func setupTempLabel() {
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tempLabel)
        NSLayoutConstraint.activate([
            tempLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 10),
            tempLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setupImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        imageView.contentMode = .scaleToFill
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor)
            
        ])
    }
    
    private func setupDescriptionLabel() {
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: tempLabel.bottomAnchor, constant: 10),
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setupSearchButton() {
        let rightButton = UIBarButtonItem(title: "Другой город", style: .plain, target: self, action: #selector(buttonTapped))
        rightButton.tintColor = .gray
               
               // Установка кнопки в правой части навигационного бара
               navigationItem.rightBarButtonItem = rightButton
    }
}
