//
//  DiscoverMovie.swift
//  popmovies
//
//  Created by Tiago Silva on 06/07/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation

class DiscoverMovie {
    var region: String?
    var sortBy: String?
    var voteCountGte: String?
    
    var releaseDateGte: String?
    var releaseDateLte: String?
    var primaryReleaseDateGte: String?
    var primaryRelaseDateLte: String?
    var primaryReleaseYear: String?
    
    var certificationCountry: String?
    var certification: String?
    var certificationLte: String?
    
    var withGenres: String?
    var withKeywords: String?
    var withCast: String?
    var withCrew: String?
    var withPeople: String?
    var withCompanies: String?
    var withRuntimeGte: Int?
    var withRuntimeLte: Int?
    var withReleaseType: String?
    
    var withoutGenres: Int?
    var withoutKeywords: Int?
    
    var includeAdult: Bool = false
    var includeVideo: Bool = false
    
    var withOriginalLanguage: String?
    
    var appendToResponse: [String] = []
}
