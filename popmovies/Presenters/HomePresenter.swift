//
//  HomePresenter.swift
//  popmovies
//
//  Created by Tiago Silva on 11/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import RxSwift

class HomePresenter: BasePresenter, IHomePresenter {
    
    var view: IHomeView?
    var interactor: IHomeInteractor?
    
    init(view: IHomeView) {
        super.init()
        
        self.view = view
        self.interactor = HomeInteractor(homePresenter: self)
    }
    
    override func onDestroy() {
        view = nil
        interactor = nil
    }
    
    func fetchPopularMovies() {
        let disposible = interactor?.fetchPopularMovies(page: 1)
                                    .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
                                    .observeOn(MainScheduler.instance)
                                    .subscribe(onNext: { (results) in
                                        if results.results != nil {
                                            self.view?.bindPopularMovies(movies: results.results!)
                                        }
                                    }, onError: { (error) in
                                        print(error)
                                    })
        
        add(d: disposible)
    }
    
    func fetchNowPlayingMovies() {
        let disposible = interactor?.fetchNowPlayingMovies(page: 1)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (results) in
                if results.results != nil {
                    let movies = results.results![0..<5]
                    
                    self.view?.bindNowPlayingMovies(movies: Array(movies))
                }
            }, onError: { (error) in
                print(error)
            })
        
        add(d: disposible)
    }
    
    func fetchTopRatedMovies() {
        let disposible = interactor?.fetchTopRatedMovies(page: 1)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (results) in
                if results.results != nil {
                    self.view?.bindTopRatedMovies(movies: results.results!)
                }
            }, onError: { (error) in
                print(error)
            })
        
        add(d: disposible)
    }
    
    func fetchUpcomingMovies() {
        let disposible = interactor?.fetchUpcomingMovies(page: 1)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (results) in
                if results.results != nil {
                    self.view?.bindUpcomingMovies(movies: results.results!)
                }
            }, onError: { (error) in
                print(error)
            })
        
        add(d: disposible)
    }
}
