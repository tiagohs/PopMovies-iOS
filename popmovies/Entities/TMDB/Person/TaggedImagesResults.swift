//
//  TaggedImagesResults.swift
//  popmovies
//
//  Created by Tiago Silva on 20/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import ObjectMapper

class TaggedImagesResults: BaseModel {
    var iso639_1 : String?
    var voteCount : Int?
    var mediaType : String?
    var filePath : String?
    var aspectRatio : Double?
    var media : Movie?
    var height : Int?
    var voteAverage : Double?
    var width : Int?
    
    override func mapping(map: Map) {
        iso639_1 <- map["iso_639_1"]
        voteCount <- map["vote_count"]
        mediaType <- map["media_type"]
        filePath <- map["file_path"]
        aspectRatio <- map["aspect_ratio"]
        media <- map["media"]
        height <- map["height"]
        voteAverage <- map["vote_average"]
        width <- map["width"]
    }
}
