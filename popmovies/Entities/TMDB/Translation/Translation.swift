//
//  Translation.swift
//  popmovies
//
//  Created by Tiago Silva on 18/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import ObjectMapper

class TranslationResults: BaseModel {
    var translationList : [Translation]?
    
    override func mapping(map: Map) {
        translationList <- map["translations"]
    }
}

class Translation: BaseModel {
    var iso_3166_1 : String?
    var iso_639_1 : String?
    var name : String?
    var englishName : String?
    var data : TranslationData?
    
    override func mapping(map: Map) {
        iso_3166_1 <- map["iso_3166_1"]
        iso_639_1 <- map["iso_639_1"]
        name <- map["name"]
        englishName <- map["english_name"]
        data <- map["data"]
    }
}
