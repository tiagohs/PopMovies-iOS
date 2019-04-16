//
//  HomeContract.swift
//  popmovies
//
//  Created by Tiago Silva on 11/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation
import RxSwift

protocol IHomeView: IBaseView {
    
    func bindFeatureMovies(featureMovies: [Movie])
}

protocol IHomePresenter: IBasePresenter {
    func fetchPopularMovies()
}

protocol IHomeInteractor {
    func fetchPopularMovies(page: Int) -> Observable<Results<Movie>>
}
