//
//  HomeInteractor.swift
//  popmovies
//
//  Created by Tiago Silva on 14/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation
import RxSwift

class HomeInteractor: IHomeInteractor {
    
    let homePresenter: IHomePresenter
    let movieService: IMovieService
    
    init(homePresenter: IHomePresenter) {
        self.homePresenter = homePresenter
        self.movieService = MovieService()
    }
    
    func fetchPopularMovies(page: Int) -> Observable<Results<Movie>> {
        return movieService.getPopularMovies(page: page, region: "BR")
    }
    
    func fetchNowPlayingMovies(page: Int) -> Observable<Results<Movie>> {
        return movieService.getNowPlaying(page: page, region: "BR")
    }
    
}
