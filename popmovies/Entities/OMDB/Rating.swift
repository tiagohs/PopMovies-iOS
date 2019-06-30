//
//  Rating.swift
//  popmovies
//
//  Created by Tiago Silva on 21/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import ObjectMapper

class Rating: BaseModel {
    static let TOMATOES_SOURCE_KEY             = "Rotten Tomatoes"
    static let INTERNET_MOVIE_SOURCE_KEY       = "Internet Movie Database"
    static let METACRITIC_SOURCE_KEY           = "Metacritic"
    
    var source : String?
    var value : String?
    var grade : String? {
        switch source {
        case Rating.TOMATOES_SOURCE_KEY:
            return value?.replacingOccurrences(of: "%", with: "")
        case Rating.INTERNET_MOVIE_SOURCE_KEY:
            return String(describing: value?.split(separator: "/")[0])
        case Rating.METACRITIC_SOURCE_KEY:
            return String(describing: value?.split(separator: "/")[0])
        default:
            return nil
        }
        
    }
    
    var total : String? {
        switch source {
        case Rating.TOMATOES_SOURCE_KEY:
            return "100"
        case Rating.INTERNET_MOVIE_SOURCE_KEY:
            return String(describing: value?.split(separator: "/")[1])
        case Rating.METACRITIC_SOURCE_KEY:
            return String(describing: value?.split(separator: "/")[1])
        default:
            return nil
        }
    }
    
    
    override func mapping(map: Map) {
        source <- map["Source"]
        value <- map["Value"]
    }

}
