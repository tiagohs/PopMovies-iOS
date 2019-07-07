//
//  MovieDetailsOverviewCell.swift
//  popmovies
//
//  Created by Tiago Silva on 20/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

// MARK: MovieDetailsOverviewCell: UITableViewCell

class MovieDetailsOverviewCell: UITableViewCell {
    
    // MARK: Outlets
    
    @IBOutlet weak var imdbButton: UIButton!
    @IBOutlet weak var tomatoesButton: UIButton!
    @IBOutlet weak var wikiButton: UIButton!
    
    @IBOutlet weak var overviewView: UILabel!
    
    // MARK: Properties
    
    var movie: Movie? {
        didSet { bindMovie(self.movie!) }
    }
    
    var delegate: MovieDetailsOverviewDelegate?
    var movieRanking: MovieOMDB?
    var isExternalLinksViewBinded = false
    
    let shadowpath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width:
        35, height: 35), byRoundingCorners:
        [.topRight, .bottomRight], cornerRadii: CGSize(width: 28.0, height: 0.0))
    let shadowOffset = CGSize(width: 0.8, height: 0.4)
    
}

// MARK: Bind methods

private extension MovieDetailsOverviewCell {
    
    func bindMovie(_ movie: Movie) {
        overviewView.text = movie.overview
        
        if !isExternalLinksViewBinded {
            self.setupExternalLinkView(imdbButton)
            self.setupExternalLinkView(tomatoesButton)
            self.setupExternalLinkView(wikiButton)
            
            isExternalLinksViewBinded = true
        }
        
    }
    
    func setupExternalLinkView(_ buttonView: UIButton) {
        buttonView.layer.cornerRadius = buttonView.bounds.width / 2
        buttonView.layer.shadowColor = UIColor.black.cgColor
        buttonView.layer.shadowOffset = shadowOffset
        buttonView.layer.shadowOpacity = 0.5
        buttonView.layer.shadowRadius = buttonView.bounds.width / 2
        buttonView.layer.masksToBounds =  false
        buttonView.layer.shadowPath = shadowpath.cgPath
    }
}

// MARK: Actions methods

private extension MovieDetailsOverviewCell {
    
    @IBAction func didImdbLinkTaped() {
        self.delegate?.didImdbLinkButtonClicked()
    }
    
    @IBAction func didTomatoesLinkTaped() {
        self.delegate?.didTomatoesLinkButtonClicked()
    }
    
    @IBAction func didWikiLinkTaped() {
        self.delegate?.didWikiLinkButtonClicked()
    }
    
}
