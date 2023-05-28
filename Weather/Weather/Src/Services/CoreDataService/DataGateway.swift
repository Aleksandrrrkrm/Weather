//
//  DataGateway.swift
//  Weather
//
//  Created by Александр Головин on 27.05.2023.
//

import CoreData

protocol CoreDataGateway: AnyObject {
    
    func getData(sortDescriptors: [NSSortDescriptor]?) -> [Forecast]?
    
    func deleteAllData()
    
    func saveData(_ data: [Forecast], completion: (() -> ())?)
    
    func saveContext()
}

class CoreDataGatewayImp: CoreDataGateway {
    
    fileprivate let coreDataStack: CoredataStack
    
    init(coreDataStack: CoredataStack) {
        self.coreDataStack = coreDataStack
    }
    
    func getData(sortDescriptors: [NSSortDescriptor]?) -> [Forecast]? {
        let fetchRequest: NSFetchRequest<Weather> = Weather.fetchRequest()
        if let sortDescriptors {
            fetchRequest.sortDescriptors = sortDescriptors
        }
        do {
            var dataModel: [Forecast] = []
            let data = try coreDataStack.managedContext.fetch(fetchRequest)
            data.forEach {
                dataModel.append(Forecast(date: $0.date ?? "",
                                          parts: Part(day: Day(tempMin: 0, tempMax: $0.tempMax,
                                                               condition: $0.forecast ?? ""))))
            }
            return dataModel
        } catch let error {
#if DEBUG
            print("ошибка getData \(error.localizedDescription)")
#endif
            return nil
        }
    }
    
    func deleteAllData() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: CoreDataEntity.name.rawValue)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        deleteRequest.resultType = .resultTypeObjectIDs
        
        do {
            try coreDataStack.managedContext.execute(deleteRequest)
#if DEBUG
            print("удалено")
#endif
            
        } catch let error {
#if DEBUG
            print("ошибка удаления \(error.localizedDescription)")
#endif
        }
    }
    
    func saveData(_ data: [Forecast], completion: (() -> ())?) {
        coreDataStack.backgroundContext.perform { [weak self] in
            guard let context = self?.coreDataStack.backgroundContext else {
                return
            }
                data.forEach {
                    let model = Weather(context: context)
                    model.date = $0.date
                    model.forecast = $0.parts.day.condition
                    model.tempMax = $0.parts.day.tempMax
                }
            
            do {
                try context.save()
                DispatchQueue.main.async {
                    self?.saveContext()
                    completion?()
                }
            } catch let error {
#if DEBUG
                print("ошибка сохранения \(error.localizedDescription)")
#endif
            }
        }
    }
    
    func saveContext() {
        coreDataStack.saveContext()
    }
}
