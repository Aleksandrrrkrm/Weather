//
//  ExtButton.swift
//  Weather
//
//  Created by Александр Головин on 25.05.2023.
//

import UIKit

extension UIButton {
    
    convenience init(_ title: String) {
        self.init()
        self.title(title)
    }
    
    @discardableResult
    func title(_ title: String?, for state: UIControl.State = .normal) -> Self {
        self.setTitle(title, for: state)
        return self
    }
    
    @discardableResult
    func corners(_ radius: CGFloat) -> Self {
        self.layer.cornerRadius = radius
        return self
    }
    
    @discardableResult
    func background(_ color: UIColor) -> Self {
        self.backgroundColor = color
        return self
    }
    
    @discardableResult
    func font(_ font: UIFont, size: CGFloat? = nil) -> Self {
        self.titleLabel?.font = size != nil ? font.withSize(size!) : font
        return self
    }
    
}
