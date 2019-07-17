//
//  MovieRepositoryInterface.swift
//  popmovies
//
//  Created by Tiago Silva on 13/07/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation

protocol MovieRepositoryInterface {
    func add(with movie: Movie, complationHandler: ((DefaultError?) -> Void)?)
    func remove(with movie: Movie, complationHandler: ((DefaultError?) -> Void)?)
    func getAll() -> [Movie]
    func get(with movie: Movie) -> Movie?
    func getFavoriteMovies() -> [Movie]
    
    func getHoursMinutesSeconds() -> (Int, Int, Int)
    func isFavoriteMovie(with movie: Movie) -> Bool
    func isWatchedMovie(with movie: Movie) -> Bool
    func isWantToSeeMovie(with movie: Movie) -> Bool
    
    func addOrRemoveToFavorite(with movie: Movie) -> Bool
    func addOrRemoveToWatched(with movie: Movie) -> Bool
    func addOrRemoveToWantToSee(with movie: Movie) -> Bool
}
