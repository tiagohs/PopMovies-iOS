//
//  MovieCell.swift
//  popmovies
//
//  Created by Tiago Silva on 16/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation
import UIKit

class MovieCell: UICollectionViewCell {
    
    @IBOutlet weak var movieBackground: UIImageView!
    @IBOutlet weak var movieTitle: UITextField!
    @IBOutlet weak var movieSubtitle: UITextField!
    @IBOutlet weak var moviePoster: UIImageView!
    
    var movie: Movie?
    
    func bindMovieCellWithPoster(movie: Movie) {
        self.movie = movie
        
        if (movie.posterPath != nil) {
            let posterUrl = "https://image.tmdb.org/t/p/w780/" + movie.backdropPath!
            
            movieBackground.setImage( imageUrl: posterUrl, contentMode: .scaleAspectFill, placeholderImageName: "placeholder")
            
            movieBackground.layer.cornerRadius = 20
        }
    }
    
    func bindMovieCellDefault(movie: Movie) {
        self.movie = movie
        let posterUrl = "https://image.tmdb.org/t/p/w500/" + movie.posterPath!
        
        moviePoster.setImage( imageUrl: posterUrl, contentMode: .scaleAspectFill, placeholderImageName: "placeholder")
        
        moviePoster.layer.cornerRadius = 5
        
        movieTitle.text = movie.title
        movieSubtitle.text = movie.genres?.first?.name
    }
}
