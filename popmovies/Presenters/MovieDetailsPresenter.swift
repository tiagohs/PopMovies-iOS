//
//  MovieDetailsPresenter.swift
//  popmovies
//
//  Created by Tiago Silva on 18/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import RxSwift

class MovieDetailsPresenter: BasePresenter, IMovieDetailsPresenter {
    
    var view: IMovieDetailsView? = nil
    var interactor: IMovieDetailsInteractor? = nil
    
    init(view: IMovieDetailsView) {
        super.init()
        
        self.view = view
        self.interactor = MovieDetailsInteractor(presenter: self)
    }
    
    override func onDestroy() {
        view = nil
        interactor = nil
    }
    
    func fetchMovieDetails(movieId: Int?) {
        if let id = movieId {
            add(d:
                interactor?.fetchMovieDetails(movieId: id)
                    .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
                    .observeOn(MainScheduler.instance)
                    .subscribe(onNext: { (movie) in
                        self.view?.bindMovie(movie: movie)
                        
                        self.fetchMovieRankings(imdbId: movie.imdbID)
                    }, onError: { (error) in
                        //
                    })
            )
        }
    }
    
    private func fetchMovieRankings(imdbId: String?) {
        if let imdb = imdbId {
            add(d:
                interactor?.fetchMovieRankings(imdbId: imdb)
                    .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
                    .observeOn(MainScheduler.instance)
                    .subscribe(onNext: { (movie) in
                        self.view?.bindMovieRankings(movie: movie)
                    }, onError: { (error) in
                        //
                    })
            )
        }
    }
    
    func fetchMovieImages(movieId: Int?) {
        if let id = movieId {
            add(d:
                interactor?.fetchMovieImages(movieId: id)
                    .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
                    .observeOn(MainScheduler.instance)
                    .subscribe(onNext: { (images) in
                        self.view?.bindMovieImages(images: images)
                    }, onError: { (error) in
                        //
                    })
            )
        }
    }
}
