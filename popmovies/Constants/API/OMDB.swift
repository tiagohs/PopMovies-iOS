//
//  OMDB.swift
//  popmovies
//
//  Created by Tiago Silva on 25/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation

struct OMDB {
    static let API_KEY              = "a04303a5"
    static let BASE_URL             = "http://www.omdbapi.com/"
    
    struct Parameters {
        static let apiKey           = "apikey"
        static let tomatoes         = "tomatoes"
        static let imdb             = "i"
    }
    
    struct URL {
        
        static func buildMovieRankingsParameters(_ imdbId: String) -> [String : String] {
            return [
                Parameters.apiKey: API_KEY,
                Parameters.tomatoes: "true",
                Parameters.imdb: imdbId
            ]
        }
    }
}
