//
//  Database.swift
//  popmovies
//
//  Created by Tiago Silva on 13/07/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation

struct Database {
    
    struct CORE_DATA {
        static let name                 = "PopMovies"
        
        struct MovieTable {
            static let name             = "MovieDB"
            
            struct Rows {
                static let title        = "title"
                static let id           = "id"
                static let posterPath   = "posterPath"
                static let backdropPath = "backdropPath"
                static let overview     = "overview"
                static let creationDate = "creationDate"
            }
        }
        
        struct UserTable {
            static let name             = "MovieDB"
        }
    }
}
