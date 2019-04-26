//
//  FeatureMoviesCell.swift
//  popmovies
//
//  Created by Tiago Silva on 16/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation
import UIKit

class NowPlayingMoviesCell: UITableViewCell {
    let nowPlayingMoviesCellIdentifier = "NowPlayingMoviesCellIdentifier"
    
    var movies: [Movie] = []
    var movieListCallback: MovieListCallback? = nil
    
    @IBOutlet weak var nowPlayingMoviesCollectionView: UICollectionView!
    @IBOutlet weak var nowPlayingMoviesViewFlow: UICollectionViewFlowLayout!  {
        didSet {
            nowPlayingMoviesViewFlow.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    func updateNowPlayingMoviesCollection(movies: [Movie]?) {
        let cellNib = UINib(nibName: "NowPlayingMovieCell", bundle: nil)
        nowPlayingMoviesCollectionView.register(cellNib, forCellWithReuseIdentifier: nowPlayingMoviesCellIdentifier)
        
        if (movies != nil && !(movies?.isEmpty)!) {
            self.movies = movies!
            
            self.nowPlayingMoviesCollectionView.reloadData()
        }
    }
}


extension NowPlayingMoviesCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = self.movies.count
        
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: nowPlayingMoviesCellIdentifier, for: indexPath) as! MovieCell
        
        let movie = movies[indexPath.row]
        
        cell.bindMovieCellWithBackdrop(movie: movie)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        
        movieListCallback?.didSelectItem(index: indexPath.row, movie: movie)
    }

}
