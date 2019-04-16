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
    
    @IBOutlet weak var moviePoster: UIImageView!
    
    var movie: Movie? {
        didSet {
            
            if (movie?.posterPath != nil) {
                let posterUrl = "https://image.tmdb.org/t/p/w780/" + movie!.backdropPath!
                
                moviePoster.setImage( imageUrl: posterUrl, contentMode: .scaleAspectFill, placeholderImageName: "placeholder")
            }
        }
    }
}
