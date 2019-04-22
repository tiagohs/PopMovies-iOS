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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.leftAnchor.constraint(equalTo: leftAnchor),
            contentView.rightAnchor.constraint(equalTo: rightAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func bindMovieCellWithPoster(movie: Movie) {
        self.movie = movie
        
        if let backdropUrl = ImageUtils.formatImageUrl(imageID: movie.backdropPath, imageSize: Constants.TMDB.ImageSize.BACKDROP.w780) {
            
            movieBackground.setImage( imageUrl: backdropUrl, contentMode: .scaleAspectFill, placeholderImageName: "BackdropPlaceholder")
        } else {
            movieBackground.image = UIImage(named: "BackdropPlaceholder")
        }
        
        movieBackground.layer.cornerRadius = 20
    }
    
    func bindMovieCellDefault(movie: Movie) {
        self.movie = movie
        
        if let posterUrl = ImageUtils.formatImageUrl(imageID: movie.posterPath, imageSize: Constants.TMDB.ImageSize.POSTER.w500) {
            
            moviePoster.setImage( imageUrl: posterUrl, contentMode: .scaleAspectFill, placeholderImageName: "PosterPlaceholder")
        } else {
            moviePoster.image = UIImage(named: "PosterPlaceholder")
        }
        
        moviePoster.layer.cornerRadius = 5
        
        movieTitle.text = movie.title
        movieSubtitle.text = movie.releaseDate?.year
    }
}
