//
//  MovieCredits.swift
//  popmovies
//
//  Created by Tiago Silva on 19/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import ObjectMapper

class MovieCredits: BaseModel {
    var cast : [CreditCast]?
    var crew : [CreditCrew]?
    
    override func mapping(map: Map) {
        cast <- map["cast"]
        crew <- map["crew"]
    }
}
