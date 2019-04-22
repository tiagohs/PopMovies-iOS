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
}

protocol IMovieDetailsPresenter: IBasePresenter {
    
    func fetchMovieDetails(movieId: Int?)
}

protocol IMovieDetailsInteractor {
    
    func fetchMovieDetails(movieId: Int) -> Observable<Movie>
    func fetchMovieRankings(imdbId: String) -> Observable<MovieOMDB>
}
