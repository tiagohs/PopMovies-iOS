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
        language <- map["iso_639_1"]
        country <- map["iso_3166_1"]
        key <- map["key"]
        name <- map["name"]
        site <- map["site"]
        size <- map["size"]
        type <- map["type"]
    }
}

class VideoResult: BaseModel {
    var videoResults : [Video]?
    
    override func mapping(map: Map) {
        videoResults <- map["results"]
    }
}

class VideoResultDTO {
    var videos: [Video] = []
    var translations: [Translation] = []
}
