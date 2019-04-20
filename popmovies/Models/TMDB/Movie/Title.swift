//
//  Title.swift
//  popmovies
//
//  Created by Tiago Silva on 18/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import ObjectMapper

class Title: BaseModel {
    var country : String?
    var title : String?
    var type : String?
    
    override func mapping(map: Map) {
        country <- map["iso_3166_1"]
        title <- map["title"]
        type <- map["type"]
    }
}

