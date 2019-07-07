//
//  GenreServiceInterface.swift
//  popmovies
//
//  Created by Tiago Silva on 06/07/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import RxSwift
import RxAlamofire

// MARK: GenreServiceInterface

protocol GenreServiceInterface {
    
    func getGenres(language: String) -> Observable<[Genre]>
    func getMoviesByGenre(genreId: Int, page: Int, language: String) -> Observable<Results<Movie>>
}
