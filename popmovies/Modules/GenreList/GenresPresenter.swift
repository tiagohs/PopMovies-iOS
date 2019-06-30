//
//  GenresPresenter.swift
//  popmovies
//
//  Created by Tiago Silva on 24/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation
import RxSwift

class GenresPresenter: BasePresenter, IGenresPresenter {
    
    var view: IGenresView!
    var interactor: IGenresInteractor!
    
    init(view: IGenresView) {
        super.init()
        
        self.view = view
        self.interactor = GenresIntractor()
    }
    
    func fetchGenres() {
        add(interactor.fetchGenres()
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (genres) in
                self.view?.bindgenres(genres: genres)
            }, onError: { (error) in
                //
            })
        )
    }
}
