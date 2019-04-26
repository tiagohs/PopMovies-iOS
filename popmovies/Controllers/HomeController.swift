//
//  HomeController.swift
//  popmovies
//
//  Created by Tiago Silva on 10/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
    
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
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 690
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let nav = self.navigationController?.navigationBar
//
        nav?.setBackgroundImage(UIImage(), for: .default)
        nav?.shadowImage = UIImage()
        nav?.backgroundColor = .clear
        nav?.isTranslucent = true
        nav?.tintColor = ViewUtils.UIColorFromHEX(hex: Constants.Color.colorPrimary)
        
        let searchButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.search, target: self, action: #selector(HomeController.didSearchButtonTaped))
        
        var buttonSize = CGFloat(20)
        if let navHeight = nav?.frame.size.height {
            buttonSize = navHeight - CGFloat(10.0)
        }
        
        let menuBtn = UIButton(type: .custom)
        menuBtn.frame = CGRect(x: 0.0, y: 0.0, width: buttonSize, height: buttonSize)
        menuBtn.setImage(UIImage(named:"ProfilePlaceholder"), for: .normal)
        
        menuBtn.layer.cornerRadius = menuBtn.frame.size.height / 2
        menuBtn.layer.masksToBounds = true
        
        let profileButton = UIBarButtonItem(customView: menuBtn)
        let currWidth = profileButton.customView?.widthAnchor.constraint(equalToConstant: buttonSize)
        currWidth?.isActive = true
        let currHeight = profileButton.customView?.heightAnchor.constraint(equalToConstant: buttonSize)
        currHeight?.isActive = true
        
        navigationItem.rightBarButtonItems = [profileButton, searchButton]
    }
    
    @objc func didSearchButtonTaped() {
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let nav = self.navigationController?.navigationBar
        let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
        
        if (scrollView.contentOffset.y > 10 && !isNavbarColorPrimary) {
            nav?.backgroundColor = ViewUtils.UIColorFromHEX(hex: Constants.Color.colorPrimary)
            nav?.tintColor = UIColor.white
            nav?.barTintColor = UIColor.white
            nav?.barStyle = .blackTranslucent
            
            statusBar?.backgroundColor = ViewUtils.UIColorFromHEX(hex: Constants.Color.colorPrimary)
            
            isNavbarColorPrimary = true
        } else if scrollView.contentOffset.y <= 10 && isNavbarColorPrimary {
            nav?.setBackgroundImage(UIImage(), for: .default)
            nav?.shadowImage = UIImage()
            nav?.backgroundColor = .clear
            nav?.tintColor = ViewUtils.UIColorFromHEX(hex: Constants.Color.colorPrimary)
            nav?.barStyle = .default
            
            statusBar?.backgroundColor = UIColor.white
            
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
            cell.updateNowPlayingMoviesCollection(movies: nowPlayingMovies)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: popularMoviesCelldentifier, for: indexPath) as! PopularMoviesCell
            
            cell.movieListCallback = self
            cell.updatePopularMoviesCollection(movies: popularMovies)
            
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
