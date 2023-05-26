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
        setupActivity()
        setupCityLabel()
        setupTempLabel()
        setupDescriptionLabel()
        setupSearchButton()
    }
    
    private func setupActivity() {
        view.addSubview(activityIndicator)
        activityIndicator.color = .white
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 10),
            activityIndicator.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
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
        imageView.image = UIImage(named: "base")
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
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
        let rightButton = UIBarButtonItem(title: "Сменить город",
                                          style: .plain,
                                          target: self,
                                          action: #selector(buttonTapped))
        rightButton.tintColor = .white
        navigationItem.rightBarButtonItem = rightButton
    }
}
