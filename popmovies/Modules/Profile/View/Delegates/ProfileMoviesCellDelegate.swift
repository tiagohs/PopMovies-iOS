//
//  ProfileMoviesCellDelegate.swift
//  popmovies
//
//  Created by Tiago Silva on 17/07/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation

protocol ProfileMoviesCellDelegate {
    
    func didSelectMovie(with movie: Movie)
    func didSeeAllClicked(with movies: [Movie], _ listName: String)
}
