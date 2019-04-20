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
    var name : String?
    var profilePath : String?
    var castId : Int?
    var character : String?
    var creditId : String?
    var gender : Int?
    var order : Int?
    
    override func mapping(map: Map) {
        castId <- map["cast_id"]
        character <- map["character"]
        creditId <- map["credit_id"]
        gender <- map["gender"]
        id <- map["id"]
        name <- map["name"]
        order <- map["order"]
        profilePath <- map["profile_path"]
    }
}
