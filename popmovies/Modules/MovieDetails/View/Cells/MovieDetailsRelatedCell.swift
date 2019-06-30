//
//  MovieDetailsRelatedCell.swift
//  popmovies
//
//  Created by Tiago Silva on 20/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

// MARK: MovieDetailsRelatedCell: UITableViewCell

class MovieDetailsRelatedCell: UITableViewCell {
    // MARK: Constants
    
    let MovieSmallCell                              = R.nib.movieSmallCell.name
    let MovieCellIdentifier                         = "MovieCellIdentifier"
    
    // MARK: Outlets
    
    @IBOutlet weak var originalTitleView: UILabel!
    @IBOutlet weak var inTheaterView: UILabel!
    @IBOutlet weak var budgetView: UILabel!
    @IBOutlet weak var revenueView: UILabel!
    @IBOutlet weak var awardsView: UILabel!
    @IBOutlet weak var languageView: UILabel!
    
    @IBOutlet weak var relatedMoviesCollectionView: UICollectionView!
    @IBOutlet weak var relatedMoviesCollectionViewViewFlow: UICollectionViewFlowLayout!  {
        didSet {
            relatedMoviesCollectionViewViewFlow.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    // MARK: Properties
    
    var movieDetailsRelatedDelegate: MovieDetailsRelatedDelegate?
    var movie: Movie? {
        didSet { bindMovieContent(self.movie!) }
    }
    
    var movieRanking: MovieOMDB? {
        didSet { bindMovieRankings(self.movieRanking!) }
    }
    
}

// MARK: Bind methods

extension MovieDetailsRelatedCell {
    
    private func bindMovieContent(_ movie: Movie) {
        setupCells()
        
        self.originalTitleView.text = movie.originalTitle
        self.originalTitleView.sizeToFit()
        self.originalTitleView.layoutIfNeeded()
        self.inTheaterView.text = movie.releaseDate?.formatDate(pattner: "MMM d, yyyy")
        
        if let originalLanguage = movie.originalLanguage {
            self.languageView.text = Locale(identifier: "pt_BR").localizedString(forIdentifier: originalLanguage)
        }
        
        self.revenueView.text = movie.revenue != nil ? "$ \(movie.revenue!)" : "N/A"
        
        self.relatedMoviesCollectionView.reloadData()
    }
    
    private func bindMovieRankings(_ movieRanking: MovieOMDB) {
        self.awardsView.text = movieRanking.awards
        self.budgetView.text = movieRanking.boxOffice
    }
    
    private func setupCells() {
        relatedMoviesCollectionView.configureNibs(nibName: MovieSmallCell, identifier: MovieCellIdentifier)
    }
}

// MARK: UICollectionViewDelegate, UICollectionViewDataSource

extension MovieDetailsRelatedCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movie?.similiarMovies?.results?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let movies = self.movie?.similiarMovies?.results else {
            return UICollectionViewCell()
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCellIdentifier, for: indexPath) as! MovieCell
        let movie = movies[indexPath.row]
        
        cell.bindMovieCellDefault(movie: movie)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let similarMovies = self.movie?.similiarMovies?.results else {
            return
        }
        let similarMovie = similarMovies[indexPath.row]
        
        movieDetailsRelatedDelegate?.didMovieSelect(similarMovie)
    }
    
}

// MARK: Actions methods

extension MovieDetailsRelatedCell {
    
    @IBAction func didSeeAllRelatedMoviesClicked(_ sender: Any?) {
        movieDetailsRelatedDelegate?.didSeeAllRelatedMoviesClicked()
    }
    
}
