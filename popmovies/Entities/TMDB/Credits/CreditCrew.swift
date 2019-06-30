//
//  CreditCrew.swift
//  popmovies
//
//  Created by Tiago Silva on 20/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import ObjectMapper

class CreditCrew: BaseModel {
    var id : Int?
    var department : String?
    var originalLanguage : String?
    var originalTitle : String?
    var job : String?
    var overview : String?
    var genreIds : [Int]?
    var video : Bool?
    var creditId : String?
    var releaseDate : Date?
    var popularity : Double?
    var voteAverage : Double?
    var voteCount : Int?
    var title : String?
    var adult : Bool?
    var backdropPath : String?
    var posterPath : String?
    
    override func mapping(map: Map) {
        id <- map["id"]
        department <- map["department"]
        originalLanguage <- map["original_language"]
        originalTitle <- map["original_title"]
        job <- map["job"]
        overview <- map["overview"]
        genreIds <- map["genre_ids"]
        video <- map["video"]
        creditId <- map["credit_id"]
        releaseDate <- (map["release_date"], DateFormatTransform("yyyy-MM-dd"))
        popularity <- map["popularity"]
        voteAverage <- map["vote_average"]
        voteCount <- map["vote_count"]
        title <- map["title"]
        adult <- map["adult"]
        backdropPath <- map["backdrop_path"]
        posterPath <- map["poster_path"]
    }
}
