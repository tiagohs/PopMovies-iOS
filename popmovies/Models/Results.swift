//
//  Results.swift
//  popmovies
//
//  Created by Tiago Silva on 14/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation
import ObjectMapper

class Results<T: BaseModel>: BaseModel {
    var page : Int?
    var total_results : Int?
    var total_pages : Int?
    var results : [T]?
    
    override func mapping(map: Map) {
        page            <- map["page"]
        total_results   <- map["total_results"]
        total_pages     <- map["total_pages"]
        results         <- map["results"]
    }
}
