//
//  DefaultError.swift
//  popmovies
//
//  Created by Tiago Silva on 29/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation

class DefaultError: Error {
    
    var message: String!
    
    init(message: String) {
        self.message = message
    }
}

