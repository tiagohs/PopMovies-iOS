
//
//  SearchInteractor.swift
//  popmovies
//
//  Created by Tiago Silva on 08/07/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation
import RxSwift

// MARK: SearchInteractor: BaseInteractor

class SearchInteractor: BaseInteractor {
    let movieService: MovieServiceInterface
    
    var output: SearchInteractorOutputInterface?
    
    init(output: SearchInteractorOutputInterface?) {
        self.output = output
        self.movieService = MovieService()
    }
}

// MARK: SearchInteractorInputInterface - Output lifecycle Methods

extension SearchInteractor: SearchInteractorInputInterface {
    
    func outputDidLoad() {}
    
    func outputFinished() {
        disposibles.dispose()
        
        self.output = nil
    }
    
}

