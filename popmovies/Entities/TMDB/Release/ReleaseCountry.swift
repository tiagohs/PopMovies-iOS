//
//  ReleaseCountry.swift
//  popmovies
//
//  Created by Tiago Silva on 18/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import ObjectMapper

class ReleaseCountry: BaseModel {
    var certification : String?
    var country : String?
    var primary : Bool?
    var release_date : String?
    
    override func mapping(map: Map) {
        certification <- map["certification"]
        country <- map["iso_3166_1"]
        primary <- map["primary"]
        release_date <- map["release_date"]
    }
}
