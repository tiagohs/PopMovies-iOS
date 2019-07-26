//
//  FilmographyDTO.swift
//  popmovies
//
//  Created by Tiago Silva on 26/07/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation

class FilmographyDTO {
    var movie: Movie?
    var workingAs: String?
    
    init(_ dictionary: (key: Int?, value: [FilmographyMovieItem])) {
        self.movie = dictionary.value.first?.movie
        self.workingAs = self.formatWorkingAs(dictionary)
    }
    
    private func formatWorkingAs(_ dictionary: (key: Int?, value: [FilmographyMovieItem])) -> String {
        let workingAsArray: [String] = dictionary.value.map({ $0.department ?? "" })
        
        return workingAsArray.joined(separator: ", ")
    }
}

class FilmographyMovieItem {
    var movieId: Int?
    var movie: Movie?
    var department: String?
    
    init(_ movieId: Int?, _ movie: Movie,_ department: String) {
        self.movieId = movieId
        self.movie = movie
        self.department = department
    }
}
