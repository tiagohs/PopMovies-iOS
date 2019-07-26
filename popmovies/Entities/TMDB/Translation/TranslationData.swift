//
//  TranslationData.swift
//  popmovies
//
//  Created by Tiago Silva on 18/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import ObjectMapper

class TranslationData: BaseModel {
    var title : String?
    var overview : String?
    var homepage : String?
    
    override func mapping(map: Map) {
        title       <- map["title"]
        overview    <- map["overview"]
        homepage    <- map["homepage"]
    }
    
}
