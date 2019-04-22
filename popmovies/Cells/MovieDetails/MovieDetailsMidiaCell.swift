//
//  MovieDetailsMidiaCell.swift
//  popmovies
//
//  Created by Tiago Silva on 21/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

class MovieDetailsMidiaCell: UITableViewCell {
    
    var movie: Movie? {
        didSet { bindFooter(movie: movie!) }
    }
    
    private func bindFooter(movie: Movie) {
        
    }
}

extension MovieDetailsMidiaCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
}
