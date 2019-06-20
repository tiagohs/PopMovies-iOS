//
//  MovieDetailsOverviewCell.swift
//  popmovies
//
//  Created by Tiago Silva on 20/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

class MovieDetailsOverviewCell: UITableViewCell {
    
    @IBOutlet weak var imdbButton: UIButton!
    @IBOutlet weak var tomatoesButton: UIButton!
    @IBOutlet weak var wikiButton: UIButton!
    
    @IBOutlet weak var overviewView: UILabel!
    
    var movie: Movie? {
        didSet { bindMovie(self.movie!) }
    }
    
    var movieRanking: MovieOMDB?
    var isExternalLinksViewBinded = false
    
    let shadowpath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width:
        35, height: 35), byRoundingCorners:
        [.topRight, .bottomRight], cornerRadii: CGSize(width: 28.0, height: 0.0))
    let shadowOffset = CGSize(width: 0.8, height: 0.4)
    
    private func bindMovie(_ movie: Movie) {
        overviewView.text = movie.overview
        
        if !isExternalLinksViewBinded {
            self.setupExternalLinkView(imdbButton)
            self.setupExternalLinkView(tomatoesButton)
            self.setupExternalLinkView(wikiButton)
            
            isExternalLinksViewBinded = true
        }
        
    }
    
    private func setupExternalLinkView(_ buttonView: UIButton) {
        buttonView.layer.cornerRadius = buttonView.bounds.width / 2
        buttonView.layer.shadowColor = UIColor.black.cgColor
        buttonView.layer.shadowOffset = shadowOffset
        buttonView.layer.shadowOpacity = 0.5
        buttonView.layer.shadowRadius = buttonView.bounds.width / 2
        buttonView.layer.masksToBounds =  false
        buttonView.layer.shadowPath = shadowpath.cgPath
    }
    
    @IBAction func didImdbLinkTaped() {
        guard let imdbURL = URLUtils.formatIMDBUrl(imdbId: movie?.imdbID) else { return }
        
        openLink(link: imdbURL)
    }
    
    @IBAction func didTomatoesLinkTaped() {
        guard let tomatoURL = movieRanking?.tomatoURL else { return }
        
        openLink(link: tomatoURL)
    }
    
    @IBAction func didWikiLinkTaped() {
        guard let wikiUrl = URLUtils.formatWikiUrl(wikiSearchTerm: movie?.originalTitle) else { return }
        
        openLink(link: wikiUrl)
    }
    
    private func openLink(link: String) {
        if let encoded = link.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),
            let myURL = URL(string: encoded) {
            UIApplication.shared.open(myURL)
        }
    }
    
    
}
