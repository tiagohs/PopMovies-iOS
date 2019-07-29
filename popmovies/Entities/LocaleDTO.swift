//
//  LocaleDTO.swift
//  popmovies
//
//  Created by Tiago Silva on 26/07/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation

class LocaleDTO {
    var id: String
    var isoCountry: String
    var displayName: String
    
    init(_ id: String, _ isoCountry: String, _ displayName: String) {
        self.id = id
        self.isoCountry = isoCountry
        self.displayName = displayName
    }
}
