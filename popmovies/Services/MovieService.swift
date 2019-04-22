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
    func getDetails(movieId: Int, appendToResponse: [String]) -> Observable<Movie>
    func getMovieRankings(imdbId: String) -> Observable<MovieOMDB>
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
        let parameters = [
            Constants.TMDB.Parameters.apiKey: Constants.TMDB.API_KEY,
            Constants.TMDB.Parameters.language: "en_US",
            "append_to_response": appendToResponse
        ]
        let url = "\(serviceUrl)/\(movieId)"
        
        return requestJSON(.get, url, parameters: parameters)
                    .debug()
                    .mapObject(type: Movie.self)
    }
    
    func getMovieRankings(imdbId: String) -> Observable<MovieOMDB> {
        let baseUrl = Constants.OMDB.BASE_URL
        let parameters = [
            Constants.OMDB.Parameters.apiKey: Constants.OMDB.API_KEY,
            Constants.OMDB.Parameters.tomatoes: "true",
            "i": imdbId
        ]
        
        return requestJSON(.get, baseUrl, parameters: parameters)
                        .debug()
                        .mapObject(type: MovieOMDB.self)
    }
}
