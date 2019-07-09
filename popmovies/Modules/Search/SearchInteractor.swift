
//
//  SearchInteractor.swift
//  popmovies
//
//  Created by Tiago Silva on 08/07/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation
import RxSwift

// MARK: SearchInteractor: BaseInteractor

class SearchInteractor: BaseInteractor {
    let movieService: MovieServiceInterface
    
    var output: SearchInteractorOutputInterface?
    
    init(output: SearchInteractorOutputInterface?) {
        self.output = output
        self.movieService = MovieService()
    }
}

// MARK: SearchInteractorInputInterface - Output lifecycle Methods

extension SearchInteractor: SearchInteractorInputInterface {
    
    func outputDidLoad() {}
    
    func outputFinished() {
        
    }
    
}

extension SearchInteractor {
    
    func searchMovie(with query: String, page: Int) {
        add(movieService.searchMovie(with: query, page: page, language: "pt_BR", region: "BR")
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
                
                self.output?.didSearchMovieFetch(movies, totalPages)
            }, onError: { (error) in
                self.onError()
            })
        )
    }
    
    private func onError(message: String = "Houve um erro ou não encontramos nenhum filme.") {
        self.output?.didSearchMovieError(DefaultError(message: message))
    }
}

