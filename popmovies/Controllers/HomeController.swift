//
//  HomeController.swift
//  popmovies
//
//  Created by Tiago Silva on 10/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit
import Hero

// MARK: HomeController: BaseViewController

class HomeController: BaseViewController {
    // MARK: Constants
    
    let HomeShowMovieListSegueIdentifier        = "HomeShowMovieListSegueIdentifier"
    let MovieDetailsSegueIdentifier             = "MovieDetailsSegueIdentifier"
    
    let NowPlayingMovieCellIdentifier           = "NowPlayingMovieCellIdentifier"
    let PopularMoviesCelldentifier              = "PopularMoviesCelldentifier"
    let TopRatedMoviesCellIdentifier            = "TopRatedMoviesCellIdentifier"
    let UpcomingMoviesCellIdentifier            = "UpcomingMoviesCellIdentifier"
    
    let MovieDetailsControllerIdentifier        = "MovieDetailsControllerIdentifier"
    
    let numberOfRows                            = 4
    
    // MARK: Outlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var logoImageView: UIImageView!
    
    // MARK: Properties
    
    var homePresenter: IHomePresenter!
    
    var nowPlayingMovies: [Movie]              = []
    var popularMovies: [Movie]                 = []
    var topRatedMovies: [Movie]                = []
    var upcomingMovies: [Movie]                = []
    
    // MARK: Lifecycle Methods
    
    override func viewWillAppear(_ animated: Bool) {
        hideNavigationBar(animated)
        
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        showNavigationBar(animated)
        
        super.viewWillDisappear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupPresenters()
    }
    
}

// MARK: UITableViewDataSource, UITableViewDelegate

extension HomeController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            return bindCell(tableView, cellForRowAt: indexPath, NowPlayingMovieCellIdentifier, nowPlayingMovies)
        case 1:
            return bindCell(tableView, cellForRowAt: indexPath, PopularMoviesCelldentifier, popularMovies)
        case 2:
            return bindCell(tableView, cellForRowAt: indexPath, TopRatedMoviesCellIdentifier, topRatedMovies)
        case 3:
            return bindCell(tableView, cellForRowAt: indexPath, UpcomingMoviesCellIdentifier, upcomingMovies)
        default:
            return UITableViewCell()
        }
    }
    
    private func bindCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath, _ cellIdentifier: String, _ movies: [Movie]) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MovieListCell else {
            return UITableViewCell()
        }
        
        cell.movieListCallback = self
        cell.movies = movies
        
        return cell
    }
    
}

// MARK: IHomeView

extension HomeController: IHomeView {
    
    func bindNowPlayingMovies(movies: [Movie]) {
        self.nowPlayingMovies = movies
        
        updateRow(itemIndex: 0)
    }
    
    func bindPopularMovies(movies: [Movie]) {
        self.popularMovies = movies
        
        updateRow(itemIndex: 1)
    }
    
    func bindTopRatedMovies(movies: [Movie]) {
        self.topRatedMovies = movies
        
        updateRow(itemIndex: 2)
    }
    
    func bindUpcomingMovies(movies: [Movie]) {
        self.upcomingMovies = movies
        
        updateRow(itemIndex: 3)
    }
    
    private func updateRow(itemIndex: Int) {
        let indexPath = IndexPath(item: itemIndex, section: 0)
        self.tableView.reloadRows(at: [indexPath], with: .left)
    }
}

// MARK: MovieListCallback

extension HomeController: MovieListCallback {
    
    func didSelectItem(index: Int, movie: Movie) {
        performSegue(withIdentifier: MovieDetailsSegueIdentifier, sender: movie)
    }
    
}

// MARK: Prepare Segues

extension HomeController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let cellIdentifier = sender as? String else {
            return
        }
        
        switch segue.identifier {
        case MovieDetailsSegueIdentifier:
            return MovieDetailsController.prepareMovieDetailsController(segue, sender)
        case HomeShowMovieListSegueIdentifier:
            return prepareBy(segue, cellIdentifier: cellIdentifier)
        default:
            return
        }
    }
    
    private func prepareBy(_ segue: UIStoryboardSegue, cellIdentifier: String) {
        switch cellIdentifier {
        case PopularMoviesCelldentifier:
            return MovieListController.preparePopularMovieList(segue: segue)
        case UpcomingMoviesCellIdentifier:
            return MovieListController.prepareUpcomingMovieList(segue: segue)
        case TopRatedMoviesCellIdentifier:
            return MovieListController.prepareTopRatedMovieList(segue: segue)
        default:
            return
        }
    }
}

// MARK: Setup Methods

private extension HomeController {
    
    func setupUI() {
        logoImageView.layer.cornerRadius = logoImageView.bounds.width / 2
        
        setupScreenTableView(tableView: self.tableView)
    }
    
    func setupPresenters() {
        homePresenter = HomePresenter(view: self)
        
        homePresenter.fetchNowPlayingMovies()
        homePresenter.fetchPopularMovies()
        homePresenter.fetchTopRatedMovies()
        homePresenter.fetchUpcomingMovies()
    }
}

// MARK: Actions Methods

private extension HomeController {
    
    @IBAction func didSeeAllPopularMoviesSelected() {
        performSegue(withIdentifier: HomeShowMovieListSegueIdentifier, sender: PopularMoviesCelldentifier)
    }
    
    @IBAction func didSeeAllUpcomingMoviesSelected() {
        performSegue(withIdentifier: HomeShowMovieListSegueIdentifier, sender: UpcomingMoviesCellIdentifier)
    }
    
    @IBAction func didSeeAllTopRatedMoviesSelected() {
        performSegue(withIdentifier: HomeShowMovieListSegueIdentifier, sender: TopRatedMoviesCellIdentifier)
    }
}
