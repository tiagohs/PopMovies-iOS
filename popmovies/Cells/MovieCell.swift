//
//  MovieCell.swift
//  popmovies
//
//  Created by Tiago Silva on 16/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation
import UIKit
import Hero

class MovieCell: UICollectionViewCell {
    
    @IBOutlet weak var movieBackground: UIImageView!
    @IBOutlet weak var movieTitle: UITextField!
    @IBOutlet weak var movieSubtitle: UITextField!
    @IBOutlet weak var moviePoster: UIGradientImageView!
    @IBOutlet weak var imageShadowView: UIView!
    
    var movie: Movie?
    
    var isImageShadowBinded = false
    var isPosterShadowBinded = false
    
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
    
    func bindMovieCellWithBackdrop(movie: Movie) {
        self.movie = movie
        
        guard let movieBackdropView = self.movieBackground else { return }
        
        if let backdropUrl = ImageUtils.formatImageUrl(imageID: movie.backdropPath, imageSize: Constants.TMDB.ImageSize.BACKDROP.w780) {
            
            movieBackdropView.setImage( imageUrl: backdropUrl, contentMode: .scaleAspectFill, placeholderImageName: "BackdropPlaceholder")
            movieBackdropView.hero.id = String(describing: movie.backdropPath)
        } else {
            movieBackdropView.image = UIImage(named: "BackdropPlaceholder")
        }
    
    }
    
    func setupImageShadow(cornerRadius: CGFloat, shadowRect: CGRect) {
        if (!isImageShadowBinded) {
            guard let imageShadowView = self.imageShadowView else { return }
            
            imageShadowView.layer.cornerRadius = cornerRadius
            imageShadowView.layer.shadowColor = UIColor.black.cgColor
            imageShadowView.layer.shadowOffset = CGSize(width: 0, height: 3)
            imageShadowView.layer.shadowOpacity = 0.3
            imageShadowView.layer.shadowRadius = cornerRadius
            imageShadowView.layer.masksToBounds =  false
            imageShadowView.layer.shouldRasterize = true
            imageShadowView.layer.shadowPath = UIBezierPath(rect: shadowRect).cgPath
            
            isImageShadowBinded = true
        }
        
    }
    
    func setupMoviePosterShadow() {
        
        if !isPosterShadowBinded {
            let color = UIColor.black
            color.withAlphaComponent(0.6)
            
            self.moviePoster.updateColors(colors:
                [UIColor.clear.cgColor, color.cgColor]
            )
            
            isPosterShadowBinded = true
        }
        
    }
    
    func bindMovieCellDefault(movie: Movie) {
        self.movie = movie
        
        guard let moviePosterView = self.moviePoster else { return }
        
        if let posterUrl = ImageUtils.formatImageUrl(imageID: movie.posterPath, imageSize: Constants.TMDB.ImageSize.POSTER.w500) {
            
            moviePosterView.setImage( imageUrl: posterUrl, contentMode: .scaleAspectFill, placeholderImageName: "PosterPlaceholder")
            moviePosterView.hero.id = String(describing: movie.posterPath)
        } else {
            moviePosterView.image = UIImage(named: "PosterPlaceholder")
        }
        
        movieTitle.text = movie.title
        movieSubtitle.text = movie.releaseDate?.year
    }
}
