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
    
    var output: MovieDetailsInteractorOutputInterface?
    
    init(output: MovieDetailsInteractorOutputInterface) {
        self.output = output
        self.movieService = MovieService()
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

        let languages = "en,pt_BR,\(String(describing: movie.originalLanguage)),null"
        let appendToResponse = ["videos", "images", "keywords", "releases", "similar_movies", "credits"]
        
        add(movieService.getDetails(movieId: movieId, appendToResponse: appendToResponse, language: languages)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (movieResult) in
                self.output?.movieDetailsDidFetch(movieResult)
                
                self.fetchMovieRankings(imdbId: movieResult.imdbID)
            }, onError: { (error) in
                self.output?.movieDetailsDidError(DefaultError(message: "Houve um erro ao buscar mais informações sobre esse filme"))
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
                self.output?.movieRankingsDidFetch(DefaultError(message: "Houve um erro ao buscar mais informações sobre esse filme"))
            })
        )
    }
    
}
