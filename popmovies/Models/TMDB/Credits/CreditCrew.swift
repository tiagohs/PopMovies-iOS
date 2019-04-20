//
//  CreditCrew.swift
//  popmovies
//
//  Created by Tiago Silva on 18/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import ObjectMapper

class CreditCrew: BaseModel {
    var id : Int?
    var name : String?
    var profilePath : String?
    var department : String?
    var gender : Int?
    var creditId : String?
    var job : String?
    
    override func mapping(map: Map) {
        creditId <- map["credit_id"]
        department <- map["department"]
        gender <- map["gender"]
        id <- map["id"]
        job <- map["job"]
        name <- map["name"]
        profilePath <- map["profile_path"]
    }
}
