//
//  MovieService.swift
//  popmovies
//
//  Created by Tiago Silva on 14/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation
import RxSwift
import RxAlamofire

protocol IMovieService {
    func getPopularMovies(page: Int) -> Observable<Results<Movie>>
}

class MovieService: BaseService, IMovieService {
    
    var serviceUrl: String = ""
    
    override init() {
        super.init()
        
        serviceUrl = "\(baseUrl)movie"
    }
    
    func getPopularMovies(page: Int) -> Observable<Results<Movie>> {
        let parameters = baseParameters.merge(with: ["page": String(page)])
        let url = "\(serviceUrl)/popular"
        
        return requestJSON(.get, url, parameters: parameters)
                    .mapObject(type: Results<Movie>.self)
    }
    
    func getDetails(movieId: Int, appendToResponse: [String]) -> Observable<Movie> {
        let appendToResponse = createAppendToResponse(appendToResponse: appendToResponse)
        let parameters = baseParameters.merge(with: [
            "movie_id": String(movieId),
            "append_to_response": appendToResponse
        ])
        let url = "\(serviceUrl)/\(movieId)"
        
        return requestJSON(.get, url, parameters: parameters)
                    .debug()
                    .mapObject(type: Movie.self)
    }
}
