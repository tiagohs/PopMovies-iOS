//
//  Video.swift
//  popmovies
//
//  Created by Tiago Silva on 18/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import ObjectMapper

class Video: BaseModel {
    var id : String?
    var language : String?
    var country : String?
    var key : String?
    var name : String?
    var site : String?
    var size : Int?
    var type : String?
    
    override func mapping(map: Map) {
        id <- map["id"]
        id <- map["language"]
        id <- map["country"]
        id <- map["key"]
        id <- map["name"]
        id <- map["site"]
        id <- map["size"]
        id <- map["type"]
    }
}

class VideoResult: BaseModel {
    var videoResults : [Video]?
    
    override func mapping(map: Map) {
        videoResults <- map["results"]
    }
}
