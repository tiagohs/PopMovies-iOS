//
//  OverviewViewController.swift
//  popmovies
//
//  Created by Tiago Silva on 23/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

class OverviewViewController: BaseViewController {
    
    let castCollectionViewIdentifier                = "CastCollectionViewIdentifier"
    let crewCollectionViewIdentifier                = "CrewCollectionViewIdentifier"
    let relatedMoviesCollectioViewIdentifier        = "RelatedMoviesCollectioViewIdentifier"
    
    let personCellIdentifier                        = "PersonCellIdentifier"
    let movieCellIdentifier                         = "MovieCellIdentifier"
    
    @IBOutlet weak var imdbView: UIView!
    @IBOutlet weak var tomatoesView: UIView!
    @IBOutlet weak var wikiView: UIView!
    
    @IBOutlet weak var movieOverviewView: UILabel!
    @IBOutlet weak var originalTitleView: UILabel!
    @IBOutlet weak var inTheaterView: UILabel!
    @IBOutlet weak var budgetView: UILabel!
    @IBOutlet weak var revenueView: UILabel!
    @IBOutlet weak var awardsView: UILabel!
    @IBOutlet weak var languageView: UILabel!
    
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
    @IBOutlet weak var relatedMoviesCollectionView: UICollectionView!
    @IBOutlet weak var relatedMoviesCollectionViewViewFlow: UICollectionViewFlowLayout!  {
        didSet {
            relatedMoviesCollectionViewViewFlow.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    let shadowpath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width:
        35, height: 35), byRoundingCorners:
        [.topRight, .bottomRight], cornerRadii: CGSize(width: 28.0, height: 0.0))
    let shadowOffset = CGSize(width: 0.8, height: 0.4)
    
    var movie: Movie? {
        didSet { bindMovieContent(movie: self.movie!) }
    }
    
    var movieRanking: MovieOMDB? {
        didSet { bindMovieRankings(movieRanking: movieRanking!) }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNibs(collection: relatedMoviesCollectionView, nibName: "MovieSmallCell", identifier: movieCellIdentifier)
        configureNibs(collection: castCollectionView, nibName: "PersonCell", identifier: personCellIdentifier)
        configureNibs(collection: crewCollectionView, nibName: "PersonCell", identifier: personCellIdentifier)
    }
    
    private func bindMovieRankings(movieRanking: MovieOMDB) {
        
        let tomatoesLinkGesture = UITapGestureRecognizer(target: self, action: #selector(self.didTomatoesLinkTaped))
        
        self.tomatoesView.addGestureRecognizer(tomatoesLinkGesture)
        
        self.awardsView.text = movieRanking.awards
        self.budgetView.text = movieRanking.boxOffice
    }
    
    func bindMovieContent(movie: Movie) {
        movieOverviewView.text = movie.overview
        
        let imdbLinkGesture = UITapGestureRecognizer(target: self, action:  #selector(self.didImdbLinkTaped(sender:)))
        let wikiLinkGesture = UITapGestureRecognizer(target: self, action: #selector(self.didWikiLinkTaped))
        
        self.wikiView.addGestureRecognizer(wikiLinkGesture)
        self.imdbView.addGestureRecognizer(imdbLinkGesture)
        
        self.originalTitleView.text = movie.originalTitle
        self.originalTitleView.sizeToFit()
        self.originalTitleView.layoutIfNeeded()
        self.inTheaterView.text = movie.releaseDate?.formatDate(pattner: "MMM d, yyyy")
        self.languageView.text = Locale(identifier: "pt_BR").localizedString(forIdentifier: movie.originalLanguage!)
        self.revenueView.text = movie.revenue != nil ? "$ \(movie.revenue!)" : "N/A"
        
        self.setupExternalLinkView(view: imdbView)
        self.setupExternalLinkView(view: tomatoesView)
        self.setupExternalLinkView(view: wikiView)
        
        self.castCollectionView.reloadData()
        self.crewCollectionView.reloadData()
        self.relatedMoviesCollectionView.reloadData()
    }
    
    @objc func didImdbLinkTaped(sender : UITapGestureRecognizer) {
        guard let imdbURL = URLUtils.formatIMDBUrl(imdbId: movie?.imdbID) else { return }
        
        openLink(link: imdbURL)
    }
    
    @objc func didTomatoesLinkTaped(sender : UITapGestureRecognizer) {
        guard let tomatoURL = movieRanking?.tomatoURL else { return }
        
        openLink(link: tomatoURL)
    }
    
    @objc func didWikiLinkTaped(sender : UITapGestureRecognizer) {
        guard let wikiUrl = URLUtils.formatWikiUrl(wikiSearchTerm: movie?.originalTitle) else { return }
        
        openLink(link: wikiUrl)
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

extension OverviewViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView.restorationIdentifier {
        case castCollectionViewIdentifier:
            return movie?.credits?.cast?.count ?? 0
        case crewCollectionViewIdentifier:
            return movie?.credits?.crew?.count ?? 0
        case relatedMoviesCollectioViewIdentifier:
            return movie?.similiarMovies?.results?.count ?? 0
            //return movie?.similiarMovies?.count ?? 0
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
        case relatedMoviesCollectioViewIdentifier:
            guard let movies = self.movie?.similiarMovies?.results else { return UICollectionViewCell() }
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: movieCellIdentifier, for: indexPath) as! MovieCell
            let movie = movies[indexPath.row]
            
            cell.bindMovieCellDefault(movie: movie)
            
            return cell
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
