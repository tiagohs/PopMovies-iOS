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
    let movieDetailsSegueIdentifier             = "MovieDetailsSegueIdentifier"
    
    @IBOutlet weak var tableView: UITableView!
    
    var homePresenter: IHomePresenter?
    
    var nowPlayingMovies: [Movie]              = []
    var popularMovies: [Movie]                 = []
    
    var isNavbarColorPrimary = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homePresenter = HomePresenter(view: self)
        
        homePresenter?.fetchNowPlayingMovies()
        homePresenter?.fetchPopularMovies()
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
        let appIcon = createNavigationBarButton(
            buttonBaseSize: 40,
            rounded: false,
            iconName: Constants.IMAGES.APP_ICON,
            iconColor: nil,
            action: nil)
        
        addRightButtonsToNavigationBar(buttons: [profileButton, searchButton])
        addLeftButtonsToNavigationBar(buttons: [appIcon])
    }
    
    @objc func didSearchButtonTaped() {
        
    }
    
    @objc func didProfileButtonTaped() {
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let nav = self.navigationController?.navigationBar
        let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
        
        if (scrollView.contentOffset.y > 10 && !isNavbarColorPrimary) {
            nav?.backgroundColor = ViewUtils.UIColorFromHEX(hex: Constants.COLOR.colorPrimary)
            nav?.tintColor = UIColor.white
            nav?.barTintColor = UIColor.white
            nav?.barStyle = .blackTranslucent
            
            statusBar?.backgroundColor = ViewUtils.UIColorFromHEX(hex: Constants.COLOR.colorPrimary)
            
            self.navigationController?.title = "PopMovies"
            
            isNavbarColorPrimary = true
        } else if scrollView.contentOffset.y <= 10 && isNavbarColorPrimary {
            nav?.setBackgroundImage(UIImage(), for: .default)
            nav?.shadowImage = UIImage()
            nav?.backgroundColor = .clear
            nav?.tintColor = ViewUtils.UIColorFromHEX(hex: Constants.COLOR.colorPrimary)
            nav?.barStyle = .default
            
            statusBar?.backgroundColor = UIColor.white
            
            self.navigationController?.title = ""
            
            isNavbarColorPrimary = false
        }
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
    
}

// MARK: UITableView Page

extension HomeController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: nowPlayingMovieCellIdentifier, for: indexPath) as! NowPlayingMoviesCell
            
            cell.movieListCallback = self
            cell.movies = nowPlayingMovies
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: popularMoviesCelldentifier, for: indexPath) as! MovieListCell
            
            cell.movieListCallback = self
            cell.movies = nowPlayingMovies
            
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
