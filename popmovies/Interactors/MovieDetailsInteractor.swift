//
//  MovieDetailsInteractor.swift
//  popmovies
//
//  Created by Tiago Silva on 18/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import RxSwift

class MovieDetailsInteractor: IMovieDetailsInteractor {
    
    var presenter: IMovieDetailsPresenter? = nil
    var movieService: IMovieService
    
    init(presenter: IMovieDetailsPresenter) {
        self.presenter = presenter
        self.movieService = MovieService()
    }
    
    func fetchMovieDetails(movie: Movie?) -> Observable<Movie> {
        let languages = "en,pt_BR,\(String(describing: movie?.originalLanguage)),null"
        let appendToResponse = ["videos", "images", "keywords", "releases", "similar_movies", "credits"]
        
        return movieService.getDetails(movieId: movie!.id!, appendToResponse: appendToResponse, language: languages)
    }
    
    func fetchMovieRankings(imdbId: String) -> Observable<MovieOMDB> {
        return movieService.getMovieRankings(imdbId: imdbId) 
    }
    
    func fetchMovieImages(movie: Movie?) -> Observable<Images> {
        let includeImageLanguage = ["en", "pt_BR", String(describing: movie?.originalLanguage), "null"]
        
        return movieService.getImages(movieId: movie!.id!, includeImageLanguage: includeImageLanguage, language: "null")
    }
}
