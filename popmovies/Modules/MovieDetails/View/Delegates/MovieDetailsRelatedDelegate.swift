//
//  MovieDetailsRelatedDelegate.swift
//  popmovies
//
//  Created by Tiago Silva on 30/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation

protocol MovieDetailsRelatedDelegate {
    
    func didMovieSelect(_ movie: Movie)
    func didSeeAllRelatedMoviesClicked()
}
