//
//  CoreDataStack.swift
//  Weather
//
//  Created by Александр Головин on 27.05.2023.
//

import CoreData

final class CoreStack {
    
    static var shared = CoredataStack(modelName: CoreDataEntity.name.rawValue)
    
    fileprivate init () {}
}

final class CoredataStack {
    
    fileprivate var modelName: String
    
    init(modelName: String) {
        self.modelName = modelName
    }
    
    lazy var managedContext: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()
    
    lazy var backgroundContext: NSManagedObjectContext = {
        let context: NSManagedObjectContext = .init(concurrencyType: .privateQueueConcurrencyType)
        context.parent = managedContext
        return context
    }()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: modelName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
#if DEBUG
                print("ошибка persistentContainer \(error), \(error.userInfo)")
#endif
            }
        })
        return container
    }()

    
    func saveContext () {
        if managedContext.hasChanges {
            do {
                try managedContext.save()
#if DEBUG
                print("сохраненно")
#endif
            } catch {
                managedContext.rollback()
                let nserror = error as NSError
#if DEBUG
                print("ошибка saveContext \(nserror), \(nserror.userInfo)")
#endif
            }
        }
    }
}
