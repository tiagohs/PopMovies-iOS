//
//  MovieDetailsHeaderCell.swift
//  popmovies
//
//  Created by Tiago Silva on 19/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit
import UIImageColors

// MARK: MovieDetailsHeaderCell: UITableViewCell

class MovieDetailsHeaderCell: UITableViewCell {
    // MARK: Constants
    
    let SimpleItemCellIdentifier = "SimpleItemCellIdentifier"
    
    // MARK: Outlets
    
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
    
    // MARK: Properties
    
    var movie: Movie? {
        didSet { bindMovieHeader(movie: self.movie!) }
    }
    
    var movieRanking: MovieOMDB? {
        didSet { bindMovieRankings(movieRanking: movieRanking!) }
    }
    
    var movieColors: UIImageColors?
    var movieDetailsHeaderDelegate: MovieDetailsHeaderDelegate?
    
    var isImagesBind = false
    
}

// MARK: UICollectionViewDelegate, UICollectionViewDataSource

extension MovieDetailsHeaderCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movie?.genres?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SimpleItemCellIdentifier, for: indexPath) as? SimpleItemCell, let genres = movie?.genres else {
            return UICollectionViewCell()
        }
        let genre = genres[indexPath.row]
        
        cell.simpleItem = SimpleItem(id: genre.id!, text: genre.name!)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let genres = self.movie?.genres else {
            return
        }
        let genre = genres[indexPath.row]
        
        movieDetailsHeaderDelegate?.didGenreSelected(genre)
    }
}

// MARK: Bind methods

private extension MovieDetailsHeaderCell {
    
    private func bindMovieHeader(movie: Movie) {
        bindHeaderImages(movie)
        bindContent(movie)
    }
    
    func bindMovieRankings(movieRanking: MovieOMDB) {
        let defaultText = "N/A"
        
        self.imdbRating.setText(movieRanking.imdbRating, defaultText: defaultText)
        self.tomatoesRating.setText(movieRanking.tomatoesRating?.grade, defaultText: defaultText)
    }
    
    func bindHeaderImages(_ movie: Movie) {
        if !isImagesBind {
            movieBackdropView.setTMDBImageBy(url: movie.backdropPath, contentSize: TMDB.ImageSize.BACKDROP.w780, contentMode: .scaleAspectFill, placeholder: nil)
            moviePosterView.setTMDBImageBy(url: movie.posterPath, contentSize: TMDB.ImageSize.POSTER.w500, contentMode: .scaleAspectFill, placeholder: nil)
            
            movieBackdropView.hero.id = String(describing: movie.backdropPath)
            moviePosterView.hero.id = String(describing: movie.posterPath)
            
            isImagesBind = true
        }
    }
    
    func bindContent(_ movie: Movie) {
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
