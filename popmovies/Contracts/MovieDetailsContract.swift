//
//  MovieDetailsContract.swift
//  popmovies
//
//  Created by Tiago Silva on 18/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import RxSwift

protocol IMovieDetailsView: IBaseView {
    
    func bindMovie(movie: Movie)
    func bindMovieRankings(movie: MovieOMDB)
    func bindMovieImages(images: Images)
}

protocol IMovieDetailsPresenter: IBasePresenter {
    
    func fetchMovieDetails(movie: Movie?)
    func fetchMovieImages(movie: Movie?)
}

protocol IMovieDetailsInteractor {
    
    func fetchMovieDetails(movie: Movie?) -> Observable<Movie>
    func fetchMovieRankings(imdbId: String) -> Observable<MovieOMDB>
    func fetchMovieImages(movie: Movie?) -> Observable<Images>
}
