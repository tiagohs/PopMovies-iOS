//
//  HomeContract.swift
//  popmovies
//
//  Created by Tiago Silva on 11/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation
import RxSwift

protocol IHomeView: IBaseView {
    
    func bindNowPlayingMovies(movies: [Movie])
    func bindPopularMovies(movies: [Movie])
    func bindTopRatedMovies(movies: [Movie])
    func bindUpcomingMovies(movies: [Movie])
}

protocol IHomePresenter: IBasePresenter {
    func fetchPopularMovies()
    func fetchNowPlayingMovies()
    func fetchTopRatedMovies()
    func fetchUpcomingMovies()
}

protocol IHomeInteractor {
    func fetchPopularMovies(page: Int) -> Observable<Results<Movie>>
    func fetchNowPlayingMovies(page: Int) -> Observable<Results<Movie>>
    func fetchTopRatedMovies(page: Int) -> Observable<Results<Movie>>
    func fetchUpcomingMovies(page: Int) -> Observable<Results<Movie>>
}
