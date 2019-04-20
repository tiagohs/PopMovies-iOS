//
//  Review.swift
//  popmovies
//
//  Created by Tiago Silva on 18/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import ObjectMapper

class Review: BaseModel {
    var page : Int?
    var reviewsList : [ReviewPerson]?
    var totalPages : Int?
    var totalResults : Int?
    
    override func mapping(map: Map) {
        page <- map["page"]
        reviewsList <- map["results"]
        totalPages <- map["total_pages"]
        totalResults <- map["total_results"]
    }
}
