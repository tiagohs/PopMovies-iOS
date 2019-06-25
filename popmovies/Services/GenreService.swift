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

protocol IGenreService {
    
    func fetchGenres(language: String) -> Observable<[Genre]>
}

class GenreService: BaseService, IGenreService {
    var serviceUrl: String = ""
    
    override init() {
        super.init()
        
        serviceUrl = "\(baseUrl)genre"
    }
    
    func fetchGenres(language: String) -> Observable<[Genre]> {
        let parameters = [
            Constants.TMDB.Parameters.apiKey: Constants.TMDB.API_KEY,
            Constants.TMDB.Parameters.language: language
        ]
        let url = "\(serviceUrl)/movie/list"
        
        return requestJSON(.get, url, parameters: parameters)
            .debug()
            .mapObject(type: GenreResult.self)
            .map({ (genreResult) -> [Genre] in genreResult.genres ?? [] })
    }
}
