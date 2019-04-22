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
    @IBOutlet weak var imdbTotalLabelView: UILabel!
    @IBOutlet weak var imdbTitleLabelView: UILabel!
    
    @IBOutlet weak var tomatoesRating: UILabel!
    @IBOutlet weak var tomatoesLabelView: UILabel!
    @IBOutlet weak var tomatoesTitleLabelView: UILabel!
    
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var movieGenresCollectionView: UICollectionView!
    @IBOutlet weak var movieGenresCollectionViewFlowLayout: UICollectionViewFlowLayout! {
        didSet {
            movieGenresCollectionViewFlowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    @IBOutlet weak var headerBackground: UIView!
    
    var movie: Movie? {
        didSet { bindMovieHeader(movie: self.movie!) }
    }
    
    var movieRanking: MovieOMDB? {
        didSet { bindMovieRankings(movieRanking: movieRanking!) }
    }
    
    var movieColors: UIImageColors? = nil
    
    private func bindMovieRankings(movieRanking: MovieOMDB) {
        
        if let imdbRankingValue = movieRanking.imdbRating {
            if imdbRankingValue != "N/A" {
                self.imdbRating.text = imdbRankingValue
            }
        }
        
        if let ratings = movieRanking.ratings {
            guard let tomatoesRating = ratings.first(where: { (rating) -> Bool in
                return rating.source == "Rotten Tomatoes"
            }) else {
                return
            }
            
            self.tomatoesRating.text = tomatoesRating.value?.replacingOccurrences(of: "%", with: "")
        }
    }
    
    private func bindMovieHeader(movie: Movie) {
        let backdropUrl = "https://image.tmdb.org/t/p/w780/" + movie.backdropPath!
        let posterUrl = "https://image.tmdb.org/t/p/w500/" + movie.posterPath!
        
        if (movieColors == nil) {
            let color = UIColor.white
            color.withAlphaComponent(0.6)
            
            self.movieBackdropView.updateColors(colors:
                [UIColor.clear.cgColor, color.cgColor]
            )
        }
        
        if movieBackdropView.image == nil {
            movieBackdropView.setImage( imageUrl: backdropUrl, contentMode: .scaleAspectFill, placeholderImageName: "placeholder") { (result) in
                let image = try? result.get().image
                
                self.updateHeaderColors(image: image)
            }
        }
        
        if moviePosterView.image == nil {
            moviePosterView.setImage( imageUrl: posterUrl, contentMode: .scaleAspectFill, placeholderImageName: "placeholder")
        }
        
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
    
    private func updateHeaderColors(image: UIImage?) {
        guard let colors = image?.getColors() else {
            return
        }
        
        self.movieColors = colors
        
        let backgroundColor = colors.background
        let textColor = colors.primary
        
        self.headerBackground.backgroundColor = backgroundColor
        self.movieGenresCollectionView.backgroundColor = backgroundColor
        self.movieTitleView.textColor = textColor
        self.movieSubtitleInfoView.textColor = textColor
        
        self.imdbRating.textColor = textColor
        self.tomatoesRating.textColor = textColor
        
        self.imdbTitleLabelView.textColor = textColor
        self.tomatoesTitleLabelView.textColor = textColor
        
        self.imdbTotalLabelView.textColor = textColor
        self.tomatoesLabelView.textColor = textColor
        
        self.separatorView.backgroundColor = textColor
        
        let backdropBackgroundColor = backgroundColor
        backdropBackgroundColor?.withAlphaComponent(0.6)
        
        self.movieBackdropView.updateColors(colors:
            [UIColor.clear.cgColor, backdropBackgroundColor!.cgColor]
        )
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
            let textColor = movieColors?.primary ?? UIColor()
            
            cell.bindSimpleItem(simpleItem: SimpleItem(id: genre.id!, text: genre.name!), color: textColor)
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    
}