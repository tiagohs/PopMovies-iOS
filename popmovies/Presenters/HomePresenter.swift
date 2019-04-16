//
//  HomePresenter.swift
//  popmovies
//
//  Created by Tiago Silva on 11/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation

class HomePresenter: BasePresenter, IHomePresenter {
    
    var _view: IHomeView?
    var interactor: IHomeInteractor?
    
    init(view: IHomeView) {
        super.init()
        
        _view = view
        interactor = HomeInteractor(homePresenter: self)
    }
    
    func fetchPopularMovies() {
        let disposible = interactor?.fetchPopularMovies(page: 1)
                                    .subscribe(onNext: { (results) in
                                        if results.results != nil {
                                            let featureMovies = results.results![0..<5]
                                            
                                            self._view?.bindFeatureMovies(featureMovies: Array(featureMovies))
                                        }
                                    }, onError: { (error) in
                                        print(error)
                                    })
        
        add(d: disposible)
    }
}
