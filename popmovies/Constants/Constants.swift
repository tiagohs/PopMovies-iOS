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
                static let w300 = "w300"
                static let w780 = "w780"
                static let w1280 = "w1280"
                static let original = "original"
            }
            
            struct LOGO {
                static let w45 = "w45"
                static let w92 = "w92"
                static let w154 = "w154"
                static let w185 = "w185"
                static let w300 = "w300"
                static let w500 = "w500"
                static let original = "original"
            }
            
            struct POSTER {
                static let w92 = "w92"
                static let w154 = "w154"
                static let w185 = "w185"
                static let w342 = "w342"
                static let w500 = "w500"
                static let w780 = "w780"
                static let original = "original"
            }
            
            struct PROFILE {
                static let w45 = "w45"
                static let w185 = "w185"
                static let w632 = "w632"
                static let original = "original"
            }
            
            struct STILL {
                static let w92 = "w92"
                static let w185 = "w185"
                static let w300 = "w300"
                static let original = "original"
            }
        }
    }
    
    struct OMDB {
        static let API_KEY              = "a04303a5"
        static let BASE_URL             = "http://www.omdbapi.com/"
        
        struct Parameters {
            static let apiKey           = "apikey"
            static let tomatoes         = "tomatoes"
        }
    }
    
    
    
    //The header fields
    enum HttpHeaderField: String {
        case authentication = "Authorization"
        case contentType = "Content-Type"
        case acceptType = "Accept"
        case acceptEncoding = "Accept-Encoding"
    }
    
    //The content type (JSON)
    enum ContentType: String {
        case json = "application/json"
    }
}
