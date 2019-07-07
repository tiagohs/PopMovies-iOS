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

// MARK: GenreService: GenreServiceInterface

class GenreService: GenreServiceInterface {
    
    func getGenres(language: String) -> Observable<[Genre]> {
        let url = TMDB.URL.GENRES.GENRES_LIST_URL
        let parameters = TMDB.URL.GENRES.buildPersonDetailsParameters(language)
        
        return requestJSON(.get, url, parameters: parameters)
            .debug()
            .mapObject(type: GenreResult.self)
            .map({ (genreResult) -> [Genre] in genreResult.genres ?? [] })
    }
    
    func getMoviesByGenre(genreId: Int, page: Int, language: String) -> Observable<Results<Movie>> {
        let url = TMDB.URL.GENRES.buildMovieListByGenreUrl(genreId)
        let parameters = TMDB.URL.GENRES.buildMovieListByGenreParameters("BR", page, language)
        
        return requestJSON(.get, url, parameters: parameters)
            .debug()
            .mapObject(type: Results<Movie>.self)
    }
}
