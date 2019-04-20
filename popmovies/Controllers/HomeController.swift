//
//  HomeController.swift
//  popmovies
//
//  Created by Tiago Silva on 10/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
    
    let featuresMovieCellIdentifier         = "FeaturesMovieCellIdentifier"
    let weekMoviesCellIdentifier            = "WeekMoviesCellIdentifier"
    let movieDetailsSegueIdentifier         = "MovieDetailsSegueIdentifier"
    
    @IBOutlet weak var tableView: UITableView!
    
    var homePresenter: IHomePresenter?
    
    var featureMovies: [Movie]              = []
    var weekMovies: [Movie]                 = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homePresenter = HomePresenter(view: self)
        homePresenter?.fetchPopularMovies()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        
        let nav = self.navigationController?.navigationBar
        
        nav?.setBackgroundImage(UIImage(), for: .default)
        nav?.shadowImage = UIImage()
        nav?.backgroundColor = .clear
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == movieDetailsSegueIdentifier) {
            let movie = sender as! Movie
            let movieDetailsController = segue.destination as! MovieDetailsController
            
            movieDetailsController.movie = movie
        }
    }
}

// MARK: IHomeView

extension HomeController: IHomeView {
    
    func bindFeatureMovies(featureMovies: [Movie]) {
        self.featureMovies = featureMovies
        
        let indexPath = IndexPath(item: 0, section: 0)
        self.tableView.reloadRows(at: [indexPath], with: .left)
    }
    
    func bindWeekMovies(weekMovies: [Movie]) {
        self.weekMovies = weekMovies
        
        let indexPath = IndexPath(item: 1, section: 0)
        self.tableView.reloadRows(at: [indexPath], with: .left)
    }
    
}

// MARK: UITableView Page

extension HomeController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: featuresMovieCellIdentifier, for: indexPath) as! FeatureMoviesCell
            
            cell.updateFeatureMoviesCollection(featureMovies: featureMovies)
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: weekMoviesCellIdentifier, for: indexPath) as! WeekMoviesCell
            
            cell.setMovieListCallback(movieListCallback: self)
            cell.updateWeekMoviesCollection(weekMovies: weekMovies)
            
            return cell
        default:
            return UITableViewCell()
        }
    }
    
}

// MARK: MovieListCallback

extension HomeController: MovieListCallback {
    
    func didSelectItem(index: Int, movie: Movie) {
        performSegue(withIdentifier: movieDetailsSegueIdentifier, sender: movie)
    }
    
}
