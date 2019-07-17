//
//  ProfileInteractor.swift
//  popmovies
//
//  Created by Tiago Silva on 30/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation

// MARK: ProfileInteractor: BaseInteractor 

class ProfileInteractor: BaseInteractor {
    
    let authManager: AuthManager!
    let movieRepository: MovieRepositoryInterface!
    
    var output: ProfileInteractorOutputInterface?
    
    init(output: ProfileInteractorOutputInterface?) {
        self.output = output
        self.authManager = AuthManager.shared
        self.movieRepository = MovieRepository()
    }
}

// MARK: ProfileInteractorInputInterface

extension ProfileInteractor {
    
    func didSingUpClicked() {
        self.authManager.signOut { (error) in
            if let error = error {
                self.output?.didSignOutError(error)
                return
            }
            
            self.output?.didSignOutFinished()
        }
        
    }
}

// MARK: ProfileInteractorInputInterface - Output Lifecycle Methods

extension ProfileInteractor: ProfileInteractorInputInterface {
    
    func outputDidLoad() {}
    
    func outputFinished() {}
    
}

extension ProfileInteractor {
    
    func fetchWatchedMovies() {
        let movies = self.movieRepository.getAll().filter { (movie) -> Bool in return movie.id != 0}
        
        self.output?.didWatchedMoviesFetch(movies)
        
        self.updateProfileDetails(movies.count)
    }
    
    func fetchFavoriteMovies() {
        let movies = self.movieRepository.getFavoriteMovies()
        
        self.output?.didFavoriteMoviesFetch(movies)
    }
    
    func updateProfileDetails(_ totalMovies: Int) {
        guard let totalTime = self.movieRepository?.getHoursMinutesSeconds() else {
            return
        }
        
        self.output?.updateProfileDetails(totalMovies, totalDuration: totalTime)
    }
}
