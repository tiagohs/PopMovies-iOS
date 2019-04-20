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
    
    @IBOutlet weak var featureMoviesCollectionView: UICollectionView!
    
    var featureMovies: [Movie] = []
    
    func updateFeatureMoviesCollection(featureMovies: [Movie]?) {
        
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

extension FeatureMoviesCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfCell: CGFloat = 1
        let cellWidth = UIScreen.main.bounds.size.width / numberOfCell
        
        return CGSize(width: cellWidth - 30, height: 230.0)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        targetContentOffset.pointee = scrollView.contentOffset
        var indexes = self.featureMoviesCollectionView.indexPathsForVisibleItems
        indexes.sort()
        
        var index = indexes.first!
        let cell = self.featureMoviesCollectionView.cellForItem(at: index)!
        let position = self.featureMoviesCollectionView.contentOffset.x - cell.frame.origin.x
        if position > cell.frame.size.width / 2 {
            index.row = index.row + 1
        }
        
        self.featureMoviesCollectionView.scrollToItem(at: index, at: .left, animated: true )
    }
}
