//
//  GenresInteractor.swift
//  popmovies
//
//  Created by Tiago Silva on 24/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation
import RxSwift

// MARK: GenreListIntractor: BaseInteractor

class GenreListIntractor: BaseInteractor {
    let service: GenreServiceInterface
    
    var output: GenreListInteractorOutputInterface?
    
    init(output: GenreListInteractorOutputInterface?) {
        self.output = output
        self.service = GenreService()
    }
    
}

// MARK: GenresInteractorInputInterface - Output lifecycle Methods

extension GenreListIntractor: GenreListInteractorInputInterface {
    
    func outputDidLoad() {}
    
    func outputFinished() {
        disposibles.dispose()
        
        self.output = nil
    }
}

// MARK: GenresInteractorInputInterface - Fetch methods

extension GenreListIntractor {
    
    func fetchGenres() {
        add(service.getGenres(language: Locale.getCurrentAppLangAndRegion())
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (genres) in
                self.output?.genresDidFetch(genres)
            }, onError: { (error) in
                self.output?.genresDidError(DefaultError(message: R.string.localizable.genresNotFound()))
            })
        )
    }
}
