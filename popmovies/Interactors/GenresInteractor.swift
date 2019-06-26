//
//  GenresInteractor.swift
//  popmovies
//
//  Created by Tiago Silva on 24/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation
import RxSwift

class GenresIntractor: IGenresInteractor {
    
    var service: IGenreService!
    
    init() {
        self.service = GenreService()
    }
    
    func fetchGenres() -> Observable<[Genre]> {
        let language = "pt_BR"
        
        return service.getGenres(language: language)
    }
}
