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
    
    func getMovieRankings(imdbId: String) -> Observable<MovieOMDB>
    func getDetails(movieId: Int, appendToResponse: [String], language: String) -> Observable<Movie>
    
    func getImages(movieId: Int, includeImageLanguage: [String], language: String?) -> Observable<Images>
    func getVideos(movieId: Int, language: String?) -> Observable<Results<Video>>
    
    func getPopularMovies(page: Int, region: String) -> Observable<Results<Movie>>
    func getNowPlaying(page: Int, region: String) -> Observable<Results<Movie>>
    func getTopRated(page: Int, region: String) -> Observable<Results<Movie>>
    func getUpcoming(page: Int, region: String) -> Observable<Results<Movie>>
}

class MovieService: BaseService, IMovieService {
    var serviceUrl: String = ""
    
    override init() {
        super.init()
        
        serviceUrl = "\(baseUrl)movie"
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
    
    func getDetails(movieId: Int, appendToResponse: [String], language: String = "pt_BR") -> Observable<Movie> {
        let appendToResponse = createAppendToResponse(appendToResponse: appendToResponse)
        let parameters = [
            Constants.TMDB.Parameters.apiKey: Constants.TMDB.API_KEY,
            Constants.TMDB.Parameters.language: language,
            "append_to_response": appendToResponse
        ]
        let url = "\(serviceUrl)/\(movieId)"
        
        return requestJSON(.get, url, parameters: parameters)
                    .debug()
                    .mapObject(type: Movie.self)
    }
    
    func getImages(movieId: Int, includeImageLanguage: [String], language: String? = nil) -> Observable<Images> {
        var parameters = [
            Constants.TMDB.Parameters.apiKey: Constants.TMDB.API_KEY,
            "include_image_language": includeImageLanguage.joined(separator: ",")
        ]
        
        if language != nil {
            parameters.append(with: ["language": language!])
        }
        
        let url = "\(serviceUrl)/\(movieId)/images"
        
        return requestJSON(.get, url, parameters: parameters)
            .debug()
            .mapObject(type: Images.self)
    }
    
    func getVideos(movieId: Int, language: String? = nil) -> Observable<Results<Video>> {
        var parameters = [
            Constants.TMDB.Parameters.apiKey: Constants.TMDB.API_KEY
        ]
        
        if language != nil {
            parameters.append(with: ["language": language!])
        }
        
        let url = "\(serviceUrl)/\(movieId)/videos"
        
        return requestJSON(.get, url, parameters: parameters)
            .debug()
            .mapObject(type: Results<Video>.self)
    }
    
    func getNowPlaying(page: Int, region: String = "BR") -> Observable<Results<Movie>> {
        let url = "\(serviceUrl)/now_playing"
        
        return getMovieList(url: url, region: region, page: page)
    }
    
    func getTopRated(page: Int, region: String = "BR") -> Observable<Results<Movie>> {
        let url = "\(serviceUrl)/top_rated"
        
        return getMovieList(url: url, region: region, page: page)
    }
    
    func getUpcoming(page: Int, region: String = "BR") -> Observable<Results<Movie>> {
        let url = "\(serviceUrl)/upcoming"
        
        return getMovieList(url: url, region: region, page: page)
    }
    
    func getPopularMovies(page: Int, region: String = "BR") -> Observable<Results<Movie>> {
        let url = "\(serviceUrl)/popular"
        
        return getMovieList(url: url, region: region, page: page)
    }
    
    private func getMovieList(url: String, region: String, page: Int) -> Observable<Results<Movie>> {
        let parameters = baseParameters.merge(with: [
            "page": String(page),
            "region": region
        ])
        
        return requestJSON(.get, url, parameters: parameters)
            .debug()
            .mapObject(type: Results<Movie>.self)
    }
}
