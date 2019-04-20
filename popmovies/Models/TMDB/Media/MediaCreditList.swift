//
//  MediaCreditList.swift
//  popmovies
//
//  Created by Tiago Silva on 18/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import ObjectMapper

class MediaCreditList: BaseModel {
    var cast : [CreditCast]?
    var crew : [CreditCrew]?
    
    override func mapping(map: Map) {
        cast <- map["cast"]
        crew <- map["crew"]
    }
}
