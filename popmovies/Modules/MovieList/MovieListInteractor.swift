//
//  MovieListInteractor.swift
//  popmovies
//
//  Created by Tiago Silva on 24/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation
import RxSwift

// MovieListInteractor: BaseInteractor

class MovieListInteractor: BaseInteractor {
    let service: MovieServiceInterface
    
    var output: MovieListInteractorOutputInterface?
    
    init(output: MovieListInteractorOutputInterface?) {
        self.output = output
        self.service = MovieService()
    }
}

// MARK: MovieListInteractorInputInterface - Output Lifecycle Methods

extension MovieListInteractor: MovieListInteractorInputInterface {
    
    func outputDidLoad() {}
    
    func outputFinished() {
        disposibles.dispose()
        
        self.output = nil
    }
}

// MARK: MovieListInteractorInputInterface - Fetch methods

extension MovieListInteractor {
    
    func fetchMovies(from url: String, with parameters: [String : String]) {
        add(service.getMovieList(url: url, paramenters: parameters)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (moviesResult) in
                guard let movies = moviesResult.results else {
                    self.onError()
                    return
                }
                guard let totalPages = moviesResult.total_pages else {
                    self.onError()
                    return
                }
                
                self.output?.moviesDidFetch(movies, totalPages: totalPages)
            }, onError: { (error) in
                self.onError()
            })
        )
    }
    
    private func onError(message: String = R.string.localizable.moviesNotFound()) {
        self.output?.moviesDidError(MovieListNotFoundError(message: message))
    }
}
