//
//  BaseModel.swift
//  popmovies
//
//  Created by Tiago Silva on 14/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation
import ObjectMapper

class BaseModel: Mappable {
    
    init() {}
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
    }
}
