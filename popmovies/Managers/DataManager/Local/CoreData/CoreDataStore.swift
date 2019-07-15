//
//  CoreDataStore.swift
//  popmovies
//
//  Created by Tiago Silva on 13/07/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStore {
    
    let persistentContainer: NSPersistentContainer!
    let modelName: String = Database.CORE_DATA.name
    
    init() {
        persistentContainer = NSPersistentContainer(name: Database.CORE_DATA.name)
    }
    
}

extension CoreDataStore {
    
    func loadPersistentContainer(completionHandler: (() -> Void)? = nil) {
        
        persistentContainer.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
            
            completionHandler?()
        })
    }
    
    func saveContext (complationHandler: ((DefaultError?) -> Void)? = nil) {
        let context = persistentContainer.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
                
                complationHandler?(nil)
            } catch {
                let nserror = error as NSError
                
                complationHandler?(DefaultError(message: nserror.localizedDescription))
            }
        }
    }
    
    func getManagedEntity(with name: String) -> NSManagedObject? {
        let context = persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: name, in: context)!
        
        return NSManagedObject(entity: entity, insertInto: context)
    }
}
