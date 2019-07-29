//
//  WeekInteractor.swift
//  popmovies
//
//  Created by Tiago Silva on 30/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation
import RxSwift

// MARK: WeekInteractor: BaseInteractor

class WeekInteractor: BaseInteractor {
    
    var movieService: MovieServiceInterface!
    
    var output: WeekInteractorOutputInterface?
    
    init(output: WeekInteractorOutputInterface?) {
        self.output = output
        self.movieService = MovieService()
    }
}

// MARK: WeekInteractorInputInterface - Output Lifecycle Methods

extension WeekInteractor: WeekInteractorInputInterface {
    
    func outputDidLoad() {}
    
    func outputFinished() {
        disposibles.dispose()
    }
    
}

// MARK: WeekInteractorInputInterface - Fetch Methods

extension WeekInteractor {
    
    func fetchMoviesFromCurrentWeek(discoverModel: DiscoverMovie, page: Int, language: LocaleDTO) {
        let languageFormat = Locale.getCurrentAppLangAndRegion()
        
        add(movieService.getMovieDiscover(page: page, discoverMovie: discoverModel, language: languageFormat)
                    .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
                    .observeOn(MainScheduler.instance)
                    .subscribe(onNext: { (moviesResult) in
                        guard let movies = moviesResult.results else {
                            self.output?.moviesFromCurrentWeekDidError(DefaultError(message: R.string.localizable.weekUnknownError()))
                            return
                        }
                        
                        self.output?.moviesFromCurrentWeekDidFetch(movies)
                    }, onError: { (error) in
                        self.output?.moviesFromCurrentWeekDidError(DefaultError(message: R.string.localizable.weekUnknownError()))
                    })
        )
    }
}
