//
//  TMDB.swift
//  popmovies
//
//  Created by Tiago Silva on 25/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation

struct TMDB {
    
    static let API_KEY              = "dac4d50f24dee29513738d8fa3470a3f"
    static let BASE_URL             = "https://api.themoviedb.org/3/"
    static let BASE_IMAGE_URL       = "https://image.tmdb.org/t/p/"
    
    struct Parameters {
        static let apiKey                   = "api_key"
        static let language                 = "language"
        static let append_to_response       = "append_to_response"
        static let include_image_language   = "include_image_language"
        static let page                     = "page"
        static let region                   = "region"
        static let query                    = "query"
        static let sort_by                  = "sort_by"
        static let certification_country    = "certification_country"
        static let certification            = "certification"
        static let certification_lte        = "certification.lte"
        static let include_adult            = "include_adult"
        static let include_video            = "include_video"
        static let primary_release_year     = "primary_release_year"
        static let primary_release_date_gte = "primary_release_date.gte"
        static let primary_release_date_lte = "primary_release_date.lte"
        static let release_date_gte         = "release_date.gte"
        static let release_date_lte         = "release_date.lte"
        static let vote_count_gte           = "vote_count.gte"
        static let with_cast                = "with_cast"
        static let with_crew                = "with_crew"
        static let with_companies           = "with_companies"
        static let with_genres              = "with_genres"
        static let with_keywords            = "with_keywords"
        static let with_people              = "with_people"
        static let without_genres           = "without_genres"
        static let without_keywords         = "without_keywords"
        static let with_runtime_gte         = "with_runtime.gte"
        static let with_runtime_lte         = "with_runtime.lte"
        static let with_release_type        = "with_release_type"
        static let with_original_language   = "with_original_language"
        static let tagged_images            = "tagged_images"
        static let images                   = "images"
        static let movie_credits            = "movie_credits"
        static let external_ids             = "external_ids"
    }
    
    struct URL {
        struct MOVIES {
            static let BASE_URL                 = "\(TMDB.BASE_URL)movie"
            static let POPULAR_MOVIES_URL       = "\(BASE_URL)/popular"
            static let UPCOMING_MOVIES_URL      = "\(BASE_URL)/upcoming"
            static let TOP_RATED_MOVIES_URL     = "\(BASE_URL)/top_rated"
            static let NOW_PLAYING_MOVIES_URL   = "\(BASE_URL)/now_playing"
            static let DISCOVER_MOVIES_URL      = "\(TMDB.BASE_URL)discover/movie"
            static let SEARCH_MOVIES_URL      = "\(TMDB.BASE_URL)search/movie"
            
            static func buidMovieDetailsUrl(movieId: Int) -> String {
                return "\(TMDB.BASE_URL)movie/\(String(describing: movieId))"
            }
            
            static func buidVideosUrl(movieId: Int) -> String {
                let movieDetailsUrl = buidMovieDetailsUrl(movieId: movieId)
                
                return "\(movieDetailsUrl)/videos"
            }
            
            static func buildImagesUrl(movieId: Int) -> String {
                let movieDetailsUrl = buidMovieDetailsUrl(movieId: movieId)
                
                return "\(movieDetailsUrl)/images"
            }
            
            static func buildSimilarMoviesUrl(movieId: Int) -> String {
                let movieDetailsUrl = buidMovieDetailsUrl(movieId: movieId)
                
                return "\(movieDetailsUrl)/similar"
            }
            
            static func buildTranslationsMoviesUrl(movieId: Int) -> String {
                let movieDetailsUrl = buidMovieDetailsUrl(movieId: movieId)
                
                return "\(movieDetailsUrl)/translations"
            }
            
            static func buildSearchParameters(_ query: String, _ region: String = "BR",_ page: Int = 1,_ language: String = "pt_BR") -> [String : String] {
                return [
                    Parameters.apiKey: API_KEY,
                    Parameters.language: language,
                    Parameters.page: String(page),
                    Parameters.region: region,
                    Parameters.query: query
                ]
            }
            
            static func buildMovieListParameters(_ region: String = "BR",_ page: Int = 1,_ language: String = "pt_BR") -> [String : String] {
                return [
                    Parameters.apiKey: API_KEY,
                    Parameters.language: language,
                    Parameters.page: String(page),
                    Parameters.region: region
                ]
            }
            
            static func buildMovieDiscoverParameters(_ discoverModel: DiscoverMovie,_ page: Int = 1, _ language: String = "pt_BR") -> [ String : String ] {
                var parameters = [
                    Parameters.apiKey: API_KEY,
                    Parameters.language: language,
                    Parameters.page: String(page),
                    Parameters.append_to_response: URL.buildParameterListValue(discoverModel.appendToResponse),
                    Parameters.include_adult: String(discoverModel.includeAdult),
                    Parameters.include_video: String(discoverModel.includeVideo)
                ]
                
                URL.addStringValueNotNull(key: TMDB.Parameters.region, value: discoverModel.region, &parameters)
                URL.addStringValueNotNull(key: TMDB.Parameters.sort_by, value: discoverModel.sortBy, &parameters)
                URL.addStringValueNotNull(key: TMDB.Parameters.vote_count_gte, value: discoverModel.voteCountGte, &parameters)
                
                URL.addStringValueNotNull(key: TMDB.Parameters.release_date_gte, value: discoverModel.releaseDateGte, &parameters)
                URL.addStringValueNotNull(key: TMDB.Parameters.release_date_lte, value: discoverModel.releaseDateLte, &parameters)
                URL.addStringValueNotNull(key: TMDB.Parameters.primary_release_date_gte, value: discoverModel.primaryReleaseDateGte, &parameters)
                URL.addStringValueNotNull(key: TMDB.Parameters.primary_release_date_lte, value: discoverModel.primaryRelaseDateLte, &parameters)
                URL.addStringValueNotNull(key: TMDB.Parameters.primary_release_year, value: discoverModel.primaryReleaseYear, &parameters)
                
                URL.addStringValueNotNull(key: TMDB.Parameters.certification_country, value: discoverModel.certificationCountry, &parameters)
                URL.addStringValueNotNull(key: TMDB.Parameters.certification, value: discoverModel.certification, &parameters)
                URL.addStringValueNotNull(key: TMDB.Parameters.certification_lte, value: discoverModel.certificationLte, &parameters)
                
                URL.addStringValueNotNull(key: TMDB.Parameters.with_genres, value: discoverModel.withGenres, &parameters)
                URL.addStringValueNotNull(key: TMDB.Parameters.with_keywords, value: discoverModel.withKeywords, &parameters)
                URL.addStringValueNotNull(key: TMDB.Parameters.with_cast, value: discoverModel.withCast, &parameters)
                URL.addStringValueNotNull(key: TMDB.Parameters.with_crew, value: discoverModel.withCrew, &parameters)
                URL.addStringValueNotNull(key: TMDB.Parameters.with_people, value: discoverModel.withPeople, &parameters)
                URL.addStringValueNotNull(key: TMDB.Parameters.with_companies, value: discoverModel.withCompanies, &parameters)
                URL.addIntValueNotNull(key: TMDB.Parameters.with_runtime_gte, value: discoverModel.withRuntimeGte, &parameters)
                URL.addIntValueNotNull(key: TMDB.Parameters.with_runtime_lte, value: discoverModel.withRuntimeLte, &parameters)
                URL.addStringValueNotNull(key: TMDB.Parameters.with_release_type, value: discoverModel.withReleaseType, &parameters)
                
                URL.addIntValueNotNull(key: TMDB.Parameters.without_genres, value: discoverModel.withoutGenres, &parameters)
                URL.addIntValueNotNull(key: TMDB.Parameters.without_keywords, value: discoverModel.withoutKeywords, &parameters)
                
                URL.addStringValueNotNull(key: TMDB.Parameters.with_original_language, value: discoverModel.withOriginalLanguage, &parameters)
                
                return parameters
            }
            
            static func buildMovieDetailsParameters(_ appendToResponse: [String],_ language: String) -> [String : String] {
                return [
                    Parameters.apiKey: API_KEY,
                    Parameters.language: language,
                    Parameters.append_to_response: URL.buildParameterListValue(appendToResponse)
                ]
            }
            
            static func buildTranslationsParameters() -> [String : String] {
                return [
                    Parameters.apiKey: API_KEY
                ]
            }
            
            static func buildImagesParameters(_ includeImageLanguage: [String],_ language: String?) -> [String : String] {
                var parameters = [
                    Parameters.apiKey: API_KEY,
                    Parameters.include_image_language: URL.buildParameterListValue(includeImageLanguage)
                ]
                
                if language != nil {
                    parameters.append(with: [
                        Parameters.language: language!
                        ]
                    )
                }
                
                return parameters
            }
            
            static func buildImagesParameters(_ language: String?) -> [String : String] {
                var parameters = [
                    Parameters.apiKey: API_KEY
                ]
                
                if language != nil {
                    parameters.append(with: [
                        Parameters.language: language!
                        ]
                    )
                }
                
                return parameters
            }
            
            static func buildVideosParameters(_ language: String?) -> [String : String] {
                var parameters = [
                    Parameters.apiKey: API_KEY,
                ]
                
                if language != nil {
                    parameters.append(with: [
                        Parameters.language: language!
                        ]
                    )
                }
                
                return parameters
            }
            
        }
        
        struct PERSON {
            static let BASE_URL         = "\(TMDB.BASE_URL)person"
            
            static func buidPersonDetailsUrl(personId: Int) -> String {
                return "\(TMDB.BASE_URL)person/\(String(describing: personId))"
            }
            
            static func buildPersonMovieCreditsUrl(personId: Int) -> String {
                let personDetailsUrl = buidPersonDetailsUrl(personId: personId)
                
                return "\(personDetailsUrl)/movie_credits"
            }
            
            static func buildTranslationsPersonUrl(personId: Int) -> String {
                let personDetailsUrl = buidPersonDetailsUrl(personId: personId)
                
                return "\(personDetailsUrl)/translations"
            }
            
            static func buildImagesUrl(personId: Int) -> String {
                let personDetailsUrl = buidPersonDetailsUrl(personId: personId)
                
                return "\(personDetailsUrl)/images"
            }
            
            static func buildTaggedImagesUrl(personId: Int) -> String {
                let personDetailsUrl = buidPersonDetailsUrl(personId: personId)
                
                return "\(personDetailsUrl)/tagged_images"
            }
            
            static func buildPersonDetailsParameters(_ appendToResponse: [String],_ language: String) -> [String : String] {
                return [
                    Parameters.apiKey: API_KEY,
                    Parameters.language: language,
                    Parameters.append_to_response: URL.buildParameterListValue(appendToResponse)
                ]
            }
            
            static func buildTranslationsParameters() -> [String : String] {
                return [
                    Parameters.apiKey: API_KEY
                ]
            }
            
            static func buildImagesParameters() -> [String : String] {
                return [
                    Parameters.apiKey: API_KEY
                ]
            }
            
            static func buildTaggedImagesParameters(_ language: String?) -> [String : String] {
                var parameters = [
                    Parameters.apiKey: API_KEY,
                ]
                
                if language != nil {
                    parameters.append(with: [
                        Parameters.language: language!
                        ]
                    )
                }
                
                return parameters
            }
            
        }
        
        struct GENRES {
            static let BASE_URL                 = "\(TMDB.BASE_URL)genre"
            static let GENRES_LIST_URL          = "\(BASE_URL)/movie/list"
            
            static func buildMovieListByGenreUrl(_ genreId: Int) -> String {
                return "\(BASE_URL)/\(String(describing: genreId))/movies"
            }
            
            static func buildPersonDetailsParameters(_ language: String) -> [String : String] {
                return [
                    Parameters.apiKey: API_KEY,
                    Parameters.language: language
                ]
            }
            
            static func buildMovieListByGenreParameters(_ region: String = "BR",_ page: Int = 1,_ language: String = "pt_BR") -> [ String : String ] {
                return MOVIES.buildMovieListParameters(region, page, language)
            }
        }
        
        static func buildParameterListValue(_ list: [String]) -> String {
            return list.joined(separator: ",")
        }
        
        static func addStringValueNotNull(key: String, value: String?, _ parameters: inout [String : String]) {
            guard let value = value else {
                return
            }
            
            parameters.append(with: [key : value])
        }
        
        static func addIntValueNotNull(key: String, value: Int?, _ parameters: inout [String : String]) {
            guard let value = value else {
                return
            }
            
            parameters.append(with: [key : String(value)])
        }
    }
    
    struct ImageSize {
        struct BACKDROP {
            static let w300         = "w300"
            static let w780         = "w780"
            static let w1280        = "w1280"
            static let original     = "original"
        }
        
        struct LOGO {
            static let w45          = "w45"
            static let w92          = "w92"
            static let w154         = "w154"
            static let w185         = "w185"
            static let w300         = "w300"
            static let w500         = "w500"
            static let original     = "original"
        }
        
        struct POSTER {
            static let w92          = "w92"
            static let w154         = "w154"
            static let w185         = "w185"
            static let w342         = "w342"
            static let w500         = "w500"
            static let w780         = "w780"
            static let original     = "original"
        }
        
        struct PROFILE {
            static let w45          = "w45"
            static let w185         = "w185"
            static let w632         = "w632"
            static let original     = "original"
        }
        
        struct STILL {
            static let w92          = "w92"
            static let w185         = "w185"
            static let w300         = "w300"
            static let original     = "original"
        }
    }
    
    static let GENRES_IMAGES = [
        28:     R.image.action.name,
        12:     R.image.adventure.name,
        16:     R.image.animation.name,
        35:     R.image.comedy.name,
        80:     R.image.crime.name,
        99:     R.image.documentary.name,
        18:     R.image.drama.name,
        10751:  R.image.family.name,
        14:     R.image.fantasy.name,
        36:     R.image.history.name,
        27:     R.image.horror.name,
        10402:  R.image.music.name,
        9648:   R.image.mistery.name,
        10749:  R.image.romance.name,
        878:    R.image.science_fiction.name,
        10770:  R.image.tv_movie.name,
        53:     R.image.thriller.name,
        10752:  R.image.war.name,
        37:     R.image.westeron.name
    ]
    
    static let GENRES_ID = [
        28:     "Action",
        12:     "Adventure",
        16:     "Animation",
        35:     "Comedy",
        80:     "Crime",
        99:     "Documentary",
        18:     "Drama",
        10751:  "Family",
        14:     "Fantasy",
        36:     "History",
        27:     "Horror",
        10402:  "Music",
        9648:   "Mistery",
        10749:  "Romance",
        878:    "Science Fiction",
        10770:  "TV Movie",
        53:     "Thriller",
        10752:  "War",
        37:     "Westeron"
    ]
    
}
