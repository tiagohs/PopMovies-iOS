//
//  MovieRepository.swift
//  popmovies
//
//  Created by Tiago Silva on 13/07/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation
import CoreData

class MovieRepository: BaseRepository<MovieDB>, MovieRepositoryInterface {
    
    init() {
        super.init(MovieDB.tableName, MovieDB.tableRows.creationDate)
    }
    
}

extension MovieRepository {
    
    func add(with movie: Movie, complationHandler: ((DefaultError?) -> Void)? = nil) {
        let context = self.coreDataStore.persistentContainer.viewContext
        let movieDB = MovieDB.create(from: movie, context: context)
        
        self.addItem(with: movieDB, complationHandler: complationHandler)
    }
    
    func remove(with movie: Movie, complationHandler: ((DefaultError?) -> Void)? = nil) {
        let movieDB = self.getDBObject(with: movie)
        
        self.removeItem(with: movieDB, complationHandler: complationHandler)
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
    
    func getFavoriteMovies() -> [Movie] {
        return getAll().filter({ (movie) -> Bool in return movie.isFavorite })
    }
    
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
