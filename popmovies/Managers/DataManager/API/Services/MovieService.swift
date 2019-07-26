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

// MARK: MovieService: MovieServiceInterface

class MovieService: MovieServiceInterface {
    
    func getMovieRankings(imdbId: String) -> Observable<MovieOMDB> {
        let baseUrl = OMDB.BASE_URL
        let parameters = OMDB.URL.buildMovieRankingsParameters(imdbId)
        
        return requestJSON(.get, baseUrl, parameters: parameters)
            .debug()
            .mapObject(type: MovieOMDB.self)
    }
    
    func getDetails(movieId: Int, appendToResponse: [String], language: String = "pt_BR") -> Observable<Movie> {
        let url = TMDB.URL.MOVIES.buidMovieDetailsUrl(movieId: movieId)
        let parameters = TMDB.URL.MOVIES.buildMovieDetailsParameters(appendToResponse, language)
        
        return requestJSON(.get, url, parameters: parameters)
                    .debug()
                    .mapObject(type: Movie.self)
    }
    
    func getImages(movieId: Int, includeImageLanguage: [String], language: String? = nil) -> Observable<Images> {
        let url = TMDB.URL.MOVIES.buildImagesUrl(movieId: movieId)
        let parameters = TMDB.URL.MOVIES.buildImagesParameters(includeImageLanguage, language)
        
        return requestJSON(.get, url, parameters: parameters)
            .debug()
            .mapObject(type: Images.self)
    }
    
    func getImages(movieId: Int, language: String) -> Observable<Images> {
        let url = TMDB.URL.MOVIES.buildImagesUrl(movieId: movieId)
        let parameters = TMDB.URL.MOVIES.buildImagesParameters(language)
        
        return requestJSON(.get, url, parameters: parameters)
            .debug()
            .mapObject(type: Images.self)
    }
    
    func getAllImages(movieId: Int, language: String) -> Observable<ImageResultDTO> {
        let imageResultDTO = ImageResultDTO()
        
        imageResultDTO.translations = []
        imageResultDTO.images = []
        
        return getTranslations(movieId: movieId)
            .concatMap({ (translationResult) -> Observable<ImageResultDTO> in
                imageResultDTO.translations = translationResult.translationList ?? []
                
                let translationDefault = Translation()
                translationDefault.iso_639_1 = "null"
                
                translationResult.translationList?.append(translationDefault)
                
                return Observable.from(translationResult.translationList ?? [])
                                .flatMap({ (translation) -> Observable<Images> in
                                    let language = translation.iso_639_1 != "null" ? "\(String(describing: translation.iso_639_1 ?? ""))_\(String(translation.iso_3166_1 ?? "")))" : "null"
                                    
                                    return self.getImages(movieId: movieId, language: language)
                                        .do(onNext: { (images) in
                                            imageResultDTO.images += self.mergeImages(images)
                                        })
                                })
                .map({ (taggedImages) -> ImageResultDTO in return imageResultDTO })
            })
    }
    
    private func mergeImages(_ images: Images) -> [Image] {
        let posters = images.backdrops ?? []
        let backdrop = images.posters ?? []
        
        if (posters.count > 3 && backdrop.count > 3) {
            return Array(backdrop[0..<3]) + Array(posters[0..<3])
        }
        
        return Array(Set(backdrop + posters))
    }
    
    func getVideos(movieId: Int, language: String? = nil) -> Observable<Results<Video>> {
        let url = TMDB.URL.MOVIES.buidVideosUrl(movieId: movieId)
        let parameters = TMDB.URL.MOVIES.buildVideosParameters(language)
        
        return requestJSON(.get, url, parameters: parameters)
            .debug()
            .mapObject(type: Results<Video>.self)
    }
    
    func getAllVideos(movieId: Int, language: String) -> Observable<VideoResultDTO> {
        var allVideos: [Video] = []
        
        return getTranslations(movieId: movieId)
            .concatMap({ (translationResult) -> Observable<VideoResultDTO> in
                return
                    Observable.from(translationResult.translationList ?? [])
                                .flatMap({ (translation) -> Observable<Results<Video>> in
                                    let language = "\(String(describing: translation.iso_639_1 ?? ""))_\(String(translation.iso_3166_1 ?? "")))"
                                    return self.getVideos(movieId: movieId, language: language)
                                                .do(onNext: { (videoResults) in
                                                    guard let videos =  videoResults.results else {
                                                        return
                                                    }
                                                    
                                                    allVideos += videos
                                                })
                                })
                        .map({ _ -> VideoResultDTO in
                            let videoResultDTO = VideoResultDTO()
                            
                            videoResultDTO.videos = allVideos
                            videoResultDTO.translations = translationResult.translationList ?? []
                            
                            return videoResultDTO
                        })
            })
    }
    
    func getTranslations(movieId: Int) -> Observable<TranslationResults> {
        let url = TMDB.URL.MOVIES.buildTranslationsMoviesUrl(movieId: movieId)
        let parameters = TMDB.URL.MOVIES.buildTranslationsParameters()
        
        return requestJSON(.get, url, parameters: parameters)
            .debug()
            .mapObject(type: TranslationResults.self)
    }
    
    func searchMovie(with query: String, page: Int, language: String, region: String = "BR") -> Observable<Results<Movie>> {
        let url = TMDB.URL.MOVIES.SEARCH_MOVIES_URL
        let parameters = TMDB.URL.MOVIES.buildSearchParameters(query, region, page, language)
        
        return requestJSON(.get, url, parameters: parameters)
            .debug()
            .mapObject(type: Results<Movie>.self)
    }
    
    func getMovieDiscover(page: Int, discoverMovie: DiscoverMovie) -> Observable<Results<Movie>> {
        let url = TMDB.URL.MOVIES.DISCOVER_MOVIES_URL
        let parameters = TMDB.URL.MOVIES.buildMovieDiscoverParameters(discoverMovie, page, "pt_BR")
        
        return requestJSON(.get, url, parameters: parameters)
            .debug()
            .mapObject(type: Results<Movie>.self)
    }
    
    func getSimilarMovies(movieId: Int, page: Int, region: String = "BR") -> Observable<Results<Movie>> {
        let url = TMDB.URL.MOVIES.buildSimilarMoviesUrl(movieId: movieId)
        
        return buildMovieList(url: url, region: region, page: page)
    }
    
    func getNowPlaying(page: Int, region: String = "BR") -> Observable<Results<Movie>> {
        let url = TMDB.URL.MOVIES.NOW_PLAYING_MOVIES_URL
        
        return buildMovieList(url: url, region: region, page: page)
    }
    
    func getTopRated(page: Int, region: String = "BR") -> Observable<Results<Movie>> {
        let url = TMDB.URL.MOVIES.TOP_RATED_MOVIES_URL
        
        return buildMovieList(url: url, region: region, page: page)
    }
    
    func getUpcoming(page: Int, region: String = "BR") -> Observable<Results<Movie>> {
        let url = TMDB.URL.MOVIES.UPCOMING_MOVIES_URL
        
        return buildMovieList(url: url, region: region, page: page)
    }
    
    func getPopularMovies(page: Int, region: String = "BR") -> Observable<Results<Movie>> {
        let url = TMDB.URL.MOVIES.POPULAR_MOVIES_URL
        
        return buildMovieList(url: url, region: region, page: page)
    }
    
    func getMovieList(url: String, paramenters: [String : String]) -> Observable<Results<Movie>> {
        return requestJSON(.get, url, parameters: paramenters)
            .debug()
            .mapObject(type: Results<Movie>.self)
    }
    
}

// MARK: Helpers Method

private extension MovieService {
    
    private func buildMovieList(url: String, region: String, page: Int) -> Observable<Results<Movie>> {
        let parameters = TMDB.URL.MOVIES.buildMovieListParameters(region, page)
        
        return requestJSON(.get, url, parameters: parameters)
            .debug()
            .mapObject(type: Results<Movie>.self)
    }
}
