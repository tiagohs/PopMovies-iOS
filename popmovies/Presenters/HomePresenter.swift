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
                                            let featureMovies = results.results![0..<5]
                                            
                                            self.view?.bindFeatureMovies(featureMovies: Array(featureMovies))
                                            self.view?.bindWeekMovies(weekMovies: results.results!)
                                        }
                                    }, onError: { (error) in
                                        print(error)
                                    })
        
        add(d: disposible)
    }
}
