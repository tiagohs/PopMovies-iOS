//
//  MovieDetailsMiddleCell.swift
//  popmovies
//
//  Created by Tiago Silva on 20/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

class MovieDetailsMiddleCell: UITableViewCell {
    
    let castCollectionViewIdentifier = "CastCollectionViewIdentifier"
    let personCellIdentifier = "PersonCellIdentifier"
    
    @IBOutlet weak var movieOverviewView: UILabel!
    @IBOutlet weak var imdbView: UIView!
    @IBOutlet weak var tomatoesView: UIView!
    @IBOutlet weak var wikiView: UIView!
    @IBOutlet weak var castCollectionView: UICollectionView!
    
    var movie: Movie? {
        didSet { bindMovieContent(movie: self.movie!) }
    }
    
    let shadowpath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width:
        35, height: 35), byRoundingCorners:
        [.topRight, .bottomRight], cornerRadii: CGSize(width: 28.0, height: 0.0))
    let shadowOffset = CGSize(width: 0.8, height: 0.4)
    
    func bindMovieContent(movie: Movie) {
        movieOverviewView.text = movie.overview
        
        self.setupExternalLinkView(view: imdbView)
        self.setupExternalLinkView(view: tomatoesView)
        self.setupExternalLinkView(view: wikiView)
        
        self.castCollectionView.reloadData()
    }
    
    private func setupExternalLinkView(view: UIView) {
        view.layer.cornerRadius = view.bounds.width / 2
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = shadowOffset
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = view.bounds.width / 2
        view.layer.masksToBounds =  false
        view.layer.shadowPath = shadowpath.cgPath
    }
}

extension MovieDetailsMiddleCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView.restorationIdentifier {
            case castCollectionViewIdentifier:
                return movie?.credits?.cast?.count ?? 0
            default:
                return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView.restorationIdentifier {
        case castCollectionViewIdentifier:
            return setupCastCollectionViewCell(collectionView, cellForItemAt: indexPath)
        default:
            return UICollectionViewCell()
        }
    }
    
    private func setupCastCollectionViewCell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let castList = movie?.credits?.cast {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: personCellIdentifier, for: indexPath) as! PersonCell
            let castItem = castList[indexPath.row]
            
            cell.person = PersonItem(id: castItem.castId!, name: castItem.name ?? "", subtitle: castItem.character ?? "", pictureId: castItem.profilePath)
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    
}
