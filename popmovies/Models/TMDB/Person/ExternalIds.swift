//
//  ExternalIds.swift
//  popmovies
//
//  Created by Tiago Silva on 19/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import ObjectMapper

class ExternalIds: BaseModel {
    var freebaseId : String?
    var instagramId : String?
    var tvRageId : String?
    var twitterId : String?
    var freebaseMid : String?
    var imdbId : String?
    var facebookId : String?
    
    override func mapping(map: Map) {
        freebaseId <- map["freebase_id"]
        instagramId <- map["instagram_id"]
        tvRageId <- map["tvrage_id"]
        twitterId <- map["twitter_id"]
        freebaseMid <- map["freebase_mid"]
        imdbId <- map["imdb_id"]
        facebookId <- map["facebook_id"]
    }
}
