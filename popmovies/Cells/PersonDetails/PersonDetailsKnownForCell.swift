//
//  PersonDetailsKnownForCell.swift
//  popmovies
//
//  Created by Tiago Silva on 20/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

class PersonDetailsKnownForCell: UITableViewCell {
    
    let WallpapersCollectionViewIdentifier          = "WallpapersCollectionViewIdentifier"
    let KnownForCollectionViewIdentifier            = "KnownForCollectionViewIdentifier"

    let WallpaperCellIdentifier                     = "WallpaperCellIdentifier"
    let MovieCellIdentifier                         = "MovieCellIdentifier"

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
    
    var person: Person? {
        didSet { bindPerson(self.person!) }
    }
    var allImages: [Image] = []
    var allMovies: [Movie] = []
    
    private func bindPerson(_ person: Person) {
        setupCells()
        
        allImages = mergeImages(person)
        allMovies = mergeMovies(person)
        
        imagesCollectionViewView.reloadData()
        knownForCollectionViewView.reloadData()
    }
    
    private func mergeImages(_ person: Person) -> [Image] {
        let taggedImages = person.taggedImages?.results?.map({ (taggedImagesResults) -> Image in
            let image = Image()
            image.filePath = taggedImagesResults.filePath
            
            return image
        }) ?? []
        let profileImages = person.images?.profile ?? []
        
        return taggedImages + profileImages
    }
    
    private func mergeMovies(_ person: Person) -> [Movie] {
        let casts = person.movieCredits?.cast?.map({ (credit) -> Movie in
            let movie = Movie()
            
            movie.id = credit.id
            movie.title = credit.title
            movie.overview = credit.overview
            movie.backdropPath = credit.backdropPath
            movie.posterPath = credit.posterPath
            movie.releaseDate = credit.releaseDate
            
            return movie
        }) ?? []
        let crews = person.movieCredits?.crew?.map({ (credit) -> Movie in
            let movie = Movie()
            
            movie.id = credit.id
            movie.title = credit.title
            movie.overview = credit.overview
            movie.backdropPath = credit.backdropPath
            movie.posterPath = credit.posterPath
            movie.releaseDate = credit.releaseDate
            
            return movie
        }) ?? []
        
        return Array(Set(casts + crews))
    }
    
    private func setupCells() {
        configureNibs(imagesCollectionViewView, nibName: "WallpaperCell", identifier: WallpaperCellIdentifier)
        configureNibs(knownForCollectionViewView, nibName: "MovieSmallCell", identifier: MovieCellIdentifier)
    }
    
    private func configureNibs(_ collection: UICollectionView, nibName: String, identifier: String) {
        let cellNib = UINib(nibName: nibName, bundle: nil)
        
        collection.register(cellNib, forCellWithReuseIdentifier: identifier)
        collection.reloadData()
    }
    
}

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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCellIdentifier, for: indexPath) as! MovieCell
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
}
