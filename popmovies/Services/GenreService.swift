//
//  GenreService.swift
//  popmovies
//
//  Created by Tiago Silva on 24/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation
import RxSwift
import RxAlamofire

// MARK: IGenreService

protocol IGenreService {
    
    func fetchGenres(language: String) -> Observable<[Genre]>
}

// MARK: GenreService: IGenreService

class GenreService: IGenreService {
    
    func fetchGenres(language: String) -> Observable<[Genre]> {
        let url = TMDB.URL.GENRES.GENRES_LIST
        let parameters = TMDB.URL.GENRES.buildPersonDetailsParameters(language)
        
        return requestJSON(.get, url, parameters: parameters)
            .debug()
            .mapObject(type: GenreResult.self)
            .map({ (genreResult) -> [Genre] in genreResult.genres ?? [] })
    }
}
