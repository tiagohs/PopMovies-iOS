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
    
    func fetchMovieDetails(movieId: Int) -> Observable<Movie> {
        let appendToResponse = ["videos", "images", "keywords", "releases", "similar_movies", "credits"]
        
        return movieService.getDetails(movieId: movieId, appendToResponse: appendToResponse, language: "en,null")
    }
    
    func fetchMovieRankings(imdbId: String) -> Observable<MovieOMDB> {
        return movieService.getMovieRankings(imdbId: imdbId) 
    }
    
    func fetchMovieImages(movieId: Int) -> Observable<Images> {
        let includeImageLanguage = ["en", "pt_BR", "null"]
        
        return movieService.getImages(movieId: movieId, includeImageLanguage: includeImageLanguage, language: "null")
    }
}
