//
//  MovieListContract.swift
//  popmovies
//
//  Created by Tiago Silva on 24/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation
import RxSwift

protocol IMovieListView: IBaseView {
    
    func bindMovies(movies: [Movie])
}

protocol IMovieListPresenter: IBasePresenter {
    
    func fetchMoviesFrom(url: String?, parameters: [String : String ]?)
}

protocol IMovieListInteractor {
    
    func fetchMoviesFrom(url: String, parameters: [String : String ]) -> Observable<Results<Movie>>
}

