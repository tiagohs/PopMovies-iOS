//
//  MovieDB+Extensions.swift
//  popmovies
//
//  Created by Tiago Silva on 14/07/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation
import CoreData

extension MovieDB {
    
    static let tableName = Database.CORE_DATA.MovieTable.name
    static let tableRows = Database.CORE_DATA.MovieTable.Rows.self
    
    
    func toMovie() -> Movie {
        let movie = Movie()
        
        movie.id = Int(self.id)
        movie.title = self.title
        movie.overview = self.overview
        movie.posterPath = self.posterPath
        movie.backdropPath = self.backdropPath
        movie.isFavorite = self.isFavorite
        movie.isWatched = true
        movie.isWantToSee = self.isWantToSee
        
        return movie
    }
    
    static func create(from movie: Movie, context: NSManagedObjectContext) -> MovieDB {
        let movieDB = MovieDB(context: context)
        
        if let id = movie.id {
            movieDB.id = Int32(id)
        }
        
        if let title = movie.title {
            movieDB.title = title
        }
        
        if let overview = movie.title {
            movieDB.overview = overview
        }
        
        if let posterPath = movie.posterPath {
            movieDB.posterPath = posterPath
        }
        
        if let backdropPath = movie.backdropPath {
            movieDB.backdropPath = backdropPath
        }
        
        movieDB.creationDate = Date()
        
        movieDB.isFavorite = movie.isFavorite
        movieDB.isWantToSee = movie.isWantToSee
        
        return movieDB
    }
    
}
