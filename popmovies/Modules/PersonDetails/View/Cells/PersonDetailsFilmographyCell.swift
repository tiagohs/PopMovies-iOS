//
//  PersonDetailsFilmographyCell.swift
//  popmovies
//
//  Created by Tiago Silva on 20/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

// MARK: PersonDetailsFilmographyCell: UITableViewCell

class PersonDetailsFilmographyCell: UITableViewCell {
    
    let MovieCell                                   = R.nib.filmographyItemCell.name
    let MovieCellIdentifier                         = "MovieCellIdentifier"
    
    @IBOutlet weak var collectionViewView: UICollectionView!
    
    var filmographyList: [FilmographyDTO] = []
    lazy var cellSize: CGSize                   = CGSize(width: self.contentView.bounds.width, height: CGFloat(93))
    var delegate: PersonDetailsFilmographyDelegate?
}


// MARK: UICollectionViewDelegate, UICollectionViewDataSource

extension PersonDetailsFilmographyCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filmographyList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCellIdentifier, for: indexPath) as? FilmographyItemCell else {
            return UICollectionViewCell()
        }
        let movie = filmographyList[indexPath.row]
        
        cell.filmographyItem = movie
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let filmographyItem = filmographyList[indexPath.row]
        guard let movie = filmographyItem.movie else {
            return
        }
        
        delegate?.didMovieSelect(movie)
    }
    
}

// MARK: UICollectionViewDelegateFlowLayout

extension PersonDetailsFilmographyCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.cellSize
    }
}

extension PersonDetailsFilmographyCell {
    
    func bindFilmography(_ filmographyItems: [FilmographyDTO]) {
        self.setupCells()
        
        self.filmographyList = filmographyItems
        
        self.collectionViewView.reloadData()
    }
    
    func setupCells() {
        collectionViewView.configureNibs(nibName: MovieCell, identifier: MovieCellIdentifier)
    }
}
