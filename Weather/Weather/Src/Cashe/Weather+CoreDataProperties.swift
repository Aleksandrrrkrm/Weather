//
//  Weather+CoreDataProperties.swift
//  Weather
//
//  Created by Александр Головин on 27.05.2023.
//
//

import Foundation
import CoreData


extension Weather {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Weather> {
        return NSFetchRequest<Weather>(entityName: "Weather")
    }

    @NSManaged public var date: String?
    @NSManaged public var forecast: String?
    @NSManaged public var tempMax: Int

}

extension Weather : Identifiable {

}
