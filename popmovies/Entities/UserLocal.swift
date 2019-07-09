//
//  User.swift
//  popmovies
//
//  Created by Tiago Silva on 09/07/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation

class UserLocal {
    
    var name: String?
    var email: String?
    var photoURL: URL?
    
    init() {
        
    }
    
    init(name: String?, email: String?) {
        self.name = name
        self.email = email
    }
}
