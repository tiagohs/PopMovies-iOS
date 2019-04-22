//
//  MovieDetailsFooterCell.swift
//  popmovies
//
//  Created by Tiago Silva on 21/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

class MovieDetailsFooterCell: UITableViewCell {
    
    @IBOutlet weak var originalTitleView: UILabel!
    @IBOutlet weak var runtimeView: UILabel!
    @IBOutlet weak var budgetView: UILabel!
    @IBOutlet weak var revenueView: UILabel!
    @IBOutlet weak var awardsView: UILabel!
    @IBOutlet weak var languageView: UILabel!
    
    @IBOutlet weak var relatedMoviesCollectionView: UICollectionView!
    
    var movie: Movie? {
        didSet { bindFooter(movie: movie!) }
    }
    
    var movieRanking: MovieOMDB? {
        didSet { bindMovieRankings(movieRanking: movieRanking!) }
    }
    
    private func bindMovieRankings(movieRanking: MovieOMDB) {
        
    }
    
    private func bindFooter(movie: Movie) {
        
    }
}

extension MovieDetailsFooterCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    
}
