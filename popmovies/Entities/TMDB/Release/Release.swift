//
//  Release.swift
//  popmovies
//
//  Created by Tiago Silva on 18/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import ObjectMapper

class Release: BaseModel {
    var releaseCountries : [ReleaseCountry]?
    
    override func mapping(map: Map) {
        releaseCountries <- map["countries"]
    }
}
