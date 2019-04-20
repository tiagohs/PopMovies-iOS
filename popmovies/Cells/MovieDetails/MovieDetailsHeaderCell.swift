//
//  MovieDetailsHeaderCell.swift
//  popmovies
//
//  Created by Tiago Silva on 19/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit
import UIImageColors

class MovieDetailsHeaderCell: UITableViewCell {
    
    let simpleItemCellIdentifier = "SimpleItemCellIdentifier"
    
    @IBOutlet weak var movieBackdropView: UIGradientImageView!
    @IBOutlet weak var moviePosterView: UIImageView!
    @IBOutlet weak var movieTitleView: UILabel!
    @IBOutlet weak var movieSubtitleInfoView: UILabel!
    @IBOutlet weak var imdbRating: UILabel!
    @IBOutlet weak var tomatoesRating: UILabel!
    @IBOutlet weak var movieGenresCollectionView: UICollectionView!
    @IBOutlet weak var headerBackground: UIView!
    
    var movie: Movie? {
        didSet { bindMovieHeader(movie: self.movie!) }
    }
    
    var movieColors: UIImageColors? = nil
    
    private func bindMovieHeader(movie: Movie) {
        let backdropUrl = "https://image.tmdb.org/t/p/w780/" + movie.backdropPath!
        let posterUrl = "https://image.tmdb.org/t/p/w500/" + movie.posterPath!
        
        movieBackdropView.setImage( imageUrl: backdropUrl, contentMode: .scaleAspectFill, placeholderImageName: "placeholder") { (result) in
            let image = try? result.get().image
            guard let colors = image?.getColors() else {
                return
            }
            
            self.movieColors = colors
            
            self.headerBackground.backgroundColor = colors.background
            self.movieGenresCollectionView.backgroundColor = colors.background
            self.movieTitleView.textColor = colors.primary
            self.movieSubtitleInfoView.textColor = colors.primary
            
            let backgroundColor = colors.background
            backgroundColor?.withAlphaComponent(0.6)
            
            self.movieBackdropView.updateColors(colors:
                    [UIColor.clear.cgColor, backgroundColor!.cgColor]
            )
        }
        
        moviePosterView.setImage( imageUrl: posterUrl, contentMode: .scaleAspectFill, placeholderImageName: "placeholder")
        
        movieTitleView.text = movie.title
        
        var movieSubtitle = ""
        
        if let releaseDate = movie.releaseDate {
            movieSubtitle += "\(String(describing: releaseDate.year))"
        }
        
        if let runtime = movie.runtime {
            movieSubtitle += ", \(String(describing: runtime)) Min."
        }
        
        movieSubtitleInfoView.text = movieSubtitle
        
        movieGenresCollectionView.reloadData()
    }
    
}

extension MovieDetailsHeaderCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movie?.genres?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: simpleItemCellIdentifier, for: indexPath) as! SimpleItemCell
        
        if let genres = movie?.genres {
            let genre = genres[indexPath.row]
            let color = movieColors?.primary ?? UIColor()
            
            cell.bindSimpleItem(simpleItem: SimpleItem(id: genre.id!, text: genre.name!), color: color)
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item = collectionView.cellForItem(at: indexPath) as! SimpleItemCell
        
        return CGSize(width: item.labelView.bounds.width, height: collectionView.bounds.size.height)
    }
    
    
}
