//
//  WeekMoviesCell.swift
//  popmovies
//
//  Created by Tiago Silva on 17/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation
import UIKit

class PopularMoviesCell: UITableViewCell {
    let popularMoviesCelldentifier = "PopularMoviesCelldentifier"
    
    @IBOutlet weak var popularMoviesCollectionView: UICollectionView!
    
    var movies: [Movie] = []
    var movieListCallback: MovieListCallback? = nil
    
    let shadowpath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width:
        35, height: 35), byRoundingCorners:
        [.topRight, .bottomRight], cornerRadii: CGSize(width: 28.0, height: 0.0))
    let shadowOffset = CGSize(width: 0.8, height: 0.4)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func updatePopularMoviesCollection(movies: [Movie]?) {
        let cellNib = UINib(nibName: "MovieCell", bundle: nil)
        popularMoviesCollectionView.register(cellNib, forCellWithReuseIdentifier: popularMoviesCelldentifier)
        
        if (movies != nil && !(movies?.isEmpty)!) {
            self.movies = movies!
        
            self.popularMoviesCollectionView.reloadData()
        }
    }
    
}

extension PopularMoviesCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: popularMoviesCelldentifier, for: indexPath) as! MovieCell
        
        let movie = movies[indexPath.row]
        
        cell.bindMovieCellDefault(movie: movie)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        
        movieListCallback?.didSelectItem(index: indexPath.row, movie: movie)
    }
    
    
}
