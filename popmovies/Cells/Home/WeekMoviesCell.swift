//
//  WeekMoviesCell.swift
//  popmovies
//
//  Created by Tiago Silva on 17/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation
import UIKit

class WeekMoviesCell: UITableViewCell {
    let weekMovieCellIdentifier = "WeekMovieCellIdentifier"
    
    @IBOutlet weak var weekMoviesCollectionView: UICollectionView!
    
    var weekMovies: [Movie] = []
    var movieListCallback: MovieListCallback? = nil
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setMovieListCallback(movieListCallback: MovieListCallback) {
        self.movieListCallback = movieListCallback
    }
    
    func updateWeekMoviesCollection(weekMovies: [Movie]?) {
        let cellNib = UINib(nibName: "MovieCell", bundle: nil)
        weekMoviesCollectionView.register(cellNib, forCellWithReuseIdentifier: weekMovieCellIdentifier)
        
        if (weekMovies != nil && !(weekMovies?.isEmpty)!) {
            self.weekMovies = weekMovies!
        
            self.weekMoviesCollectionView.reloadData()
        }
    }
    
}

extension WeekMoviesCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weekMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: weekMovieCellIdentifier, for: indexPath) as! MovieCell
        
        let movie = weekMovies[indexPath.row]
        
        cell.bindMovieCellDefault(movie: movie)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = weekMovies[indexPath.row]
        
        movieListCallback?.didSelectItem(index: indexPath.row, movie: movie)
    }
    
    
}
