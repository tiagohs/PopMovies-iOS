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
        
        static let API_KEY = "dac4d50f24dee29513738d8fa3470a3f"
        static let BASE_URL = "https://api.themoviedb.org/3/"
        
        struct Parameters {
            static let apiKey = "api_key"
            static let language = "language"
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
