//
//  TopRatedMoviesCell.swift
//  popmovies
//
//  Created by Tiago Silva on 01/05/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

// MARK: TopRatedMoviesCell: MovieListCell

class TopRatedMoviesCell: MovieListCell {
    
    override var nibName: String {
        get { return R.nib.movieSmallCell.name }
        set {}
    }
    
    override func bindMovieCell(cell: MovieCell, movie: Movie, index: Int) -> UICollectionViewCell {
        cell.bindMovieCellDefault(movie: movie)
        
        return cell
    }
}
