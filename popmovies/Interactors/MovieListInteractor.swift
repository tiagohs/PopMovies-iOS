//
//  MovieListInteractor.swift
//  popmovies
//
//  Created by Tiago Silva on 24/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation
import RxSwift

class MovieListInteractor: IMovieListInteractor {
    
    var service: IMovieService!
    
    init() {
        self.service = MovieService()
    }
    
    func fetchMoviesFrom(url: String, parameters: [String : String]) -> Observable<Results<Movie>> {
        return service.getMovieList(url: url, paramenters: parameters)
    }
    
}
