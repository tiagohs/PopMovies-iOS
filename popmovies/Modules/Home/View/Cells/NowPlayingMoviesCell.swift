//
//  FeatureMoviesCell.swift
//  popmovies
//
//  Created by Tiago Silva on 16/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation
import UIKit

// MARK: NowPlayingMoviesCell: MovieListCell

class NowPlayingMoviesCell: MovieListCell {
    
    override var nibName: String {
        get { return R.nib.nowPlayingMovieCell.name }
        set {}
    }
    
    override func bindMovieCell(cell: MovieCell, movie: Movie, index: Int) -> UICollectionViewCell { 
        cell.bindMovieCellWithBackdrop(movie: movie)
        cell.setupImageShadow(cornerRadius: 20, shadowRect: CGRect(x: 10, y: 20, width: 230, height: 140))
        
        return cell
    }
}
