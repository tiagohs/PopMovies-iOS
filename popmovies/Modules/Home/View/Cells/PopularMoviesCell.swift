//
//  WeekMoviesCell.swift
//  popmovies
//
//  Created by Tiago Silva on 17/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation
import UIKit

// MARK: PopularMoviesCell: MovieListCell

class PopularMoviesCell: MovieListCell {
    
    override func bindMovieCell(cell: MovieCell, movie: Movie, index: Int) -> UICollectionViewCell {
        cell.bindMovieCellDefault(movie: movie)
        
        return cell
    }
    
}
