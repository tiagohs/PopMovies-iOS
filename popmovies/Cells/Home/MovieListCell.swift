//
//  MovieListCell.swift
//  popmovies
//
//  Created by Tiago Silva on 28/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

class MovieListCell: UITableViewCell {
    
    var movieCellIdentifier = "MovieCellIdentifier"
    var nibName = "MovieCell"
    
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    @IBOutlet weak var moviesCollectionViewViewFlow: UICollectionViewFlowLayout!  {
        didSet {
            moviesCollectionViewViewFlow.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    var movieListCallback: MovieListCallback? = nil
    var movies: [Movie]? {
        didSet { bindMovieContent(movies: movies!) }
    }
    
    private func bindMovieContent(movies: [Movie]) {
        let cellNib = UINib(nibName: nibName, bundle: nil)
        
        self.moviesCollectionView.register(cellNib, forCellWithReuseIdentifier: movieCellIdentifier)
        self.moviesCollectionView.reloadData()
    }
    
    func bindMovieCell(cell: MovieCell, movie: Movie, index: Int) -> UICollectionViewCell {
        fatalError("Not Implemented")
    }
}

extension MovieListCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movies?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let movies = self.movies else { return UICollectionViewCell() }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: movieCellIdentifier, for: indexPath) as! MovieCell
        let movie = movies[indexPath.row]
        
        return self.bindMovieCell(cell: cell, movie: movie, index: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movies = self.movies else { return }
        
        let movie = movies[indexPath.row]
        
        movieListCallback?.didSelectItem(index: indexPath.row, movie: movie)
    }
    
}
