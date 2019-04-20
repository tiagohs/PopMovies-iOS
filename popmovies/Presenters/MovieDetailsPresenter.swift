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
        guard let id = movieId else { return }
        
        let disposible = interactor?.fetchMovieDetails(movieId: id)
                    .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
                    .observeOn(MainScheduler.instance)
                    .subscribe(onNext: { (movie) in
                        self.view?.bindMovie(movie: movie)
                    }, onError: { (error) in
                        //
                    })
        
        add(d: disposible)
    }
    
    
}
