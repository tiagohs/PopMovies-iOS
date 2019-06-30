//
//  MovieListNotFoundError.swift
//  popmovies
//
//  Created by Tiago Silva on 29/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation

class MovieListNotFoundError: DefaultError {
    
    var originalError: Error?
    
    init(message: String,_ originalError: Error? = nil) {
        super.init(message: message)
        
        self.originalError = originalError
    }
}
