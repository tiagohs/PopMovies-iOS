//
//  Keyword.swift
//  popmovies
//
//  Created by Tiago Silva on 18/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import ObjectMapper

class Keyword: BaseModel {
    var id: Int?
    var name: String?
    
    override func mapping(map: Map) {
        id              <- map["id"]
        name            <- map["name"]
    }
}

class KeywordResults: BaseModel {
    var keywordsList : [Keyword]?
    
    override func mapping(map: Map) {
        keywordsList <- map["keywords"]
    }
}

