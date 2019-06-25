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
    }
    
    struct URL {
        struct MOVIES {
            static let BASE_URL                 = "\(TMDB.BASE_URL)movie"
            static let POPULAR_MOVIES_URL       = "\(BASE_URL)/popular"
            static let UPCOMING_MOVIES_URL      = "\(BASE_URL)/upcoming"
            static let TOP_RATED_MOVIES_URL     = "\(BASE_URL)/top_rated"
            static let NOW_PLAYING_MOVIES_URL   = "\(BASE_URL)/now_playing"
            
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
            
            static func buildMovieListParameters(_ region: String = "BR",_ page: Int = 1,_ language: String = "pt_BR") -> [String : String] {
                return [
                    Parameters.apiKey: API_KEY,
                    Parameters.language: language,
                    Parameters.page: String(page),
                    Parameters.region: region
                ]
            }
            
            static func buildMovieDetailsParameters(_ appendToResponse: [String],_ language: String) -> [String : String] {
                return [
                    Parameters.apiKey: API_KEY,
                    Parameters.language: language,
                    Parameters.append_to_response: URL.buildParameterListValue(appendToResponse)
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
            
            static func buildPersonDetailsParameters(_ appendToResponse: [String],_ language: String) -> [String : String] {
                return [
                    Parameters.apiKey: API_KEY,
                    Parameters.language: language,
                    Parameters.append_to_response: URL.buildParameterListValue(appendToResponse)
                ]
            }
        }
        
        struct GENRES {
            static let BASE_URL         = "\(TMDB.BASE_URL)genre"
            static let GENRES_LIST      = "\(BASE_URL)/movie/list"
            
            static func buildPersonDetailsParameters(_ language: String) -> [String : String] {
                return [
                    Parameters.apiKey: API_KEY,
                    Parameters.language: language
                ]
            }
        }
        
        static func buildParameterListValue(_ list: [String]) -> String {
            return list.joined(separator: ",")
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
        28:     Constants.IMAGES.GENRE_ACTION,
        12:     Constants.IMAGES.GENRE_ADVENTURE,
        16:     Constants.IMAGES.GENRE_ANIMATION,
        35:     Constants.IMAGES.GENRE_COMEDY,
        80:     Constants.IMAGES.GENRE_CRIME,
        99:     Constants.IMAGES.GENRE_DOCUMENTARY,
        18:     Constants.IMAGES.GENRE_DRAMA,
        10751:  Constants.IMAGES.GENRE_FAMILY,
        14:     Constants.IMAGES.GENRE_FANTASY,
        36:     Constants.IMAGES.GENRE_HISTORY,
        27:     Constants.IMAGES.GENRE_HORROR,
        10402:  Constants.IMAGES.GENRE_MUSIC,
        9648:   Constants.IMAGES.GENRE_MISTERY,
        10749:  Constants.IMAGES.GENRE_ROMANCE,
        878:    Constants.IMAGES.GENRE_SCIENCE_FICTION,
        10770:  Constants.IMAGES.GENRE_TV_MOVIE,
        53:     Constants.IMAGES.GENRE_THRILLER,
        10752:  Constants.IMAGES.GENRE_WAR,
        37:     Constants.IMAGES.GENRE_WESTERON
    ]
}
