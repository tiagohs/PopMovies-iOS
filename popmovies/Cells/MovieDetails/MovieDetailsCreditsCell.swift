//
//  MovieDetailsCreditsCell.swift
//  popmovies
//
//  Created by Tiago Silva on 20/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

class MovieDetailsCreditsCell: UITableViewCell {
    let castCollectionViewIdentifier                = "CastCollectionViewIdentifier"
    let crewCollectionViewIdentifier                = "CrewCollectionViewIdentifier"
    
    let personCellIdentifier                        = "PersonCellIdentifier"
    
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
    
    var personListener: IPersonListener?
    var movie: Movie? {
        didSet { bindMovieCredits(self.movie!) }
    }
    
    private func bindMovieCredits(_ movie: Movie) {
        setupCells()
        
        self.castCollectionView.reloadData()
        self.crewCollectionView.reloadData()
    }
    
    private func setupCells() {
        configureNibs(castCollectionView, nibName: "PersonCell", identifier: personCellIdentifier)
        configureNibs(crewCollectionView, nibName: "PersonCell", identifier: personCellIdentifier)
    }
    
    private func configureNibs(_ collection: UICollectionView, nibName: String, identifier: String) {
        let cellNib = UINib(nibName: nibName, bundle: nil)
        
        collection.register(cellNib, forCellWithReuseIdentifier: identifier)
        collection.reloadData()
    }
}


extension MovieDetailsCreditsCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView.restorationIdentifier {
        case castCollectionViewIdentifier:
            return movie?.credits?.cast?.count ?? 0
        case crewCollectionViewIdentifier:
            return movie?.credits?.crew?.count ?? 0
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let restorationIdentifier = collectionView.restorationIdentifier
        
        switch restorationIdentifier {
        case castCollectionViewIdentifier:
            if let castList = movie?.credits?.cast {
                let castItem = castList[indexPath.row]
                
                let personItem = PersonItem(id: castItem.id!, name: castItem.name ?? "", subtitle: castItem.character ?? "", pictureId: castItem.profilePath)
                
                return setupCastCollectionViewCell(collectionView, cellForItemAt: indexPath, personItem: personItem)
            }
        case crewCollectionViewIdentifier:
            if let crewList = movie?.credits?.crew {
                let crewItem = crewList[indexPath.row]
                
                let personItem = PersonItem(id: crewItem.id!, name: crewItem.name ?? "", subtitle: crewItem.department ?? "", pictureId: crewItem.profilePath)
                
                return setupCastCollectionViewCell(collectionView, cellForItemAt: indexPath, personItem: personItem)
            }
        default:
            return UICollectionViewCell()
        }
        
        return UICollectionViewCell()
    }
    
    private func setupCastCollectionViewCell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath, personItem: PersonItem) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: personCellIdentifier, for: indexPath) as! PersonCell
        
        cell.person = personItem
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let restorationIdentifier = collectionView.restorationIdentifier
        
        if (restorationIdentifier == castCollectionViewIdentifier) {
            didCastSelected(didSelectItemAt: indexPath)
        } else if (restorationIdentifier == crewCollectionViewIdentifier) {
            didCrewSelected(didSelectItemAt: indexPath)
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
        
        personListener?.didPersonSelect(person)
    }
    
}

protocol IPersonListener {
    func didPersonSelect(_ person: Person)
}
