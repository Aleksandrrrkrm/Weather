//
//  Weather+CoreDataProperties.swift
//  Weather
//
//  Created by Александр Головин on 26.05.2023.
//
//

import Foundation
import CoreData


extension Weather {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Weather> {
        return NSFetchRequest<Weather>(entityName: "Weather")
    }

    @NSManaged public var tempMin: String?
    @NSManaged public var tempMax: String?
    @NSManaged public var date: String?
    @NSManaged public var forecast: String?

}

extension Weather : Identifiable {

}
