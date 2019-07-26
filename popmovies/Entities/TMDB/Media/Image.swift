//
//  Artwork.swift
//  popmovies
//
//  Created by Tiago Silva on 18/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import ObjectMapper

class Image: BaseModel, Hashable {
    var aspectRatio : Double?
    var filePath : String?
    var height : Int?
    var language : Double?
    var vote_average : Int?
    var vote_count : Int?
    var width : Int?
    
    override func mapping(map: Map) {
        aspectRatio        <- map["aspect_ratio"]
        filePath           <- map["file_path"]
        height              <- map["height"]
        language            <- map["iso_639_1"]
        vote_average        <- map["vote_average"]
        vote_count          <- map["vote_count"]
        width               <- map["width"]
    }
    
    static func == (lhs: Image, rhs: Image) -> Bool {
        return (lhs.filePath == rhs.filePath)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(filePath)
    }
    
}

class Images: BaseModel {
    var backdrops : [Image]?
    var posters : [Image]?
    var profiles : [Image]?
    
    override func mapping(map: Map) {
        backdrops       <- map["backdrops"]
        posters         <- map["posters"]
        profiles         <- map["profiles"]
    }
}

class ImageResults: BaseModel {
    var id: Int?
    var profiles: [Image]?
    
    override func mapping(map: Map) {
        id              <- map["id"]
        profiles         <- map["profiles"]
    }
}

class ImageResultDTO {
    var images: [Image] = []
    var translations: [Translation] = []
}
