//
//  MovieDetailsController.swift
//  popmovies
//
//  Created by Tiago Silva on 18/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation
import UIKit

class MovieDetailsController: BaseViewController {
    
    let movieDetailsHeaderCellIdentifier        = "MovieDetailsHeaderCellIdentifier"
    let movieDetailsContentCellIdentifier       = "MovieDetailsContentCellIdentifier"
    
    @IBOutlet weak var tableView: UITableView!
    
    var isTabMidiaConfigured = false
    
    var movie: Movie? = nil
    var movieRankings: MovieOMDB? = nil
    
    var presenter: IMovieDetailsPresenter? = nil
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupScreenTableView(tableView: tableView)
        setupMovieDetailsNavigationBar()
    }
    
    private func setupMovieDetailsNavigationBar() {
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.clear]
        
//        let shareIcon = createNavigationBarButton(
//            buttonBaseSize: 20,
//            rounded: false,
//            iconName: Constants.IMAGES.ICON_SHARE,
//            iconColor: UIColor.white,
//            action: #selector(MovieDetailsController.didShareButtonTaped)
//        )
//
//        addRightButtonsToNavigationBar(buttons: [shareIcon])
    }
    
    @objc func didShareButtonTaped() {
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.navigationBar.barStyle = .default
        self.navigationController?.navigationBar.tintColor = ViewUtils.UIColorFromHEX(hex: Constants.COLOR.colorPrimary)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = MovieDetailsPresenter(view: self)
        presenter?.fetchMovieDetails(movieId: movie?.id)
        
        self.title = movie?.title
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var offset = scrollView.contentOffset.y / 155
        
        if offset > 1 {
            offset = 1
            
            updateStatusBarStyle(offset: offset, barStyle: .default)
        } else {
            updateStatusBarStyle(offset: offset, barStyle: .black)
        }
    }
    
    private func updateStatusBarStyle(offset: CGFloat, barStyle: UIBarStyle) {
        let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
        
        self.navigationController?.navigationBar.tintColor = UIColor(hue: 0.725, saturation: offset, brightness: 1, alpha: 1)
        self.navigationController?.navigationBar.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: offset)
        statusBar?.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: offset)
        self.navigationController?.navigationBar.barStyle = barStyle
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 0, green: 0, blue: 0, alpha: offset)]
    }
}

extension MovieDetailsController: IMovieDetailsView {
    
    func bindMovie(movie: Movie) {
        self.movie?.credits = movie.credits
        self.movie?.keywords = movie.keywords
        self.movie?.runtime = movie.runtime
        self.movie?.videos = movie.videos
        self.movie?.images = movie.images
        self.movie?.homepage = movie.homepage
        self.movie?.productionCompanies = movie.productionCompanies
        self.movie?.productionCountries = movie.productionCountries
        self.movie?.similiarMovies = movie.similiarMovies
        
        self.tableView.reloadData()
    }
    
    func bindMovieRankings(movie: MovieOMDB) {
        self.movieRankings = movie
        
        let headerIndex = IndexPath(item: 0, section: 0)
        let middleIndex = IndexPath(item: 1, section: 0)
        
        self.tableView.reloadRows(at: [headerIndex, middleIndex], with: .none)
    }
    
    func bindMovieImages(images: Images) {
//        self.movie?.images = images
//        
//        let index = IndexPath(item: 1, section: 0)
//        
//        self.tableView.reloadRows(at: [index], with: .none)
    }
    
}

extension MovieDetailsController: TabBarCallback {
    
    func onTabBarSelect(index: Int) {
        if index == 0 && isTabMidiaConfigured { return }
        
        isTabMidiaConfigured = true
    }
    
}

extension MovieDetailsController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: movieDetailsHeaderCellIdentifier, for: indexPath) as! MovieDetailsHeaderCell
            
            if (self.movie != nil) { cell.movie = self.movie }
            if (self.movieRankings != nil) { cell.movieRanking = self.movieRankings }
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: movieDetailsContentCellIdentifier, for: indexPath) as! MovieDetailsContentCell
            
            cell.onInit()
            
            if (self.movie != nil) { cell.movie = self.movie }
            if (self.movieRankings != nil) { cell.movieRanking = self.movieRankings }
            
            return cell
        default:
            return UITableViewCell()
        }
    }
    
}


