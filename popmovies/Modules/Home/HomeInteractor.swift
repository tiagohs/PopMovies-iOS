//
//  HomeInteractor.swift
//  popmovies
//
//  Created by Tiago Silva on 14/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation
import RxSwift

// MARK: HomeInteractor: BaseInteractor

class HomeInteractor: BaseInteractor {
    let movieService: MovieServiceInterface
    
    var output: HomeInteractorOutputInterface?
    
    init(output: HomeInteractorOutputInterface?) {
        self.output = output
        self.movieService = MovieService()
    }
}

// MARK: HomeInteractorInputInterface - Output lifecycle Methods

extension HomeInteractor: HomeInteractorInputInterface {
    
    func outputDidLoad() {}
    
    func outputFinished() {
        disposibles.dispose()
        
        self.output = nil
    }
    
}

// MARK: HomeInteractorInputInterface - Fetch methods

extension HomeInteractor {
    
    func fetchPopularMovies() {
        add(movieService.getPopularMovies(page: 1, region: "BR")
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (results) in
                guard let movies = results.results else {
                    self.output?.popularMoviesDidError(MovieListNotFoundError(message: "Não há nenhum filme disponível."))
                    return
                }
                
                self.output?.popularMoviesDidFetch(movies)
            }, onError: { (error) in
                self.output?.popularMoviesDidError(MovieListNotFoundError(message: "Houve um erro inesperado ao buscar os filmes, tente novamente."))
            })
        )
    }
    
    func fetchNowPlayingMovies() {
        add(movieService.getNowPlaying(page: 1, region: "BR")
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (results) in
                guard let movies = results.results else {
                    self.output?.nowPlayingMoviesDidError(MovieListNotFoundError(message: "Não há nenhum filme disponível."))
                    return
                }
                
                self.output?.nowPlayingMoviesDidFetch(movies)
            }, onError: { (error) in
                self.output?.nowPlayingMoviesDidError(MovieListNotFoundError(message: "Houve um erro inesperado ao buscar os filmes, tente novamente."))
            })
        )
    }
    
    func fetchTopRatedMovies() {
        add(movieService.getTopRated(page: 1, region: "BR")
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (results) in
                guard let movies = results.results else {
                    self.output?.topRatedMoviesDidError(MovieListNotFoundError(message: "Não há nenhum filme disponível."))
                    return
                }
                
                self.output?.topRatedMoviesDidFetch(movies)
            }, onError: { (error) in
                self.output?.topRatedMoviesDidError(MovieListNotFoundError(message: "Houve um erro inesperado ao buscar os filmes, tente novamente."))
            })
        )
    }
    
    func fetchUpcomingMovies() {
        add(movieService.getUpcoming(page: 1, region: "US")
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (results) in
                guard let movies = results.results else {
                    self.output?.upcomingMoviesDidError(MovieListNotFoundError(message: "Não há nenhum filme disponível."))
                    return
                }
                
                self.output?.upcomingMoviesDidFetch(movies)
            }, onError: { (error) in
                self.output?.upcomingMoviesDidError(MovieListNotFoundError(message: "Houve um erro inesperado ao buscar os filmes, tente novamente."))
            })
        )
    }
}
