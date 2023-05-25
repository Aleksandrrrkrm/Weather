//
//  ExtImageView.swift
//  Weather
//
//  Created by Александр Головин on 25.05.2023.
//

import UIKit

extension UIImageView {
    
    @discardableResult
    func cornerRadius(radius: CGFloat) -> Self {
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
        return self
    }
}

