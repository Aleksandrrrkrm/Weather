//
//  DateFormatter.swift
//  Weather
//
//  Created by Александр Головин on 26.05.2023.
//

import Foundation

enum DateService {
    
    static func format(from date: String, to mask: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let newDate = dateFormatter.date(from: date) {
            dateFormatter.dateFormat = mask
            let formattedDate = dateFormatter.string(from: newDate)
            return formattedDate
        } else {
            return nil
        }
    }
}
