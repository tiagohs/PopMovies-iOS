//
//  BaseProfileMoviesCell.swift
//  popmovies
//
//  Created by Tiago Silva on 17/07/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation

class BaseProfileMoviesCell: UITableViewCell {
    
    // MARK: Constants
    
    let MovieSmallCell                              = R.nib.movieSmallCell.name
    let MovieCellIdentifier                         = "MovieCellIdentifier"
    
    // MARK: Outlets
    
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    @IBOutlet weak var moviesCollectionViewViewFlow: UICollectionViewFlowLayout!  {
        didSet {
            moviesCollectionViewViewFlow.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    // MARK: Properties
    
    var delegate: ProfileMoviesCellDelegate?
    
    var movies: [Movie] = []
    var listName = R.string.localizable.movieListTitle()
}


// MARK: Bind methods

extension BaseProfileMoviesCell {
    
    func bindContent(_ movies: [Movie]) {
        self.movies = movies
        
        setupCells()
    }
    
    private func setupCells() {
        moviesCollectionView.configureNibs(nibName: MovieSmallCell, identifier: MovieCellIdentifier)
    }
}

extension BaseProfileMoviesCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCellIdentifier, for: indexPath) as! MovieCollectionViewCell
        let movie = movies[indexPath.row]
        
        cell.bindMovieCellDefault(movie: movie)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = self.movies[indexPath.row]
        
        delegate?.didSelectMovie(with: movie)
    }
    
}

// MARK: Actions methods

extension BaseProfileMoviesCell {
    
    @IBAction func didSeeAllClicked(_ sender: Any?) {
        delegate?.didSeeAllClicked(with: self.movies, listName)
    }
    
}
