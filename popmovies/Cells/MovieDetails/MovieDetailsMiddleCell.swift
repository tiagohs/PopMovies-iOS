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
    let crewCollectionViewIdentifier = "CrewCollectionViewIdentifier"
    let personCellIdentifier = "PersonCellIdentifier"
    
    @IBOutlet weak var movieOverviewView: UILabel!
    @IBOutlet weak var imdbView: UIView!
    @IBOutlet weak var tomatoesView: UIView!
    @IBOutlet weak var wikiView: UIView!
    @IBOutlet weak var castCollectionView: UICollectionView!
    @IBOutlet weak var crewCollectionView: UICollectionView!
    
    
    var movie: Movie? {
        didSet { bindMovieContent(movie: self.movie!) }
    }
    
    var movieRanking: MovieOMDB? {
        didSet { bindMovieRankings(movieRanking: movieRanking!) } 
    }
    
    let shadowpath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width:
        35, height: 35), byRoundingCorners:
        [.topRight, .bottomRight], cornerRadii: CGSize(width: 28.0, height: 0.0))
    let shadowOffset = CGSize(width: 0.8, height: 0.4)
    
    private func bindMovieRankings(movieRanking: MovieOMDB) {
        
        let tomatoesLinkGesture = UITapGestureRecognizer(target: self, action: #selector(self.didTomatoesLinkTaped))
        
        self.tomatoesView.addGestureRecognizer(tomatoesLinkGesture)
    }
    
    func bindMovieContent(movie: Movie) {
        movieOverviewView.text = movie.overview
        
        let imdbLinkGesture = UITapGestureRecognizer(target: self, action:  #selector(self.didImdbLinkTaped(sender:)))
        let wikiLinkGesture = UITapGestureRecognizer(target: self, action: #selector(self.didWikiLinkTaped))
        
        self.wikiView.addGestureRecognizer(wikiLinkGesture)
        self.imdbView.addGestureRecognizer(imdbLinkGesture)
        
        self.setupExternalLinkView(view: imdbView)
        self.setupExternalLinkView(view: tomatoesView)
        self.setupExternalLinkView(view: wikiView)
        
        self.castCollectionView.reloadData()
        self.crewCollectionView.reloadData()
    }
    
    @objc func didImdbLinkTaped(sender : UITapGestureRecognizer) {
        if let imdbId = movie?.imdbID {
            openLink(link: "https://www.imdb.com/title/\(imdbId)")
        }
    }
    
    @objc func didTomatoesLinkTaped(sender : UITapGestureRecognizer) {
        if let tomatoURL = movieRanking?.tomatoURL {
            openLink(link: tomatoURL)
        }
    }
    
    @objc func didWikiLinkTaped(sender : UITapGestureRecognizer) {
        if let originalTitle = movie?.originalTitle {
            openLink(link: "https://en.wikipedia.org/w/index.php?search=\(originalTitle)")
        }
    }
    
    private func openLink(link: String) {
        if let encoded = link.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),
            let myURL = URL(string: encoded) {
            UIApplication.shared.open(myURL)
        }
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
                
                let personItem = PersonItem(id: castItem.castId!, name: castItem.name ?? "", subtitle: castItem.character ?? "", pictureId: castItem.profilePath)
                
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
    
    
}
