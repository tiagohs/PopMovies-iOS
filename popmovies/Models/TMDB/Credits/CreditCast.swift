//
//  CreditCast.swift
//  popmovies
//
//  Created by Tiago Silva on 18/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import ObjectMapper

class CreditCast: BaseModel {
    var id : Int?
    var posterPath : String?
    var adult : Bool?
    var backdropPath : String?
    var voteCount : Int?
    var video : Bool?
    var popularity : Double?
    var genreIds : [Int]?
    var originalLanguage : String?
    var title : String?
    var originalTitle : String?
    var releaseDate : Date?
    var character : String?
    var voteAverage : Int?
    var overview : String?
    var creditId : String?
    
    override func mapping(map: Map) {
        posterPath <- map["poster_path"]
        adult <- map["adult"]
        backdropPath <- map["backdrop_path"]
        voteCount <- map["vote_count"]
        video <- map["video"]
        id <- map["id"]
        popularity <- map["popularity"]
        genreIds <- map["genre_ids"]
        originalLanguage <- map["original_language"]
        title <- map["title"]
        originalTitle <- map["original_title"]
        releaseDate <- (map["release_date"], DateFormatTransform("yyyy-MM-dd"))
        character <- map["character"]
        voteAverage <- map["vote_average"]
        overview <- map["overview"]
        creditId <- map["credit_id"]
    }
}
