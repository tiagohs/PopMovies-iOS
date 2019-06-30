//
//  Dictionary.swift
//  popmovies
//
//  Created by Tiago Silva on 14/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation

extension Dictionary {
    
    func merge(with: Dictionary<Key,Value>) -> Dictionary<Key,Value> {
        var copy = self
        for (k, v) in with {
            copy[k] = v
        }
        return copy
    }
    
    mutating func append(with: Dictionary<Key,Value>) {
        for (k, v) in with {
            self[k] = v
        }
    }
}
