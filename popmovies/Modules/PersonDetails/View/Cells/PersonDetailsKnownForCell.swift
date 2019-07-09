//
//  PersonDetailsKnownForCell.swift
//  popmovies
//
//  Created by Tiago Silva on 20/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

class PersonDetailsKnownForCell: UITableViewCell {
    // MARK: Constants
    
    let WallpapersCollectionViewIdentifier          = "WallpapersCollectionViewIdentifier"
    let KnownForCollectionViewIdentifier            = "KnownForCollectionViewIdentifier"
    
    let WallpaperCell                               = R.nib.wallpaperCell.name
    let WallpaperCellIdentifier                     = "WallpaperCellIdentifier"
    let MovieCell                                  = R.nib.movieSmallCell.name
    let MovieCellIdentifier                         = "MovieCellIdentifier"

    // MARK: Outlets
    
    @IBOutlet weak var knownForCollectionViewView: UICollectionView!
    @IBOutlet weak var knownForCollectionViewViewFlow: UICollectionViewFlowLayout!  {
        didSet {
            knownForCollectionViewViewFlow.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    @IBOutlet weak var imagesCollectionViewView: UICollectionView!
    @IBOutlet weak var imagesCollectionViewViewFlow: UICollectionViewFlowLayout!  {
        didSet {
            imagesCollectionViewViewFlow.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    // MARK: Properties
    
    var delegate: PersonDetailsKnownForDelegate?
    var person: Person? {
        didSet { bindPerson(self.person!) }
    }
    
    var allImages: [Image] = []
    var allMovies: [Movie] = []
}

// MARK: UICollectionViewDelegate, UICollectionViewDataSource

extension PersonDetailsKnownForCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView.restorationIdentifier {
        case KnownForCollectionViewIdentifier:
            return allMovies.count
        case WallpapersCollectionViewIdentifier:
            return allImages.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView.restorationIdentifier {
        case KnownForCollectionViewIdentifier:
            return setupMoviesCollectionView(collectionView, cellForItemAt: indexPath)
        case WallpapersCollectionViewIdentifier:
            return setupWallpapersCollectionView(collectionView, cellForItemAt: indexPath)
        default:
            return UICollectionViewCell()
        }
        
    }
    
    private func setupMoviesCollectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCellIdentifier, for: indexPath) as! MovieCollectionViewCell
        let movie = allMovies[indexPath.row]
        
        cell.bindMovieCellDefault(movie: movie)
        
        return cell
    }
    
    private func setupWallpapersCollectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WallpaperCellIdentifier, for: indexPath) as! WallpaperCell
        let image = allImages[indexPath.row]
        
        cell.image = image
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch collectionView.restorationIdentifier {
        case KnownForCollectionViewIdentifier:
            return didSelectItemAtKnownForCollectionView(indexPath)
        case WallpapersCollectionViewIdentifier:
            return didSelectItemAtImagesCollectionView(indexPath)
        default:
            return
        }
    }
    
    private func didSelectItemAtImagesCollectionView(_ indexPath: IndexPath) {
        let image = allImages[indexPath.row]
        
        delegate?.didImageSelect(image, indexPath: indexPath)
    }
    
    private func didSelectItemAtKnownForCollectionView(_ indexPath: IndexPath) {
        let movie = allMovies[indexPath.row]
        
        delegate?.didMovieSelect(movie)
    }
}

// MARK: Bind methods

private extension PersonDetailsKnownForCell {
    
    func bindPerson(_ person: Person) {
        setupCells()
        
        allImages = person.allImages
        allMovies = person.allMovieCredits
        
        imagesCollectionViewView.reloadData()
        knownForCollectionViewView.reloadData()
    }
    
    func setupCells() {
        imagesCollectionViewView.configureNibs(nibName: WallpaperCell, identifier: WallpaperCellIdentifier)
        knownForCollectionViewView.configureNibs(nibName: MovieCell, identifier: MovieCellIdentifier)
    }
}
