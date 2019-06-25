//
//  MovieListPresenter.swift
//  popmovies
//
//  Created by Tiago Silva on 24/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation
import RxSwift

class MovieListPresenter: BasePresenter, IMovieListPresenter {
    
    var view: IMovieListView!
    var interactor: IMovieListInteractor!
    
    var page: Int = 1
    var totalPage: Int = 1
    
    init(view: IMovieListView) {
        self.view = view
        self.interactor = MovieListInteractor()
    }
    
    func fetchMoviesFrom(url: String?, parameters: [String : String]?) {
        if page > totalPage { return }
        
        guard let url = url else {
            return
        }
        guard let baseParameters = parameters else {
            return
        }
        
        let parameters = baseParameters.merge(with: [
            "page": String(page)
        ])
        
        add(interactor.fetchMoviesFrom(url: url, parameters: parameters)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (moviesResult) in
                guard let movies = moviesResult.results else {
                    return
                }
                guard let totalPages = moviesResult.total_pages else {
                    return
                }
                
                self.totalPage = totalPages
                self.page += 1
                
                self.view.bindMovies(movies: movies)
            }, onError: { (error) in
                //
            })
        )
    }
}
