//
//  MovieDetailsCreditsCell.swift
//  popmovies
//
//  Created by Tiago Silva on 20/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

// MARK: MovieDetailsHeaderCell: UITableViewCell

class MovieDetailsCreditsCell: UITableViewCell {
    // MARK: Constants
    
    let CastCollectionViewIdentifier                = "CastCollectionViewIdentifier"
    let CrewCollectionViewIdentifier                = "CrewCollectionViewIdentifier"
    
    let PersonCell                                  = R.nib.personCell.name
    let PersonCellIdentifier                        = "PersonCellIdentifier"
    
    // MARK: Outlets
    
    @IBOutlet weak var castCollectionView: UICollectionView!
    @IBOutlet weak var castCollectionViewViewFlow: UICollectionViewFlowLayout!  {
        didSet {
            castCollectionViewViewFlow.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    @IBOutlet weak var crewCollectionView: UICollectionView!
    @IBOutlet weak var crewMoviesCollectionViewViewFlow: UICollectionViewFlowLayout!  {
        didSet {
            crewMoviesCollectionViewViewFlow.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    // MARK: Properties
    
    var movieDetailsCreditsDelegate: MovieDetailsCreditsDelegate?
    var movie: Movie? {
        didSet { bindMovieCredits(self.movie!) }
    }
    
}

// MARK: UICollectionViewDelegate, UICollectionViewDataSource

extension MovieDetailsCreditsCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView.restorationIdentifier {
        case CastCollectionViewIdentifier:
            return movie?.credits?.cast?.count ?? 0
        case CrewCollectionViewIdentifier:
            return movie?.credits?.crew?.count ?? 0
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let restorationIdentifier = collectionView.restorationIdentifier
        
        switch restorationIdentifier {
        case CastCollectionViewIdentifier:
            return setupCastCollectionViewCell(collectionView, cellForItemAt: indexPath)
        case CrewCollectionViewIdentifier:
            return setupCrewCollectionViewCell(collectionView, cellForItemAt: indexPath)
        default:
            return UICollectionViewCell()
        }
    }
    
    private func setupCastCollectionViewCell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let castList = movie?.credits?.cast else {
            return UICollectionViewCell()
        }
        let castItem = castList[indexPath.row]
        let personItem = PersonItem(
                            id: castItem.id!,
                            name: castItem.name ?? "",
                            subtitle: castItem.character ?? "",
                            pictureId: castItem.profilePath)
        
        return setupCollectionViewCell(collectionView, cellForItemAt: indexPath, personItem: personItem)
    }
    
    private func setupCrewCollectionViewCell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let crewList = movie?.credits?.crew else {
            return UICollectionViewCell()
        }
        let crewItem = crewList[indexPath.row]
        let personItem = PersonItem(
                            id: crewItem.id!,
                            name: crewItem.name ?? "",
                            subtitle: crewItem.department ?? "",
                            pictureId: crewItem.profilePath)
        
        return setupCollectionViewCell(collectionView, cellForItemAt: indexPath, personItem: personItem)
    }
    
    private func setupCollectionViewCell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath, personItem: PersonItem) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PersonCellIdentifier, for: indexPath) as? PersonCell else {
            return UICollectionViewCell()
        }
        
        cell.person = personItem
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let restorationIdentifier = collectionView.restorationIdentifier
        
        switch restorationIdentifier {
        case CastCollectionViewIdentifier:
            return didCastSelected(didSelectItemAt: indexPath)
        case CrewCollectionViewIdentifier:
            return didCrewSelected(didSelectItemAt: indexPath)
        default:
            return
        }
    }
    
    private func didCastSelected(didSelectItemAt indexPath: IndexPath) {
        guard let castList = movie?.credits?.cast else {
            return
        }
        let castItem = castList[indexPath.row]
        
        onPersonSelected(castItem.id, castItem.name, castItem.profilePath)
    }
    
    private func didCrewSelected(didSelectItemAt indexPath: IndexPath) {
        guard let crewList = movie?.credits?.crew else {
            return
        }
        let crewItem = crewList[indexPath.row]
        
        onPersonSelected(crewItem.id, crewItem.name, crewItem.profilePath)
    }
    
    private func onPersonSelected(_ id: Int?,_ name: String?,_ profilePath: String?) {
        let person = Person()
        
        person.id = id
        person.name = name
        person.profilePath = profilePath
        
        movieDetailsCreditsDelegate?.didSelectPerson(person)
    }
    
}

// MARK: Bind methods

private extension MovieDetailsCreditsCell {
    
    private func bindMovieCredits(_ movie: Movie) {
        setupCells()
        
        self.castCollectionView.reloadData()
        self.crewCollectionView.reloadData()
    }
    
    private func setupCells() {
        castCollectionView.configureNibs(nibName: PersonCell, identifier: PersonCellIdentifier)
        crewCollectionView.configureNibs(nibName: PersonCell, identifier: PersonCellIdentifier)
    }
    
}
