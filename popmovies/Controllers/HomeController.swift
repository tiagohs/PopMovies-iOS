//
//  HomeController.swift
//  popmovies
//
//  Created by Tiago Silva on 10/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

class HomeController: BaseViewController {
    
    let nowPlayingMovieCellIdentifier           = "NowPlayingMovieCellIdentifier"
    let popularMoviesCelldentifier              = "PopularMoviesCelldentifier"
    let topRatedMoviesCellIdentifier            = "TopRatedMoviesCellIdentifier"
    let upcomingMoviesCellIdentifier            = "UpcomingMoviesCellIdentifier"
    
    let MovieDetailsControllerIdentifier             = "MovieDetailsControllerIdentifier"
    let movieDetailsSegueIdentifier             = "MovieDetailsSegueIdentifier"

    @IBOutlet weak var tableView: UITableView!
    
    var homePresenter: IHomePresenter?
    
    var nowPlayingMovies: [Movie]              = []
    var popularMovies: [Movie]                 = []
    var topRatedMovies: [Movie]                = []
    var upcomingMovies: [Movie]                = []
    
    var isNavbarColorPrimary = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homePresenter = HomePresenter(view: self)
        
        homePresenter?.fetchNowPlayingMovies()
        homePresenter?.fetchPopularMovies()
        homePresenter?.fetchTopRatedMovies()
        homePresenter?.fetchUpcomingMovies()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupScreenTableView(tableView: self.tableView)
        setupHomeNavigationBar()
    }
    
    private func setupHomeNavigationBar() {
        let searchButton = createNavigationBarButton(
            systemIcon: UIBarButtonItem.SystemItem.search,
            action: #selector(HomeController.didSearchButtonTaped))
        let profileButton = createNavigationBarButton(
            buttonBaseSize: 20,
            rounded: true,
            iconName: Constants.IMAGES.PLACEHOLDER_POSTER_PROFILE,
            iconColor: nil,
            action: #selector(HomeController.didProfileButtonTaped)
        )
        
        addRightButtonsToNavigationBar(buttons: [profileButton, searchButton])
    }
    
    @objc func didSearchButtonTaped() {
        
    }
    
    @objc func didProfileButtonTaped() {
        
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
    
    func bindNowPlayingMovies(movies: [Movie]) {
        self.nowPlayingMovies = movies
        
        let indexPath = IndexPath(item: 0, section: 0)
        self.tableView.reloadRows(at: [indexPath], with: .left)
    }
    
    func bindPopularMovies(movies: [Movie]) {
        self.popularMovies = movies
        
        let indexPath = IndexPath(item: 1, section: 0)
        self.tableView.reloadRows(at: [indexPath], with: .left)
    }
    
    func bindTopRatedMovies(movies: [Movie]) {
        self.topRatedMovies = movies
        
        let indexPath = IndexPath(item: 2, section: 0)
        self.tableView.reloadRows(at: [indexPath], with: .left)
    }
    
    func bindUpcomingMovies(movies: [Movie]) {
        self.upcomingMovies = movies
        
        let indexPath = IndexPath(item: 3, section: 0)
        self.tableView.reloadRows(at: [indexPath], with: .left)
    }
    
}

// MARK: UITableView Page

extension HomeController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: nowPlayingMovieCellIdentifier, for: indexPath) as! NowPlayingMoviesCell
            
            cell.movieListCallback = self
            cell.movies = nowPlayingMovies
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: popularMoviesCelldentifier, for: indexPath) as! PopularMoviesCell
            
            cell.movieListCallback = self
            cell.movies = popularMovies
            
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: topRatedMoviesCellIdentifier, for: indexPath) as! TopRatedMoviesCell
            
            cell.movieListCallback = self
            cell.movies = topRatedMovies
            
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: upcomingMoviesCellIdentifier, for: indexPath) as! UpcomingMoviesCell
            
            cell.movieListCallback = self
            cell.movies = upcomingMovies
            
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
