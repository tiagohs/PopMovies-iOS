//
//  MovieListController.swift
//  popmovies
//
//  Created by Tiago Silva on 24/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit
import Hero

class MovieListController: BaseViewController {
    let MovieCellIdentifier             = "MovieCellIdentifier"
    
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    
    var movies: [Movie]?
    var presenter: IMovieListPresenter!
    
    var parameters: [String : String] = [:]
    var url: String?
    
    lazy var cellSize: CGSize = CGSize(width: self.moviesCollectionView.bounds.width / CGFloat(self.numberOfCollunms), height: (self.moviesCollectionView.bounds.width / CGFloat(self.numberOfCollunms)) + CGFloat(115))
    
    let numberOfCollunms = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNibs(collection: moviesCollectionView, nibName: "MovieCell", identifier: MovieCellIdentifier)
        
        self.presenter = MovieListPresenter(view: self)
        
        if movies == nil {
            showActivityIndicator()
            presenter.fetchMoviesFrom(url: url, parameters: parameters)
        }
    }
}

extension MovieListController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCellIdentifier, for: indexPath) as? MovieCell, let movies = self.movies else {
            return UICollectionViewCell()
        }
        let movie = movies[indexPath.row]
        
        cell.bindMovieCellDefault(movie: movie)
        
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        showActivityIndicator()
        presenter.fetchMoviesFrom(url: url, parameters: parameters)
    }
    
}

extension MovieListController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.cellSize
    }
}

extension MovieListController: HeroViewControllerDelegate {
    
    func heroWillStartAnimatingFrom(viewController: UIViewController) {
        moviesCollectionView.hero.modifiers = [.cascade, .delay(0.8)]
    }
}

extension MovieListController: IMovieListView {
    
    func bindMovies(movies: [Movie]) {
        if self.movies != nil {
            self.movies! += movies
        } else {
            self.movies = movies
        }
        
        moviesCollectionView.reloadData()
        hideActivityIndicator()
    }
    
}

extension MovieListController {
    
    static func preparePopularMovieList(segue: UIStoryboardSegue) {
        guard let controller = segue.destination as? MovieListController else {
            return
        }
        
        let url = TMDB.URL.MOVIES.POPULAR_MOVIES_URL
        let parameters = TMDB.URL.MOVIES.buildMovieListParameters()
        
        controller.url = url
        controller.parameters = parameters
    }
    
    static func prepareUpcomingMovieList(segue: UIStoryboardSegue) {
        guard let controller = segue.destination as? MovieListController else {
            return
        }
        
        let url = TMDB.URL.MOVIES.UPCOMING_MOVIES_URL
        let parameters = TMDB.URL.MOVIES.buildMovieListParameters()
        
        controller.url = url
        controller.parameters = parameters
    }
    
    static func prepareTopRatedMovieList(segue: UIStoryboardSegue) {
        guard let controller = segue.destination as? MovieListController else {
            return
        }
        
        let url = TMDB.URL.MOVIES.TOP_RATED_MOVIES_URL
        let parameters = TMDB.URL.MOVIES.buildMovieListParameters()
        
        controller.url = url
        controller.parameters = parameters
    }
    
}
