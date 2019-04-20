//
//  Artwork.swift
//  popmovies
//
//  Created by Tiago Silva on 18/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import ObjectMapper

class Image: BaseModel {
    var backdrops : [String]?
    var posters : [String]?
    
    override func mapping(map: Map) {
        backdrops <- map["backdrops"]
        posters <- map["posters"]
    }
}
