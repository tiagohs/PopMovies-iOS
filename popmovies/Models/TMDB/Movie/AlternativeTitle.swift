//
//  AlternativeTitle.swift
//  popmovies
//
//  Created by Tiago Silva on 18/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import ObjectMapper

class AlternativeTitle: BaseModel {
    var titles : [Title]?
    
    override func mapping(map: Map) {
        titles <- map["titles"]
    }

}
