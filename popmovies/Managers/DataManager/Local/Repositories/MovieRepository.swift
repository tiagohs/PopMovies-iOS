//
//  MovieRepository.swift
//  popmovies
//
//  Created by Tiago Silva on 13/07/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation
import CoreData

class MovieRepository: MovieRepositoryInterface {
    
    private var movieManagedObject: NSManagedObject?
    
    let coreDataStore: CoreDataStore!
    
    var items: [MovieDB] = []
    
    init() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        coreDataStore = appDelegate.coreDataStore
        movieManagedObject = coreDataStore.getManagedEntity(with: MovieDB.tableName)
        
        self.fetchItems()
    }
    
    private func fetchItems() {
        let context: NSManagedObjectContext = coreDataStore.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<MovieDB> = MovieDB.fetchRequest()
        let sortDescriptor: NSSortDescriptor = NSSortDescriptor(key: MovieDB.tableRows.creationDate, ascending: false)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let result = try? context.fetch(fetchRequest) {
            self.items = result
        }
    }
    
    func add(with movie: Movie, complationHandler: ((DefaultError?) -> Void)? = nil) {
        let context = self.coreDataStore.persistentContainer.viewContext
        let movieDB = MovieDB.create(from: movie, context: context)
        
        self.items.insert(movieDB, at: 0)
        
        self.coreDataStore.saveContext() { (error) in
            complationHandler?(error)
        }
    }
    
    func remove(with movie: Movie, complationHandler: ((DefaultError?) -> Void)? = nil) {
        let context = self.coreDataStore.persistentContainer.viewContext
        let movieDB = self.getDBObject(with: movie)
        
        if let movieToRemove = movieDB {
            context.delete(movieToRemove)
            
            self.coreDataStore.saveContext() { (error) in
                complationHandler?(error)
            }
            return
        }
        
        complationHandler?(DefaultError(message: "Não foi possível remover o filme."))
    }
    
    func getAll() -> [Movie] {
        return self.items.map({ (movieDB) -> Movie in return movieDB.toMovie() })
    }
    
    func get(with movie: Movie) -> Movie? {
        let movieDB = self.getDBObject(with: movie)
        
        return movieDB?.toMovie()
    }
    
    func getDBObject(with movie: Movie) -> MovieDB? {
        return self.items.first { (movieDB) -> Bool in
            guard let id = movie.id else { return false }
            
            return movieDB.id == Int32(id)
        }
    }
}

extension MovieRepository {
    
    func addOrRemoveToFavorite(with movie: Movie) -> Bool {
        guard let movieDB = getDBObject(with: movie) else {
            movie.isFavorite = true
            add(with: movie)
            return true
        }
        
        movieDB.isFavorite = !movieDB.isFavorite
        
        self.coreDataStore.saveContext()
        
        return movieDB.isFavorite
    }
    
    func addOrRemoveToWatched(with movie: Movie) -> Bool {
        
        if getDBObject(with: movie) != nil {
            remove(with: movie)
            return false
        }
        
        add(with: movie)
        
        self.coreDataStore.saveContext()
        
        return true
    }
    
    func addOrRemoveToWantToSee(with movie: Movie) -> Bool {
        guard let movieDB = getDBObject(with: movie) else {
            movie.isWantToSee = true
            add(with: movie)
            return true
        }
        
        movieDB.isWantToSee = !movieDB.isWantToSee
        
        self.coreDataStore.saveContext()
        
        return movieDB.isWantToSee
    }
    
    func isFavoriteMovie(with movie: Movie) -> Bool {
        guard let movieDB = getDBObject(with: movie) else {
            return false
        }
        
        return movieDB.isFavorite
    }
    
    func isWatchedMovie(with movie: Movie) -> Bool {
        return getDBObject(with: movie) != nil
    }
    
    func isWantToSeeMovie(with movie: Movie) -> Bool {
        guard let movieDB = getDBObject(with: movie) else {
            return false
        }
        
        return movieDB.isWantToSee
    }
    
}
