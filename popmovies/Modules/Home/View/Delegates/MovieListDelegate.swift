//
//  CollectionViewCallback.swift
//  popmovies
//
//  Created by Tiago Silva on 18/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation

protocol MovieListDelegate {
    
    func didSelectItem(index: Int, movie: Movie)
}
