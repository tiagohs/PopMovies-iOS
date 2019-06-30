//
//  MovieListCell.swift
//  popmovies
//
//  Created by Tiago Silva on 28/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

// MARK: MovieListCell: UITableViewCell

class MovieListCell: UITableViewCell {
    
    // MARK: Constants
    
    var MovieCellIdentifier = "MovieCellIdentifier"
    var nibName = R.nib.movieCell.name
    
    // MARK: Outlets
    
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    @IBOutlet weak var moviesCollectionViewViewFlow: UICollectionViewFlowLayout!  {
        didSet {
            moviesCollectionViewViewFlow.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    // MARK: Properties
    
    var movieListDelegate: MovieListDelegate? = nil
    var movies: [Movie]? {
        didSet { bindMovieContent(movies: movies!) }
    }
    
    // MARK: Bind methods
    
    private func bindMovieContent(movies: [Movie]) {
        self.moviesCollectionView.configureNibs(nibName: nibName, identifier: MovieCellIdentifier)
    }
    
    func bindMovieCell(cell: MovieCell, movie: Movie, index: Int) -> UICollectionViewCell {
        fatalError("Not Implemented")
    }
    
}

// MARK: UICollectionViewDelegate, UICollectionViewDataSource

extension MovieListCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movies?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCellIdentifier, for: indexPath) as? MovieCell, let movies = self.movies else { return UICollectionViewCell() }
        let movie = movies[indexPath.row]
        
        return self.bindMovieCell(cell: cell, movie: movie, index: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movies = self.movies else { return }
        
        let movie = movies[indexPath.row]
        
        movieListDelegate?.didSelectItem(index: indexPath.row, movie: movie)
    }
    
}
