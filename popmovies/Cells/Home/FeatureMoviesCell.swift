//
//  FeatureMoviesCell.swift
//  popmovies
//
//  Created by Tiago Silva on 16/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation
import UIKit

class FeatureMoviesCell: UITableViewCell {
    let featuresCellIdentifier = "FeaturesCellIdentifier"
    
    var featureMovies: [Movie] = []
    
    @IBOutlet weak var featureMoviesCollectionView: UICollectionView!
    
    @IBOutlet weak var featureMoviesViewFlow: UICollectionViewFlowLayout!  {
        didSet {
            featureMoviesViewFlow.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    func updateFeatureMoviesCollection(featureMovies: [Movie]?) {
        let cellNib = UINib(nibName: "MovieFeaturedCell", bundle: nil)
        featureMoviesCollectionView.register(cellNib, forCellWithReuseIdentifier: featuresCellIdentifier)
        
        if (featureMovies != nil && !(featureMovies?.isEmpty)!) {
            self.featureMovies = featureMovies!
            
            self.featureMoviesCollectionView.reloadData()
        }
    }
}


extension FeatureMoviesCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = self.featureMovies.count
        
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: featuresCellIdentifier, for: indexPath) as! MovieCell
        
        let movie = featureMovies[indexPath.row]
        
        cell.bindMovieCellWithPoster(movie: movie)
        
        return cell
    }

}
