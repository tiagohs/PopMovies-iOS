//
//  MovieDetailsController.swift
//  popmovies
//
//  Created by Tiago Silva on 18/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation
import UIKit

class MovieDetailsController: UIViewController {
    
    let movieDetailsHeaderCellIdentifier = "MovieDetailsHeaderCellIdentifier"
    let movieDetailsMiddleCellIdentifier = "MovieDetailsMiddleCellIdentifier"
    let movieDetailsMidiaCellIdentifier = "MovieDetailsMidiaCellIdentifier"
    let movieDetailsFooterCellIdentifier = "MovieDetailsFooterCellIdentifier"
    
    @IBOutlet weak var tableView: UITableView!
    
    var movie: Movie? = nil
    var movieRankings: MovieOMDB? = nil
    
    var presenter: IMovieDetailsPresenter? = nil
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
        statusBar?.backgroundColor = UIColor.clear
        
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.barStyle = .black
        
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.backItem?.title = ""
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.navigationBar.barStyle = .default
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = MovieDetailsPresenter(view: self)
        presenter?.fetchMovieDetails(movieId: movie?.id)
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 690
    }
}

extension MovieDetailsController: IMovieDetailsView {
    
    func bindMovie(movie: Movie) {
        self.movie = movie
        
        self.tableView.reloadData()
    }
    
    func bindMovieRankings(movie: MovieOMDB) {
        self.movieRankings = movie
        
        let headerIndex = IndexPath(item: 0, section: 0)
        let middleIndex = IndexPath(item: 1, section: 0)
        let footerIndex = IndexPath(item: 3, section: 0)
        
        self.tableView.reloadRows(at: [headerIndex, middleIndex, footerIndex], with: .none)
    }
    
}

extension MovieDetailsController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: movieDetailsHeaderCellIdentifier, for: indexPath) as! MovieDetailsHeaderCell
            
            if (self.movie != nil) { cell.movie = self.movie }
            if (self.movieRankings != nil) { cell.movieRanking = self.movieRankings }
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: movieDetailsMiddleCellIdentifier, for: indexPath) as! MovieDetailsMiddleCell
        
            if (self.movie != nil) { cell.movie = self.movie }
            if (self.movieRankings != nil) { cell.movieRanking = self.movieRankings }
        
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: movieDetailsMidiaCellIdentifier, for: indexPath) as! MovieDetailsMidiaCell

            if (self.movie != nil) { cell.movie = self.movie }

            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: movieDetailsFooterCellIdentifier, for: indexPath) as! MovieDetailsFooterCell

            if (self.movie != nil) { cell.movie = self.movie }
            if (self.movieRankings != nil) { cell.movieRanking = self.movieRankings }

            return cell
        default:
            return UITableViewCell()
        }
    }
    
}


