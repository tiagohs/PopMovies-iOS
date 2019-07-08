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
    
    let NowPlayingMovieCellIdentifier           = R.reuseIdentifier.nowPlayingMovieCell.identifier
    let PopularMoviesCelldentifier              = R.reuseIdentifier.popularMoviesCell.identifier
    let TopRatedMoviesCellIdentifier            = R.reuseIdentifier.topRatedMoviesCell.identifier
    let UpcomingMoviesCellIdentifier            = R.reuseIdentifier.upcomingMoviesCell.identifier
    
    let numberOfRows                            = 4
    
    // MARK: Outlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var logoImageView: UIImageView!
    
    // MARK: Properties
    
    var presenter: HomePresenterInterface?
    
    var nowPlayingMovies: [Movie]              = []
    var popularMovies: [Movie]                 = []
    var topRatedMovies: [Movie]                = []
    var upcomingMovies: [Movie]                = []
    
}

// MARK: Lifecycle Methods

extension HomeController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter?.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        presenter?.viewWillDisappear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.viewDidLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        presenter?.viewDidDisappear(animated)
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
        
        cell.movieListDelegate = self
        cell.movies = movies
        
        return cell
    }
    
}

// MARK: HomeViewInterface

extension HomeController: HomeViewInterface {
    
    func showNowPlayingMovies(with movies: [Movie]) {
        self.nowPlayingMovies = movies
        
        updateRow(itemIndex: 0)
    }
    
    func showPopularMovies(with movies: [Movie]) {
        self.popularMovies = movies
        
        updateRow(itemIndex: 1)
    }
    
    func showTopRatedMovies(with movies: [Movie]) {
        self.topRatedMovies = movies
        
        updateRow(itemIndex: 2)
    }
    
    func showUpcomingMovies(with movies: [Movie]) {
        self.upcomingMovies = movies
        
        updateRow(itemIndex: 3)
    }
    
    private func updateRow(itemIndex: Int) {
        let indexPath = IndexPath(item: itemIndex, section: 0)
        self.tableView.reloadRows(at: [indexPath], with: .left)
    }
}

// MARK: HomeViewInterface - Setup Methods

extension HomeController {
    
    func setupUI() {
        logoImageView.layer.cornerRadius = logoImageView.bounds.width / 2
        
        setupScreenTableView(tableView: self.tableView)
    }
}

// MARK: MovieListDelegate

extension HomeController: MovieListDelegate {
    
    func didSelectItem(index: Int, movie: Movie) {
        presenter?.didSelectMovie(movie)
    }
    
}

// MARK: Actions Methods

private extension HomeController {
    
    @IBAction func didSeeAllPopularMoviesSelected() {
        presenter?.didSelectSeeAllPopularMovies()
    }
    
    @IBAction func didSeeAllUpcomingMoviesSelected() {
        presenter?.didSelectSeeAllUpcomingMovies()
    }
    
    @IBAction func didSeeAllTopRatedMoviesSelected() {
        presenter?.didSelectSeeAllTopRatedMovies()
    }
    
    @IBAction func didSearchClicked(_ sender: Any) {
        presenter?.didSearchClicked()
    }
}
