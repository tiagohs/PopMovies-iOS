//
//  BaseRepository.swift
//  popmovies
//
//  Created by Tiago Silva on 14/07/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation
import CoreData

class BaseRepository<T: NSManagedObject> {
    private var managedObject: NSManagedObject?
    
    let coreDataStore: CoreDataStore!
    
    var items: [T] = []
    
    init(_ tableName: String, _ sortDescriptior: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        coreDataStore = appDelegate.coreDataStore
        managedObject = coreDataStore.getManagedEntity(with: tableName)
        
        self.fetchItems(sortDescriptior)
    }
    
    private func fetchItems(_ sortDescriptior: String) {
        let context: NSManagedObjectContext = coreDataStore.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<T> = T.fetchRequest() as! NSFetchRequest<T>
        let sortDescriptor: NSSortDescriptor = NSSortDescriptor(key: sortDescriptior, ascending: false)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let result = try? context.fetch(fetchRequest) {
            self.items = result
        }
    }
    
    func addItem(with item: T, complationHandler: ((DefaultError?) -> Void)? = nil) {
        self.items.insert(item, at: 0)
        
        self.coreDataStore.saveContext() { (error) in
            complationHandler?(error)
        }
    }
    
    
    func removeItem(with item: T?, complationHandler: ((DefaultError?) -> Void)? = nil) {
        let context = self.coreDataStore.persistentContainer.viewContext
        
        if let itemToRemove = item {
            context.delete(itemToRemove)
            
            self.coreDataStore.saveContext() { (error) in
                complationHandler?(error)
            }
            return
        }
        
        complationHandler?(DefaultError(message: "Não foi possível remover o filme."))
    }
    
}
