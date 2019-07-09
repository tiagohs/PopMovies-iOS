//
//  UpcomingMoviesCell.swift
//  popmovies
//
//  Created by Tiago Silva on 01/05/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

// MARK: UpcomingMoviesCell: MovieListCell

class UpcomingMoviesCell: MovieListCell {
    
    override var nibName: String {
        get { return R.nib.movieSmallCell.name }
        set {}
    }
    
    override func bindMovieCell(cell: MovieCollectionViewCell, movie: Movie, index: Int) -> UICollectionViewCell {
        cell.bindMovieCellDefault(movie: movie)
        
        return cell
    }
}
