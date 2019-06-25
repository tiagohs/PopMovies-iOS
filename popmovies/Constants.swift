//
//  Constants.swift
//  popmovies
//
//  Created by Tiago Silva on 14/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation

struct Constants {
    
    struct TMDB {
        
        static let API_KEY              = "dac4d50f24dee29513738d8fa3470a3f"
        static let BASE_URL             = "https://api.themoviedb.org/3/"
        static let BASE_IMAGE_URL       = "https://image.tmdb.org/t/p/"
        
        struct Parameters {
            static let apiKey           = "api_key"
            static let language         = "language"
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
            28: IMAGES.GENRE_ACTION,
            12: IMAGES.GENRE_ADVENTURE,
            16: IMAGES.GENRE_ANIMATION,
            35: IMAGES.GENRE_COMEDY,
            80: IMAGES.GENRE_CRIME,
            99: IMAGES.GENRE_DOCUMENTARY,
            18: IMAGES.GENRE_DRAMA,
            14: IMAGES.GENRE_FAMILY,
            36: IMAGES.GENRE_HISTORY,
            27: IMAGES.GENRE_HORROR,
            10402: IMAGES.GENRE_MUSIC,
            9648: IMAGES.GENRE_MISTERY,
            10749: IMAGES.GENRE_ROMANCE,
            878: IMAGES.GENRE_SCIENCE_FICTION,
            10770: IMAGES.GENRE_TV_MOVIE,
            53: IMAGES.GENRE_THRILLER,
            10752: IMAGES.GENRE_WAR,
            37: IMAGES.GENRE_WESTERON
        ]
    }
    
    struct OMDB {
        static let API_KEY              = "a04303a5"
        static let BASE_URL             = "http://www.omdbapi.com/"
        
        struct Parameters {
            static let apiKey           = "apikey"
            static let tomatoes         = "tomatoes"
        }
    }
    
    struct URL {
        static let IMDB_URL             = "https://www.imdb.com/"
        static let WIKI_URL             = "https://en.wikipedia.org/w/"
    }
    
    struct COLOR {
        static let colorPrimary             = "#673ab7"
        static let colorPrimaryDark         = "#4527a0"
        static let colorPrimaryLight        = "#7e57c2"
        static let colorAccent              = "#f44336"
    }
    
    struct IMAGES {
        static let APP_ICON                             = "AppIcon"
        static let PLACEHOLDER_BACKDROP_MOVIE           = "BackdropPlaceholder"
        static let PLACEHOLDER_POSTER_MOVIE             = "MoviePlaceholder"
        static let PLACEHOLDER_POSTER_PROFILE           = "ProfilePlaceholder"
        static let ICON_HOME                            = "HomeIcon"
        static let ICON_IMDB                            = "ImdbIcon-white"
        static let ICON_PERSON                          = "PersonIcon"
        static let ICON_SHARE                           = "ShareIcon"
        static let ICON_TOMATOES                        = "TomatoesIcon-white"
        static let ICON_WIKI                            = "WikiIcon-white"
        
        static let GENRE_ACTION                         = "action"
        static let GENRE_ADVENTURE                         = "adventure"
        static let GENRE_ANIMATION                         = "animation"
        static let GENRE_COMEDY                         = "comedy"
        static let GENRE_CRIME                         = "crime"
        static let GENRE_DOCUMENTARY                         = "documentary"
        static let GENRE_DRAMA                         = "drama"
        static let GENRE_FAMILY                         = "family"
        static let GENRE_FANTASY                         = "fantasy"
        static let GENRE_HORROR                         = "horror"
        static let GENRE_HISTORY                         = "history"
        static let GENRE_MISTERY                         = "mistery"
        static let GENRE_TV_MOVIE                         = "tv_movie"
        static let GENRE_ROMANCE                         = "romance"
        static let GENRE_MUSIC                         = "music"
        static let GENRE_SCIENCE_FICTION                         = "science_fiction"
        static let GENRE_THRILLER                         = "thriller"
        static let GENRE_WAR                         = "war"
        static let GENRE_WESTERON                         = "westeron"
        
    }
    
}
