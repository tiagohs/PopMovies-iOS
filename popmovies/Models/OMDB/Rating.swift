//
//  Rating.swift
//  popmovies
//
//  Created by Tiago Silva on 21/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import ObjectMapper

class Rating: BaseModel {
    var source : String?
    var value : String?
    
    override func mapping(map: Map) {
        source <- map["Source"]
        value <- map["Value"]
    }

}
