//
//  MovieDetailsInteractor.swift
//  popmovies
//
//  Created by Tiago Silva on 18/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import RxSwift

// MARK: MovieDetailsInteractor: BaseInteractor

class MovieDetailsInteractor: BaseInteractor {
    
    let movieService: MovieServiceInterface!
    let movieRepository: MovieRepositoryInterface!
    
    var output: MovieDetailsInteractorOutputInterface?
    
    init(output: MovieDetailsInteractorOutputInterface) {
        self.output = output
        self.movieService = MovieService()
        self.movieRepository = MovieRepository()
    }
    
}

// MARK: MovieDetailsInteractorInputInterface - Output lifecycle Methods

extension MovieDetailsInteractor: MovieDetailsInteractorInputInterface {
    
    func outputDidLoad() {}
    
    func outputFinished() {
        disposibles.dispose()
        
        self.output = nil
    }
}

// MARK: MovieDetailsInteractorInputInterface - Fetch methods

extension MovieDetailsInteractor {
    
    func fetchMovieDetails(movie: Movie) {
        guard let movieId = movie.id else {
            return
        }

        let languages = "\(Locale.getCurrentAppLangAndRegion()),\(String(describing: movie.originalLanguage)),en,null"
        let appendToResponse = [
            TMDB.Parameters.videos,
            TMDB.Parameters.images,
            TMDB.Parameters.keywords,
            TMDB.Parameters.releases,
            TMDB.Parameters.similar_movies,
            TMDB.Parameters.credits
        ]
        
        add(movieService.getDetails(movieId: movieId, appendToResponse: appendToResponse, language: languages)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (movieResult) in
                movieResult.isFavorite = self.movieRepository.isFavoriteMovie(with: movieResult)
                movieResult.isWantToSee = self.movieRepository.isWantToSeeMovie(with: movieResult)
                movieResult.isWatched = self.movieRepository.isWatchedMovie(with: movieResult)
                
                self.output?.movieDetailsDidFetch(movieResult)
                
                self.fetchMovieRankings(imdbId: movieResult.imdbID)
            }, onError: { (error) in
                self.output?.movieDetailsDidError(DefaultError(message: R.string.localizable.moviesFetchUnknownError()))
            })
        )
    }
    
    func fetchMovieRankings(imdbId: String?) {
        guard let imdbId = imdbId else {
            return
        }
        
        add(movieService.getMovieRankings(imdbId: imdbId)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (movie) in
                self.output?.movieRankingsDidFetch(movie)
            }, onError: { (error) in
                self.output?.movieRankingsDidFetch(DefaultError(message: R.string.localizable.moviesFetchUnknownError()))
            })
        )
    }
    
}

extension MovieDetailsInteractor {
    
    func didFavoriteClicked(with movie: Movie) -> Bool {
        return self.movieRepository.addOrRemoveToFavorite(with: movie)
    }
    
    func didWatchedClicked(with movie: Movie) -> Bool {
        return self.movieRepository.addOrRemoveToWatched(with: movie)
    }
    func didWantToSeeClicked(with movie: Movie) -> Bool {
        return self.movieRepository.addOrRemoveToWantToSee(with: movie)
    }
    
}

extension MovieDetailsInteractor {
    
    func isFavoriteMovie(with movie: Movie) -> Bool {
        return self.movieRepository.isFavoriteMovie(with: movie)
    }
    
    func isWatchedMovie(with movie: Movie) -> Bool {
        return self.movieRepository.isWatchedMovie(with: movie)
    }
    
    func isWantToSeeMovie(with movie: Movie) -> Bool {
        return self.movieRepository.isWantToSeeMovie(with: movie)
    }
    
}
