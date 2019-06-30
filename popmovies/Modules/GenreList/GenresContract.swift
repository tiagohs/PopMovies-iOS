//
//  GenresContract.swift
//  popmovies
//
//  Created by Tiago Silva on 24/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import RxSwift

protocol IGenresView: BaseViewInterface {
    
    func bindgenres(genres: [Genre])
}

protocol IGenresPresenter: BasePresenter {
    
    func fetchGenres()
}

protocol IGenresInteractor {
    
    func fetchGenres() -> Observable<[Genre]>
}

